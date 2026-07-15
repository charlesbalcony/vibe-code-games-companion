#!/usr/bin/env python3
"""Generate game music with an open-weight MusicGen model, locally on your GPU.

Companion tool for chapter 11 of "Vibe Code Video Games While You Poop".
Prompt in, WAV out:

    python generate_music.py "goofy determined chiptune-funk, bouncy bassline" \
        --duration 60 --out assets/music/theme.wav

Unlike generate_sprite.py this one has real dependencies (it runs a neural
network instead of calling an API):

    pip install torch transformers

First run downloads the model (a few GB). VRAM guide: musicgen-small ~4GB,
musicgen-medium ~8GB, musicgen-stereo-large ~16GB. Pick with --model.

LICENSE NOTE (chapter 11's sermon): MusicGen weights are licensed
CC-BY-NC 4.0 — NON-COMMERCIAL. Fine for learning, prototypes, and free
games; not for a game you sell. For commercial projects use a model whose
weights license allows it, and log every asset in your CREDITS.txt.
"""
from __future__ import annotations

import argparse
import sys
import wave
from pathlib import Path

# MusicGen generates ~50 audio tokens per second of music.
TOKENS_PER_SECOND = 50
MAX_DURATION = 120  # memory and quality both degrade past this; stitch instead

MODELS = {
    "small": "facebook/musicgen-small",
    "medium": "facebook/musicgen-medium",
    "large": "facebook/musicgen-large",
    "stereo-small": "facebook/musicgen-stereo-small",
    "stereo-medium": "facebook/musicgen-stereo-medium",
    "stereo-large": "facebook/musicgen-stereo-large",
}


def generate(prompt: str, out_path: Path, duration: float, model_key: str) -> None:
    try:
        import torch
        from transformers import AutoProcessor, MusicgenForConditionalGeneration
    except ImportError:
        sys.exit(
            "Missing dependencies. Run:  pip install torch transformers\n"
            "(Or, per the book: tell your coding agent to set this up for you.)"
        )

    if duration > MAX_DURATION:
        sys.exit(f"--duration is capped at {MAX_DURATION}s per generation; "
                 "generate sections and let your agent stitch them.")

    model_id = MODELS.get(model_key, model_key)
    device = "cuda" if torch.cuda.is_available() else "cpu"
    if device == "cpu":
        print("WARNING: no CUDA GPU detected — this will run on CPU and take "
              "many minutes. Doors B and C from chapter 11 exist for a reason.")

    print(f"Loading {model_id} on {device} (first run downloads the model)...")
    processor = AutoProcessor.from_pretrained(model_id)
    model = MusicgenForConditionalGeneration.from_pretrained(model_id).to(device)

    inputs = processor(text=[prompt], return_tensors="pt").to(device)
    max_tokens = int(duration * TOKENS_PER_SECOND)

    print(f"Generating {duration:.0f}s of music: {prompt!r} ...")
    with torch.no_grad():
        audio = model.generate(**inputs, max_new_tokens=max_tokens, do_sample=True)

    sample_rate = model.config.audio_encoder.sampling_rate
    # audio shape: (batch, channels, samples), float in [-1, 1]
    samples = audio[0].cpu().float().numpy()
    channels = samples.shape[0]
    pcm = (samples.clip(-1.0, 1.0) * 32767.0).astype("<i2")

    out_path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(out_path), "wb") as wav:
        wav.setnchannels(channels)
        wav.setsampwidth(2)
        wav.setframerate(sample_rate)
        wav.writeframes(pcm.T.tobytes())

    seconds = samples.shape[1] / sample_rate
    print(f"Saved {out_path} ({seconds:.1f}s, {channels}ch, {sample_rate}Hz)")
    print("Remember the CREDITS.txt line: what it is, what made it, the license.")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("prompt", help="vibe, instrumentation, tempo, purpose")
    parser.add_argument("--out", type=Path, default=Path("music.wav"),
                        help="output WAV path (default: music.wav)")
    parser.add_argument("--duration", type=float, default=30.0,
                        help=f"seconds of music, max {MAX_DURATION} (default: 30)")
    parser.add_argument("--model", default="small",
                        help="small|medium|large|stereo-small|stereo-medium|"
                             "stereo-large, or a HF model id (default: small)")
    args = parser.parse_args()
    generate(args.prompt, args.out, args.duration, args.model)


if __name__ == "__main__":
    main()
