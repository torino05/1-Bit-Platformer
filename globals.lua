-- Window
gameWidth, gameHeight = 640, 360 --fixed game resolution
windowWidth, windowHeight = 1280, 720

-- Enemies
enemiesSpriteSheet = "assets/enemies/tilemap_enemies.png"

-- Player
playerSpriteSheet = "assets/player/tilemap_player_transparent.png"
playerX0 = gameWidth/7.5
playerY0 = gameHeight/2
playerWidth = 16
playerHeight = 16
playerMass = 2
playerResize = 1.2

Fjump = 500
Frun = 10
Ffriction = Frun

vxMax = 100

-- Collectibles
spriteSheet = "assets/maps/monochrome_tilemap_transparent_packed.png"