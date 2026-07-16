# Checkpoint ch11-1 — "the game has ears: looping theme, five SFX, and a CREDITS.txt with receipts"

**Book location:** Chapter 11, end.
**Previous checkpoint:** `ch10-1-the-great-reskin-part-1`.
**What changed:** `assets/music/` (MusicGen theme + menu loops, made
locally on the author's GPU — CC-BY-NC weights, see CREDITS.txt) and
`assets/sfx/` (five synthesized effects from tools/generate_sfx.py).
Theme loops under gameplay, menu music on the menu, pop on catch,
whoosh on near-miss, sting after the hit-stop, click on Play.

## The prompts that got here (copy-paste friendly)

> theme.wav is 60 seconds. Find a musically clean loop — a downbeat
> late in the track that matches the opening — trim it, and wire it in
> as seamlessly looping gameplay music. Quiet-ish; it's under the game,
> not on top of it.

> Five SFX in assets/sfx/. Wire them: pop on bubble catch, whoosh on
> near-miss, sting on death (AFTER the hit-stop — let the freeze be
> silent, then the sting hits with the shake), click on menu buttons.
> Log each in CREDITS.txt.

Want different sounds? The synthesizer is clay (chapter 11):

> In tools/generate_sfx.py, add a "splash" effect — noise burst with a
> low bloop underneath, about a quarter second. Match the style of the
> existing functions.

## What to check when you run it

- Menu hums patiently; gameplay bounces; they're audibly siblings.
- Die on purpose: freeze in SILENCE, then sting + shake together.
- Let the theme loop twice — seams hide in the second lap.
