# Checkpoint ch06-2 — "difficulty ramp, organic rain, forgiving hitbox"

**Book location:** Chapter 6, end of session two.
**Previous checkpoint:** `ch06-1-plunger-rain-and-death`.
**What changed:** the rain ramps (speed and spawn rate scale with
survival time), plungers vary ±15% in speed and tumble as they fall,
and the duck's hitbox shrank to 80% of its drawn size.

## State of the game

A real difficulty curve: gentle open, rising pulse, genuinely mean
past the first minute. The rain feels organic instead of mechanical,
and near-misses feel *fair* — because the hitbox is quietly smaller
than the duck. The good kind of lie.

## The prompts that got here (copy-paste friendly)

First, make the knobs visible (steal this trick forever):

> List the current game-feel numbers — spawn rate, fall speed,
> anything tunable — as a table with one line each on what it does.

Then tune with feelings, not numbers:

> It's way too polite. I want to feel busy from the first second —
> more rain, and make it fall with a bit more menace.

> Too hard too soon, but I don't want it slower overall — I want it to
> START gentle and get mean. Can the meanness grow the longer I
> survive?

> The plungers fall dead straight and identical, like barcodes. Make
> the rain feel more alive — a little variation between plungers,
> maybe a lazy tumble as they fall. More Nintendo, less spreadsheet.

And the difficult-vs-unfair fix:

> Sometimes a plunger barely grazes the duck's edge and it counts as a
> hit — it feels cheap. Shrink the duck's hitbox a bit smaller than it
> looks, so near-misses stay misses.

Save point:

> Perfect. Commit as "difficulty ramp, organic rain, forgiving hitbox".

## What to check when you run it

- First ~15 seconds: gentle. Past ~45: mean. Death: earned.
- Plungers tumble and fall at visibly different speeds.
- Grazing shots that *look* close now miss. It feels like skill. It's
  partly a lie. Enjoy it.
- Your exact numbers WILL differ from ours — tuning is taste, and the
  agent tuned to *your* adjectives. Compare the shape, not the values.
