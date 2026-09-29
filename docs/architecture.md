# ARCHITECTURE

## SCENES 

### MAIN
- Main controls the main running of the game with player reference and top level managers

### Room Manager
- Room Manager manages transitions between rooms
- Holds a container for the current room which is read by main as well as a reference to the current room
- Holds reference to the player

### Load Zone
- Holds reference and editor slot for the NAME of the room (String) to be inputted, and automatically assumes it is stored as res://scenes/rooms/xxx.tscn so you only need room name
- Holds reference to the spawn location in the target room (String) that the player is placed at when entering, string name to line up with a node of the target room
