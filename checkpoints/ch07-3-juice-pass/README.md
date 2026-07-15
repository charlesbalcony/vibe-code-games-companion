# Checkpoint ch07-3 — "juice pass: pops, punches, hit-stop, shake, and near-miss flirtation"

**Book location:** Chapter 7, end of session three.
**Previous checkpoint:** `ch07-2-heist-fixed`.
**What changed:** bubble catches burst into particles and punch the
score label; death does a hit-stop freeze then a screen shake (there's
a Camera2D now, just for the shaking); hazards detect near-misses and
the game rewards them with a "CLOSE! +5" and an amber streak.

## State of the game

Same mechanics as ch07-2 — and a completely different game to *play*.
Death is an event. Bubbles feel like little victories. And watch your
own behavior: you'll start drifting *toward* plungers, because the
near-miss bonus turned recklessness into a strategy. Juice isn't
paint; done right, it's incentive design wearing a party hat.

## The prompts that got here (copy-paste friendly)

> Juice pass! When I catch a bubble: a little pop of particles and the
> score should punch — scale up and settle back. When a plunger gets
> me: freeze the whole game for a tenth of a second, shake the screen,
> then show CLOGGED. Death should feel like an EVENT, not an email.

Then the invented-on-the-spot moment (invent your own — that's the
assignment):

> The last seconds before a near-miss are the best part of the game
> and nothing celebrates them. When a plunger misses me by a whisker,
> gimme SOMETHING — a tiny time-slow, a whoosh of particles, anything
> that says "the game saw that."

Save point:

> Commit as "juice pass: pops, punches, hit-stop, shake, and near-miss
> flirtation".

## What to check when you run it

- Catch a bubble: pop + the score does a happy little flex.
- Die on purpose: freeze... then SHAKE, then CLOGGED. Do it twice.
  Everyone does it twice.
- Court a plunger: "CLOSE! +5" floats up. Notice you're now doing it
  on purpose.
- Your juice will differ from ours — particles, timing, feel. Juice is
  taste. Compare the *presence* of the moments, not their exact shape.
