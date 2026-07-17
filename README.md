# Vibe Code Video Games While You Poop — Companion Repo

The official companion to **_Vibe Code Video Games While You Poop_** by
Charles Balcony — a field guide to directing AI coding agents through
building real, finished Godot games in twelve-minute sittings.

**📖 The book lands on Amazon (Kindle) soon — the link will live right
here. Watch this repo to catch launch week.**

**🦆 Want to play the game the book builds?** Grab
[`checkpoints/ch12-1-v2-the-glow-up`](checkpoints/ch12-1-v2-the-glow-up)
and double-click `run.bat` (Windows) or `./run.sh` (Mac/Linux). That's
the finished thing — sprites, music, a pipe with a history of poor
maintenance.

Everything here exists so you can
**compare what your agent did to what ours did** at every save point in
the build — and copy-paste the exact prompts if you want to.

## The one important thing to know

Your version will not match ours line for line, and that is not a
problem — coding agents are nondeterministic, and the book teaches a
*rhythm*, not a script. Use these checkpoints when:

- you want to **see a known-good version** of where you should be,
- your project went sideways and you want to **restart from a save
  point** instead of from zero,
- you want to **copy-paste the prompts** instead of typing them from
  the book (each checkpoint's README has them, in order),
- you skipped ahead and need a starting state for a later chapter.

## How to use a checkpoint (no git required)

1. Download this repo (green **Code** button → **Download ZIP**) or
   clone it.
2. Open any folder in `checkpoints/` — each one is a **complete,
   runnable Godot project**.
3. Double-click `run.bat` (Windows — edit the Godot path inside if
   needed) or `./run.sh` (Mac/Linux), or import the folder in the
   Godot editor.
4. Read the folder's `README.md`: what state the game is in, what
   changed since the last checkpoint, the prompts that got it here,
   and what to check when it runs.

## Checkpoint map

One checkpoint per commit the book makes. (Later checkpoints arrive as
the book's chapters are finalized.)

| Checkpoint | Book location | The game can... |
|---|---|---|
| `ch03-1-project-skeleton` | Ch. 3, "project skeleton" + "smoke test passes" | boot to IT'S ALIVE |
| `ch05-1-duck-moves-clamps-bobs` | Ch. 5, end of session one | move a bobbing duck, walls included |
| `ch06-1-plunger-rain-and-death` | Ch. 6, "plunger rain and death by clogging" | kill you (CLOGGED!), restart on any key |
| `ch06-2-ramp-organic-rain-hitbox` | Ch. 6, "difficulty ramp, organic rain, forgiving hitbox" | start gentle, get mean, lie kindly about your hitbox |
| `ch07-1-score-with-the-heist-bug` | Ch. 7, mid-session — **deliberately broken** | score bubbles but not survival (find out why!) |
| `ch07-2-heist-fixed` | Ch. 7, "the great zero-points heist" fixed | tick the survival score properly |
| `ch07-3-juice-pass` | Ch. 7, end of session three | pop, punch, freeze, SHAKE, and wink at your near-misses |
| `ch08-1-menus-and-memory` | Ch. 8, end of session four | boot to a menu, pause, remap keys, remember your best forever |
| `ch09-1-v1-0-shipped` | Ch. 9, `v1.0: shipped to itch.io` | credit its maker (the export/itch steps are in its README) |
| `ch10-1-the-great-reskin-part-1` | Ch. 10, end | wear real sprites (hitboxes untouched, style bible in CLAUDE.md) |
| `ch11-1-the-game-has-ears` | Ch. 11, end | loop its theme, pop, whoosh, sting after the freeze, click |
| `ch12-1-v2-the-glow-up` | Ch. 12, `v2.0` | the full montage: world, logo, CLOGGED art, icon, NEW BEST zing |

Bonus: this repo's **git history** mirrors the book — each checkpoint
was committed with the book's own commit message, so `git log` reads
like the story, and chapter 14's bisect exercise has a practice arena.

## Also in here

- `assets/` — the actual generated game assets from Part III: sprites
  (AI, transparent PNG), music (local MusicGen, **non-commercial
  license — read `assets/CREDITS.txt`**), synthesized SFX, and
  optional announcer voice lines (local Qwen3-TTS). Can't run the
  generators yet? Use these and keep reading.
- `tools/` — `generate_sprite.py` (ch. 10: OpenAI API → transparent
  PNG sprites), `generate_music.py` (ch. 11: local MusicGen music),
  `generate_sfx.py` (ch. 11: zero-dependency retro SFX — and it's
  clay: ask your agent to add new sounds to it), and
  `generate_speech_elevenlabs.py` (ch. 11: frontier voices by API).
- `templates/` — the starter `CLAUDE.md` house rules, `.env.example`,
  and launcher scripts, ready to copy into a new project.
- `prompts/prompt-cookbook.md` — Appendix B: every load-bearing prompt
  pattern from the book as fill-in templates.

## License

Code and project files: MIT (see `LICENSE`). The book's text is not in
this repo and is not covered by it.
