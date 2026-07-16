#!/usr/bin/env python3
"""Generate a voice line with the ElevenLabs API — chapter 11's "door C of voices".

Frontier voices with acting range, pay-per-character (a game's worth of
barks costs a couple of dollars). Standard library only, same pattern as
generate_sprite.py:

    python generate_speech_elevenlabs.py "Flush Rush. ...Good luck." \
        --out assets/voice/title.mp3

The key is read from the ELEVENLABS_API_KEY environment variable, or from
a .env file in the current directory or any parent (ELEVENLABS_API_KEY=...).
Get one at elevenlabs.io; browse voice IDs in their Voice Library.

Disclosure notes (chapter 15): synthetic voice is AI content — it goes on
the form. Cloning or imitating a REAL person's voice without written
permission is a hard no, everywhere.
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path

API_URL = "https://api.elevenlabs.io/v1/text-to-speech/{voice_id}"
DEFAULT_VOICE = "21m00Tcm4TlvDq8ikWAM"  # "Rachel", the classic default


def find_api_key() -> str | None:
    key = os.environ.get("ELEVENLABS_API_KEY")
    if key:
        return key.strip()
    for folder in [Path.cwd(), *Path.cwd().parents]:
        env_path = folder / ".env"
        if not env_path.is_file():
            continue
        for line in env_path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if line.startswith("ELEVENLABS_API_KEY=") and not line.startswith("#"):
                return line.split("=", 1)[1].strip().strip('"').strip("'")
    return None


def generate(text: str, out_path: Path, voice_id: str, model_id: str,
             stability: float, similarity: float) -> None:
    api_key = find_api_key()
    if not api_key:
        sys.exit("No key found. Set ELEVENLABS_API_KEY in your environment or .env.")

    payload = {
        "text": text,
        "model_id": model_id,
        "voice_settings": {"stability": stability, "similarity_boost": similarity},
    }
    request = urllib.request.Request(
        API_URL.format(voice_id=voice_id),
        data=json.dumps(payload).encode("utf-8"),
        headers={"Content-Type": "application/json", "xi-api-key": api_key},
    )
    print(f"Generating: {text!r} (voice {voice_id})...")
    try:
        with urllib.request.urlopen(request, timeout=120) as response:
            audio = response.read()
    except urllib.error.HTTPError as err:
        sys.exit(f"API error {err.code}: {err.read().decode('utf-8', errors='replace')}")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_bytes(audio)
    print(f"Saved {out_path} ({len(audio) // 1024} KB)")
    print("CREDITS.txt line: what it is, what made it, and the disclosure note.")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("text", help="the line to speak (punctuation is direction)")
    parser.add_argument("--out", type=Path, default=Path("speech.mp3"),
                        help="output audio path (default: speech.mp3)")
    parser.add_argument("--voice", default=DEFAULT_VOICE,
                        help="voice ID from the ElevenLabs Voice Library")
    parser.add_argument("--model", default="eleven_multilingual_v2",
                        help="model id (default: eleven_multilingual_v2)")
    parser.add_argument("--stability", type=float, default=0.5)
    parser.add_argument("--similarity", type=float, default=0.75)
    args = parser.parse_args()
    generate(args.text, args.out, args.voice, args.model, args.stability, args.similarity)


if __name__ == "__main__":
    main()
