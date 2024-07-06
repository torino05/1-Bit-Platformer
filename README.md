# 1-BIT PLATFORMER
#### Video Demo: https://youtu.be/6TNmfigMqms
#### Description
“1-Bit Platformer” is a very small game made as the final project for CS50’s Introduction to Computer Science. 
#### Core mechanics
This is a platforming game that essentially consists of avoiding obstacles: the player advances jumping around the platforms and not being hit by the enemies. There are two types of enemies, one of level 1 (hanging enemy) and another of level 2 (ground enemy): the level determines how much damage the player receives. Additionally, the player can collect the coins lying around (collecting them all implies a higher challenge).
#### Game levels and endgame
There are two game levels. To beat the first one the player only has to reach the right side of the screen. But in the second one the player has to access the door, having previously collected the key. If the player reaches the door without having the key, the game will show an alert. Once the player enter the door, the game ends and the screen shows the player stats: how many coins were collected and the health with which the player ended the game.
#### Tools used
This project was made in Lua with LÖVE and with the following libraries: “Classic” for implementing classes in Lua, “Windfield” for managing physics and collisions, “Push” for managing window and game resolution, “Simple Tiled Implementation” for importing “Tiled” projects into lua, and “Anim8” for managing animations with tilemaps. All the assets used in this project are from the “1-Bit Platformer Pack” by Kenney (kenney.nl) with Creative Commons CC0 license (free for all uses).
#### Code structure
To give my project some structure that could allow me to scale it in the future, I made different classes and subclasses (with the “Classic” library). Going from top to bottom, it starts with a “Session” class, which keeps track of different variables and objects that are necessary for running the game. The other big class is the “UI” one, which holds the interface elements that are shown on the screen at different moments of the game session. All of these are in the “objects” folder. 
On the other hand, next to “main.lua” there is a “globals.lua” which holds some global variables. This is only to avoid populating “main.lua” with these globals. This way, “main.lua” loads only the essential libraries and dependencies, and then each class loads its respective dependencies needed for its subclasses.
#### Session
The “Session” class sets up all the essential game elements: the map, the player and the enemies. Each of these has its own class. So, when a session starts (a “session” object is instantiated by calling the “Session” class constructor) a “world” gets created with the “Windfield” library. This allows us to set up the gravity and the collider classes that later will be used by the different objects, and specify which colliders should ignore others (go through them). After this, a player gets created, as well as the enemies and the map. This session object also holds some variables, like “gameCoins”, which registers the number of coins present in the game, and “mapIndex”, which keeps track of which map should be rendered on screen.
This class also has some methods (functions) associated in order to load, unload a map and go to the next map. Each of these methods depend on others that load and unload different elements of the game (platforms, coins, enemies, traps, etc.)
#### Map
The “Map” class uses the “Simple Tiled Implementation” library to import the levels created with the “Tiled” app (in which we can draw a map using the tiles from our tilemap). Then updates and draw different elements on the screen (enemies, coins, keys).
#### Player
The “Player” class keeps track of the player position and size, points, health and a bool to check if the key has been collected. It also sets up the different animations, its collider and its mass. This class update function is used in order to update the position and speed and animations of the player, as well as checking if the player has lost, if it has collected some coins, if it has suffered damage, if it should advance to the next level and if it has collected the key or opened the door. The “Player” update function also keeps track of the input which triggers the animations and puts the player in motion. All of these actions inside “update” are functions that were abstracted out to make the code more readable and future-proof.
#### Enemy and types of enemies
The “Enemy” class sets up the enemy position and its collider. The position and movement update for each enemy appears on the different subclasses: “GroundEnemy” and “HangEnemy”. The first one walks around the level until it reaches a wall, and the second one doesn’t move because it is hanging (it uses a “static” collider).
#### UI
The “UI” class is used to keep track and draw all the elements show on screen. But the elements itself are subclasses of UI: “ScreenInfo”, “Alert”, “ScreenFlash”, and “FullScreen”. The “ScreenInfo” class draws the player stats on screen: the coins collected and the player’s health. The “Alert” class is used to show a quick message to the player, in this case, when we try to open the door without having the key. It implements a timer, so the message disappears after a couple of seconds. The “ScreenFlash” is used to give a visual cue to the player that it has been hit by some trap or enemy. Finally, the “FullScreen” is used to show the endgame player stats.
#### Collectibles, keys and door
Other classes that were used are “collectibles”, “keys” and “door”. The first one sets up the collider for each coin, so we can keep track when the player collects one (it has its own “collect” method). The second and the third ones also have its own colliders in order to check if the player gets the key and enters the door.
#### Room for improvement
Clearly there is still room for improvement. The class structure I created could be better organized, and also there are functions that could be abstracted out. Still, I am satisfied with this first attempt. I thank all the CS50 staff for its fantastic work. It is thanks to them that I managed to make this small project, that would be unthinkable for me to achieve some time ago.