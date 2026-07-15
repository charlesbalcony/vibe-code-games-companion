# Checkpoint ch06-1 — "plunger rain and death by clogging"

**Book location:** Chapter 6, after the screwup gets fixed.
**Previous checkpoint:** `ch05-1-duck-moves-clamps-bobs`.
**What changed:** `scripts/faller.gd` (plungers) and `scripts/main.gd`
(spawning + game over) exist; the player finally has a collision shape
(the chapter's kept screwup — the "ghost duck").

## State of the game

Plungers rain at a fixed, polite pace. Touch one: **CLOGGED!**, and
any key restarts fresh. No score, no ramp, no variation — the rain is
honest but boring. That's ch06-2's job.

## The prompts that got here (copy-paste friendly)

The staged build — watch the rain before it can hurt you:

> Add falling hazards. Plungers — draw them in code like the duck (a
> stick with a red cup is plenty) — spawn at random horizontal
> positions above the screen and fall straight down. They should
> appear every second or so, and clean themselves up when they leave
> the bottom. Nothing hurts the duck yet — I just want to watch the
> rain first. Script in scripts/faller.gd.

Then the danger:

> Now the danger: if a plunger touches the duck, the game ends. Freeze
> everything and show big text that says "CLOGGED!" and, under it,
> "press any key to re-flush". Any key restarts the game fresh.

Then — the book keeps its screwups — the plungers passed straight
through the duck, and the symptom report that fixed it:

> Plungers pass right through the duck. No CLOGGED, no reaction, no
> error — they just overlap and keep going.

(The cause: the duck had no collision shape. Your agent may not make
this mistake — or may make a different one. The *rhythm* is the
lesson: run it, report the symptom, no diagnosis needed.)

And the save point:

> Great. Commit as "plunger rain and death by clogging".

## What to check when you run it

- Plungers fall at a steady 0.9s-ish cadence, straight down.
- Standing under one ends the run: CLOGGED!, any key re-flushes.
- Restart actually resets everything (duck position, rain).
- It's boring after ~30 seconds. Correct. Proceed to ch06-2.
