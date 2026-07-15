# Appendix B: The Prompt Cookbook

Every load-bearing prompt from the book, generalized into fill-in
templates. A warning label first: these are *training wheels for
phrasing*, not magic words. The power was never the wording — it was
the small ask, the visible success test, and the run-it-after. If a
recipe here works, it's because it smuggles the constitution in.

Bracketed bits are yours to fill. Everything else is copy-paste-able.

## Setup and skeleton (ch. 3)

**The skeleton builder:**
> Set up this folder as a Godot 4 project called "[NAME]": create
> project.godot for a [RESOLUTION] game, empty scenes/, scripts/,
> scripts/autoload/, and assets/ folders, a CLAUDE.md with these
> house rules: [RULES]. Create run.bat launching it with Godot at
> [PATH]. Initialize git with a Godot-appropriate .gitignore and
> commit as "project skeleton". Don't add anything I didn't ask for.

**The starter house rules (paste into the above):**
> Small changes, one feature per request. Scenes in scenes/, scripts
> in scripts/, persistent systems in scripts/autoload/. Signals
> between nodes. Game-feel numbers in named constants. After changes,
> tell me to run the game — never assume it works.

## Building features (ch. 5–6)

**The first-feature pattern:**
> In [SCENE], add [ONE FEATURE]. [WHAT I SHOULD SEE ON SCREEN, 1–2
> sentences]. Script in [PATH], tunables in named constants. When
> done, tell me to run it and what to check.

**The staged build (danger in two steps):**
> Add [THINGS] that [BEHAVIOR] — but nothing interacts with the
> player yet; I want to watch it first.
> *(then, after running:)* Now the interaction: [CONSEQUENCE].

**The knobs table:**
> List the current game-feel numbers as a table: constant, value, one
> line on what it does.

## Reacting and tuning (ch. 4, 6)

**The symptom report:**
> [WHAT I DID]. [WHAT I SAW — precise, no diagnosis]. [WHAT I
> EXPECTED INSTEAD].

**The vibe adjustment (with intent!):**
> [FEELING] — [it feels sluggish / floaty / cheap / like a
> spreadsheet]. This game is about [INTENT], so it should feel
> [TARGET]. Adjust what you think and tell me which knobs you turned.

**The difficulty shape:**
> Not harder/easier overall — I want it to START [X] and BECOME [Y]
> over [TIMEFRAME]. Make the curve a named constant.

## Juice (ch. 7)

**The moment-maker:**
> When [GAME EVENT], I want it to feel like [AN EVENT / a wink / a
> gut-punch]: [2–3 sensory suggestions — shake, pop, freeze, punch].
> Taste-check it against [THE GAME'S FEELING].

## Understanding your own game (ch. 4, 8, 14)

**The explainer:**
> Explain [THING] in this project like I'm smart but new.

**The shape audit (monthly):**
> Explain the current structure of the project — major pieces and
> why they exist — like I'm smart but new. Flag anything that's
> grown weird.

## Assets (ch. 10–12)

**The sprite ask (style bible in CLAUDE.md first):**
> Using the style phrase: a sprite for [THING — 5–10 descriptive
> words]. Wire it in at the same size as the placeholder, hitboxes
> untouched. Acceptance test: [READABILITY LAW]. If the art fails
> it, regenerate before wiring in.

**The music ask:**
> [VIBE], [INSTRUMENTATION], [TEMPO/ENERGY], for [PURPOSE — under
> gameplay / menu / death]. Then find a clean loop point, trim, and
> wire it in looping at [under-the-game] volume.

## Debugging (ch. 14)

**The bisect:**
> [SYMPTOM] now, and it wasn't true at [TAG/COMMIT]. Binary-search
> the commits between there and now — check out midpoints, I'll
> playtest each, coordinate me.

**The second-contractor handoff:**
> Fresh eyes on a stuck bug. [ENGINE/GENRE]. Symptom: [FULL
> OBSERVABLE TRUTH]. Failed theories so far: [LIST]. Probable
> area: [FILES]. Don't trust existing comments — verify from
> scratch.

**The housekeeping sitting:**
> This sitting is cleanup only: [SPLIT/UNTANGLE TARGET] as you see
> fit, change zero behavior. I'll playtest to confirm nothing moved.

## Shipping (ch. 9, 15)

**The page copy:**
> Write a store description for [GAME]: [PREMISE, one sentence].
> Funny but short — two sentences of hook, controls, one line that
> owns [THE GAME'S HONEST QUIRK] with dignity.

**The vendor-pipeline ask (SteamPipe, exports, anything with docs):**
> Set up [PIPELINE THING] per the current official docs — check your
> work against them, this ecosystem changes. Deliver a one-command
> script I can run.

## The all-purpose closer

> The game runs and I like it. Commit as "[WHAT WORKS, changelog
> voice]".

Use liberally. It's the least glamorous recipe in the book and the
one that saves your bacon in chapter 14, every time, forever.
