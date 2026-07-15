#!/usr/bin/env python3
"""Synthesize retro arcade sound effects — no AI, no dependencies, no GPU.

Companion tool for chapter 11's honest section: for bleeps and bloops,
classic synthesis beats neural networks. This is a tiny jsfxr-style
generator using only the Python standard library, so it runs anywhere:

    python generate_sfx.py --out assets/sfx

It writes the book's five-effect shopping list: pop (bubble catch),
whoosh (near-miss), sting (death, plays AFTER the hit-stop), click
(menu), zing (bonus/celebration). All public domain — do whatever.
"""
from __future__ import annotations

import argparse
import math
import random
import struct
import wave
from pathlib import Path

RATE = 22050


def _write(path: Path, samples: list[float]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with wave.open(str(path), "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(RATE)
        frames = b"".join(
            struct.pack("<h", int(max(-1.0, min(1.0, s)) * 32000)) for s in samples
        )
        w.writeframes(frames)
    print(f"Saved {path} ({len(samples) / RATE:.2f}s)")


def _env(i: int, n: int, attack: float = 0.01, decay: float = 4.0) -> float:
    t = i / n
    a = min(1.0, t / max(attack, 1e-6))
    return a * math.exp(-decay * t)


def pop() -> list[float]:
    """Bubble catch: a happy little blip, pitch rising as it dies."""
    n = int(RATE * 0.09)
    out = []
    phase = 0.0
    for i in range(n):
        f = 500.0 + 700.0 * (i / n)
        phase += 2 * math.pi * f / RATE
        out.append(math.sin(phase) * _env(i, n, 0.005, 5.0) * 0.8)
    return out


def whoosh() -> list[float]:
    """Near-miss: filtered noise sweeping past your ear."""
    n = int(RATE * 0.28)
    out = []
    prev = 0.0
    for i in range(n):
        t = i / n
        # crude lowpass: blend of noise and previous sample; the blend
        # sweeps so the noise "opens up" then closes — a passing object
        cutoff = 0.15 + 0.7 * math.sin(math.pi * t)
        prev = prev * (1 - cutoff) + random.uniform(-1, 1) * cutoff
        out.append(prev * math.sin(math.pi * t) * 0.7)
    return out


def sting() -> list[float]:
    """Death: three descending notes with a bit of grit. Plays after
    the hit-stop — silence, THEN drama."""
    notes = [220.0, 164.8, 110.0]
    out = []
    for idx, f in enumerate(notes):
        n = int(RATE * (0.12 if idx < 2 else 0.28))
        phase = 0.0
        for i in range(n):
            phase += 2 * math.pi * f / RATE
            s = math.sin(phase) + 0.4 * math.sin(2 * phase)
            s = max(-0.7, min(0.7, s))  # soft clip = grit
            out.append(s * _env(i, n, 0.01, 2.5 if idx < 2 else 3.5))
    return out


def click() -> list[float]:
    """Menu click: short, dry, satisfying."""
    n = int(RATE * 0.03)
    out = []
    phase = 0.0
    for i in range(n):
        phase += 2 * math.pi * 1100.0 / RATE
        square = 0.6 if math.sin(phase) >= 0 else -0.6
        out.append(square * _env(i, n, 0.001, 8.0))
    return out


def zing() -> list[float]:
    """Bonus: a fast rising chirp that says 'the game saw that.'"""
    n = int(RATE * 0.18)
    out = []
    phase = 0.0
    for i in range(n):
        t = i / n
        f = 600.0 * (4.0 ** t)  # 600 -> 2400 Hz
        phase += 2 * math.pi * f / RATE
        vibrato = 1.0 + 0.15 * math.sin(2 * math.pi * 30 * t)
        out.append(math.sin(phase * vibrato) * _env(i, n, 0.01, 3.0) * 0.7)
    return out


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", type=Path, default=Path("sfx"),
                        help="output folder (default: ./sfx)")
    args = parser.parse_args()
    random.seed(42)  # same farts every time; delete this line for chaos
    for name, fn in [("pop", pop), ("whoosh", whoosh), ("sting", sting),
                     ("click", click), ("zing", zing)]:
        _write(args.out / f"{name}.wav", fn())
    print("Remember CREDITS.txt: synthesized, public domain, go nuts.")


if __name__ == "__main__":
    main()
