0.2.0 (2013/08/04)
---

 * added new `meter` action for rendering a meter
 * created new `Batt::Formatter::Tmux` class for doing tmux color more easily
 * changed the way we calculate how to colourize. instead of even thirds, it now
   uses custom ranges. red is less than 20, yellow is 20-75 and green is 75 and higher.

0.1.0 (2013/07/13)
---

 * added tmux colour support for `capacity`
 * fixed the tmux example in the readme.

0.0.1 (2013/07/09)
---

Initial Release
