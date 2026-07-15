# Checkpoint ch03-1 — "project skeleton" / "smoke test passes"

**Book location:** Chapter 3, end ("Now watch the robot build its own
office").
**Previous checkpoint:** none — this is the beginning.

## State of the game

It boots to a dark screen that says **IT'S ALIVE**. That's everything,
and that's the point: the folders, house rules (`CLAUDE.md`), launcher
scripts, and git habits all exist before the game does.

## The prompts that got here (copy-paste friendly)

> Set up this folder as a Godot 4 project called "Flush Rush":
>
> 1. Create project.godot for a 540x960 portrait game, and an empty
>    scenes/, scripts/, scripts/autoload/, and assets/ folder structure.
> 2. Create a Main scene at scenes/Main.tscn — just a dark background
>    with a centered label that says "IT'S ALIVE" — and make it the
>    main scene.
> 3. Create a CLAUDE.md with these house rules: Small changes, one
>    feature per request. Scenes in scenes/, scripts in scripts/,
>    persistent systems in scripts/autoload/. Signals between nodes.
>    Game-feel numbers in named constants. After changes, tell me to
>    run the game — never assume it works.
> 4. Create run.bat that launches the game with my Godot at
>    [YOUR GODOT PATH from chapter 2].
> 5. Initialize a git repository with a .gitignore appropriate for
>    Godot 4, and make a first commit called "project skeleton".
>
> Tell me when it's ready to test, and don't add anything I didn't ask
> for.

Then, after running it:

> The game runs and shows IT'S ALIVE. Commit this as "smoke test
> passes".

## What to check when you run it

- Double-click `run.bat` (edit the Godot path inside first) — a
  540x960 window opens in under ten seconds.
- Dark background, "IT'S ALIVE" centered.
- Your version should also have two git commits. This folder can't
  carry that for you — but this repo's own history has them.
