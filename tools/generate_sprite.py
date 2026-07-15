#!/usr/bin/env python3
"""Generate a transparent-background PNG game sprite with the OpenAI image API.

Made for the book "Vibe Code Video Games While You Poop": drop your
OPENAI_API_KEY in a .env file in your project folder, then tell your coding
agent to use this script. It needs only the Python standard library, so it
runs the same on Windows, Mac, and Linux with no pip installs.

Usage:
    python generate_sprite.py "a rubber duck, cute 2D game sprite" --out duck.png
    python generate_sprite.py "red plunger, cartoon style" --out plunger.png --size 1024x1536

The key is read from the OPENAI_API_KEY environment variable, or from a
.env file found in the current directory or any parent (line format:
OPENAI_API_KEY=sk-...).
"""
from __future__ import annotations

import argparse
import base64
import json
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path

API_URL = "https://api.openai.com/v1/images/generations"

# Baked into every request so each sprite comes back game-ready instead of
# as a photorealistic painting with a scenic background.
STYLE_SUFFIX = (
    ", 2D video game sprite, single object centered, no background, "
    "clean silhouette, no text, no watermark"
)


def find_api_key() -> str | None:
    key = os.environ.get("OPENAI_API_KEY")
    if key:
        return key.strip()
    for folder in [Path.cwd(), *Path.cwd().parents]:
        env_path = folder / ".env"
        if not env_path.is_file():
            continue
        for line in env_path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if line.startswith("OPENAI_API_KEY=") and not line.startswith("#"):
                return line.split("=", 1)[1].strip().strip('"').strip("'")
    return None


def generate(prompt: str, out_path: Path, size: str, quality: str, model: str,
             style_suffix: bool = True, transparent: bool = True) -> None:
    api_key = find_api_key()
    if not api_key:
        sys.exit(
            "No API key found. Set the OPENAI_API_KEY environment variable, or put\n"
            "OPENAI_API_KEY=sk-... in a .env file in your project folder."
        )

    payload = {
        "model": model,
        "prompt": prompt + (STYLE_SUFFIX if style_suffix else ""),
        "size": size,
        "quality": quality,
        "background": "transparent" if transparent else "opaque",
        "output_format": "png",
        "n": 1,
    }
    request = urllib.request.Request(
        API_URL,
        data=json.dumps(payload).encode("utf-8"),
        headers={
            "Content-Type": "application/json",
            "Authorization": f"Bearer {api_key}",
        },
    )

    print(f"Generating: {prompt!r} ({size}, quality={quality}, model={model})...")
    try:
        with urllib.request.urlopen(request, timeout=300) as response:
            body = json.load(response)
    except urllib.error.HTTPError as err:
        detail = err.read().decode("utf-8", errors="replace")
        sys.exit(f"API error {err.code}: {detail}")

    image_b64 = body["data"][0]["b64_json"]
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_bytes(base64.b64decode(image_b64))
    print(f"Saved {out_path} ({out_path.stat().st_size // 1024} KB)")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("prompt", help="what the sprite should be")
    parser.add_argument("--out", type=Path, default=Path("sprite.png"),
                        help="output PNG path (default: sprite.png)")
    parser.add_argument("--size", default="1024x1024",
                        choices=["1024x1024", "1536x1024", "1024x1536", "auto"],
                        help="generated image size (scale it down in-engine)")
    parser.add_argument("--quality", default="medium",
                        choices=["low", "medium", "high", "auto"],
                        help="quality/cost tradeoff (default: medium)")
    parser.add_argument("--model", default="gpt-image-1",
                        help="image model id (default: gpt-image-1; use gpt-image-2 if available)")
    parser.add_argument("--no-style-suffix", action="store_true",
                        help="skip the game-sprite style suffix (for infographics, covers, etc.)")
    parser.add_argument("--opaque", action="store_true",
                        help="opaque background instead of transparent (for infographics)")
    args = parser.parse_args()
    generate(args.prompt, args.out, args.size, args.quality, args.model,
             style_suffix=not args.no_style_suffix, transparent=not args.opaque)


if __name__ == "__main__":
    main()
