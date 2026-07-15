# Checkpoint ch08-1 — "front door, pause, input actions, and a high score that survives death AND quitting"

**Book location:** Chapter 8, end of session four.
**Previous checkpoint:** `ch07-3-juice-pass`.
**What changed:** a MainMenu scene (now the startup scene), a pause
overlay on Escape, proper `move_left`/`move_right` input actions
(arrows AND A/D via the input map), and `GameState` grew a high score
that saves to `user://` the moment it's beaten.

## State of the game

It's a *game* game now: boots to a front door, pauses like a grown-up,
remembers your best after a full quit-and-relaunch, and the death
screen offers instant re-flush (any key) or M for menu. This is
everything before the art — the plumbing half, complete.

## The prompts that got here (copy-paste friendly)

The conversation first — make the robot define its own words:

> Before we build anything: explain what GameState is and what an
> "autoload" means in this project — like I'm smart but new.

The front door:

> Give the game a main menu — its own scene, first thing you see at
> launch. Big title "FLUSH RUSH", a Play button that starts the game,
> and a Quit button. Same code-drawn style as everything else. Dying
> should offer "press any key to re-flush" like now, but also a small
> "menu" option to go back to the front door.

Pause:

> Escape should pause: freeze everything, dim the screen, say PAUSED,
> offer resume and quit-to-menu. Escape again resumes.

Input actions:

> Set up proper input actions — "move_left" and "move_right" — mapped
> to both the arrow keys and A/D, and make the player code use the
> actions instead of raw keys. I want adding a gamepad later to be a
> table edit, not a code change.

Memory:

> Keep a high score: show "Best" in the top corner during play and on
> the menu, update it when beaten, and — important — it has to survive
> quitting the game entirely. Where does that kind of data even live?

Save point:

> Commit as "front door, pause, input actions, and a high score that
> survives death AND quitting".

## What to check when you run it

- Boots to the menu. Play → game. Die → any key re-flushes, M → menu.
- Esc mid-chaos: frozen plungers (weirdly majestic), dim, PAUSED.
  Resume: no teleporting ducks, no clumped rain.
- Arrows and A/D feel identical.
- Set a best, **quit the whole game, relaunch** — still yours. On
  Windows it lives under `%APPDATA%\Godot\app_userdata\Flush Rush\`.
