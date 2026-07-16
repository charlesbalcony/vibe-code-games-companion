# Checkpoint ch10-1 — "the great re-skin part 1: sprites with a style bible"

**Book location:** Chapter 10, end.
**Previous checkpoint:** `ch09-1-v1-0-shipped`.
**What changed:** the code-drawn duck, plunger, and bubble retired with
honor — `assets/sprites/` holds AI-generated transparent PNGs, wired in
at the same sizes with hitboxes untouched. CLAUDE.md gained the art
style bible so every future sprite matches.

## The prompts that got here (copy-paste friendly)

> There's a sprite generator at tools/generate_sprite.py (run it with
> python, --out for the path). Use it to make a sprite for the player
> duck — cute, determined, facing left — then replace the duck's
> code-drawn art with the sprite, scaled to the same size the drawn
> duck was. Keep the collision shape exactly as it is — the forgiving
> hitbox stays.

> Before we do the other sprites: define an art style phrase for this
> game and add it to CLAUDE.md — every sprite prompt should include it.
> I want: chunky, cute, thick outlines, soft shading, slightly glossy,
> like a premium mobile game that knows it's about plumbing.

> Using the style phrase: sprites for the plunger (red cup, wooden
> handle) and the soap bubble (translucent, shiny). Wire both in, same
> drawn sizes as before, hitboxes untouched. The bubble MUST still read
> as friendly at a glance — that's a design law from chapter 6, and if
> the generated art muddles it, regenerate before wiring it in.

> Commit as "the great re-skin part 1: sprites with a style bible".

## What to check when you run it

- Same duck FEEL (speed, bob, forgiving hitbox), new duck face.
- Plungers read angry, bubbles read friendly, at a glance.
- Your sprites will differ from ours — that's your style bible talking.
