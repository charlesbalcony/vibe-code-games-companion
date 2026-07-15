# Checkpoint ch09-1 — "v1.0: shipped to itch.io"

**Book location:** Chapter 9, end of session five.
**Previous checkpoint:** `ch08-1-menus-and-memory`.
**What changed in the project:** one thing — a small, dim, proud
credits line on the menu (edit it — it's YOUR name that goes there).
Everything else in chapter 9 happens in the Godot export dialog and on
itch.io, not in the project files. That's why this checkpoint is
nearly identical to the last one: **shipping is clerical work, and
clerical work is still the most important day of the project.**

## The chapter's actual work (a map, since it's not in the files)

1. **Editor → Manage Export Templates → Download and Install** (~1 GB,
   one time per Godot version).
2. **Project → Export → Add → Windows Desktop.** Embed PCK: on.
   Export to `exports/FlushRush.exe`. Run it from Explorer like a
   stranger would.
3. **Add → Web.** Export into `exports/web/` with the HTML file named
   `index.html`.
4. On itch.io: new project, kind = HTML, upload the zipped *contents*
   of `exports/web/`, check "This file will be played in the browser",
   and — **the gotcha** — Embed options → enable **SharedArrayBuffer
   support**. Attach the .exe as a bonus download.
5. Description, screenshot, price free, **Save & view page.**

## The prompts from this chapter (copy-paste friendly)

The page copy:

> Write an itch.io page description for Flush Rush: a one-thumb arcade
> dodger where you're a rubber duck dodging plungers in a draining
> pipe. Funny but short — two sentences of hook, controls, one line
> owning the programmer art with dignity.

The encore:

> Add a tiny credits line to the main menu, bottom corner: "a game by
> [YOUR NAME]" — small, dim, proud. Then commit as "v1.0: shipped to
> itch.io" and I want the commit exactly named that.

## What to check

- The menu credits someone. Make it you.
- Your itch URL loads and plays in a browser. Send it to exactly one
  person you trust. Only one. Discipline.
- Somewhere in your project's history there is now a commit named
  `v1.0: shipped to itch.io` — which is more than most game ideas
  ever get.
