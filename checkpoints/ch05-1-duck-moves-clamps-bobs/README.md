# Checkpoint ch05-1 — "player duck: movement, clamping, idle bob"

**Book location:** Chapter 5, end of session one.
**Previous checkpoint:** `ch03-1-project-skeleton`.
**What changed:** the IT'S ALIVE label is gone; `scripts/player.gd`
exists; Main is now a game scene with a Player node.

## State of the game

A code-drawn rubber duck sits near the bottom, bobbing gently. Arrow
keys (and A/D) move it, and it can't leave the screen. Nothing falls,
nothing hurts, nothing scores. A thing that moves.

Note what it does NOT have yet: the duck has no collision shape —
it's drawn art with no physics body. That's not an oversight; it's
chapter 6's screwup, preserved honestly.

## The prompts that got here (copy-paste friendly)

> In scenes/Main.tscn, replace the IT'S ALIVE label with a player for a
> one-thumb arcade game:
>
> - The player is a rubber duck near the bottom of the screen. No image
>   files — draw it in code with simple shapes (a yellow circle is
>   fine). Placeholder art is the plan, not a compromise.
> - Left/right arrow keys move it horizontally. Nothing else moves yet.
> - Put its script at scripts/player.gd, and put the movement speed in
>   a named constant.
>
> When you're done, tell me to run it and what I should check.

Then, after playtesting found the duck could leave the screen:

> The duck can slide right off the edge of the screen and disappear.
> Keep it fully on screen at both edges.

Then the feel pass:

> Movement feels sluggish — this game is going to be about dodging, so
> it should feel darty and immediate. Also the duck feels weirdly
> *still* when standing — could it bob gently in place like it's
> floating on water?

And the save point:

> Perfect. Commit this as "player duck: movement, clamping, idle bob".

## What to check when you run it

- Arrows and A/D move the duck; it feels quick ("darty").
- Hold either direction: the duck stops flush at the screen edge,
  whole body visible.
- At rest, the duck bobs a few pixels, like it's floating.
- Your duck may be a different shape, speed, or personality than ours.
  Good. It's your duck.
