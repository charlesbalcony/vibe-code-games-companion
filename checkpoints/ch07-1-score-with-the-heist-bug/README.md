# Checkpoint ch07-1 — score with the heist bug (DELIBERATELY BROKEN)

**Book location:** Chapter 7, mid-session — right after the bubbles
land and right before anyone looks closely at the score.
**Previous checkpoint:** `ch06-2-ramp-organic-rain-hitbox`.
**What changed:** soap bubbles (a second faller kind, worth 25),
a `GameState` autoload holding the score, a score label — and one
plausible-looking line that has never added a single point.

## State of the game — read this before running it

This checkpoint preserves **the best bug in the book**, live, so you
can watch plausible code fail with your own eyes. It's a real bug from
the real development of this game: the survival score adds
`int(delta * 10)` every frame — about `int(0.16)` — which rounds down
to **zero**, sixty times a second, forever. The game runs perfectly.
No errors. Bubbles score. The survival trickle simply... doesn't.

Run it and watch the score between bubbles. Watch a little longer.
That frozen number is what chapter 4 means by *plausible is the
problem* — and nothing was ever going to catch it except someone
playing the game while caring about the score.

## The prompts that got here (copy-paste friendly)

> Add pickups: soap bubbles that fall like the plungers do (slower, no
> tumble — they're bubbles). Catching one is +25 points. Also add a
> score that ticks up slowly just for staying alive — say 10 points a
> second — and show the score top-left. Keep the score logic in an
> autoload so it survives the scene reload when we restart. Bubbles
> should be clearly friendly at a glance — nobody should ever have to
> learn by dying that the round thing was food.

(Your agent may write this feature *correctly* the first time — the
bug is not guaranteed, only the lesson: **run it and check.**)

## What to check when you run it

- Bubbles drift down gently among the tumbling plungers, visibly
  friendly.
- Catching one: +25, instantly.
- The survival trickle: **frozen.** That's the bug. Sit with it.
- Then go to `ch07-2-heist-fixed` for the symptom report that ends it.
