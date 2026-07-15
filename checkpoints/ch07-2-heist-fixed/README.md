# Checkpoint ch07-2 — "score: survival trickle plus bubble bonuses (and the great zero-points heist)"

**Book location:** Chapter 7, right after the heist is solved.
**Previous checkpoint:** `ch07-1-score-with-the-heist-bug` (broken on
purpose).
**What changed:** one bug fix in `scripts/main.gd` — the survival
score now pools fractional points in an accumulator and banks them
when they reach a whole number. Diff the two `main.gd` files; the
whole heist is about six lines.

## State of the game

Score ticks steadily at 10/second, bubbles burst for 25, the game-over
screen reports your total. Everything chapter 7's first half promised,
actually true this time.

## The prompt that got here (copy-paste friendly)

The symptom report — precise symptoms are the luxury version:

> Bubble points work, but the survival score never ticks. It stays
> frozen at whatever the last bubble made it — I watched for twenty
> seconds and it never moved on its own.

And the save point:

> Commit as "score: survival trickle plus bubble bonuses (and the
> great zero-points heist)".

## What to check when you run it

- The score ticks up on its own, ~10 per second. Tick, tick, tick.
- Bubbles still +25 on top.
- Compare `scripts/main.gd` against ch07-1's — this is a great
  first diff to read: small, self-contained, and you already know
  both the crime and the arrest.

## What's next

`ch07-3-juice-pass` (particles, hit-stop, screen shake, the near-miss
wink) — coming as chapter 7's final state is locked.
