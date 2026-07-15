# Flush Rush — house rules

Godot 4.x project, GDScript. This is a learning project:
clarity beats cleverness.

- Small changes. One feature or fix per request. Don't refactor
  neighboring code unless asked.
- Scenes in scenes/, scripts in scripts/, always-alive systems in
  scripts/autoload/, art in assets/ (empty until later, on purpose).
- Use signals for communication between nodes; explain any new
  pattern in one sentence when you introduce it.
- Game-feel numbers (speeds, gravity, spawn rates) go in named
  constants at the top of the script so we can tune them by name.
- After changes, tell me to run the game — never assume it works.
