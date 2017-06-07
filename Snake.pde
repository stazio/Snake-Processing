final int CUBE_SIZE = 10;
final int BOX_WIDTH = 600, BOX_HEIGHT = 400;

/*
0 - INIT
 1 - INTRO SCREEN
 2 - RUNNING
 3 - PAUSE
 4 - YOU LOOSE SCREEN
 */
int STATE = 0;

/*
0 - UP
 1 - RIGHT
 2 - DOWN
 3 - LEFT
 */
int direction = 0;

ArrayList<Position> cubes = new ArrayList();
Position food = null;

int boxX, boxY;
float delta;

void setup() {
  size(600, 400);

  boxX = (width-BOX_WIDTH)/2;
  boxY = (height-BOX_HEIGHT)/2;

  STATE = 1;
  mouseMoved();
}

void draw() {
  switch(STATE) {
  case 0:
    initGame();
    break;
  case 1:
    introState();
    break;
  case 2:
    runState();
    break;
  case 4:
    gameOverState();
    break;
  }
}

void addToFront() {
  Position newPos = cubes.get(cubes.size()-1).clone();
  newPos.move(direction, CUBE_SIZE);
  cubes.add(newPos);
  print("New X: " + newPos.x + " Y: " + newPos.y);
}

void newFood() {
  if (food == null)
    food = new Position();

  food.x = floor((int)random(boxX, BOX_WIDTH+boxX)/10)*10;
  food.y = floor((int)random(boxY, BOX_HEIGHT+boxY)/10)*10;
}

void keyPressed() {
  if (STATE == 2) { // In Game
    if (keyCode == UP && direction != 2)
      direction = 0;
    else if (keyCode == LEFT && direction != 3)
      direction = 1;
    else if (keyCode == RIGHT && direction != 1)
      direction = 3;
    else if (keyCode == DOWN && direction != 0)
      direction = 2;
  }
}