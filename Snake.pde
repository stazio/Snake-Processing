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

void setup() {
  size(800, 600);
  
  boxX = (width-BOX_WIDTH)/2;
  boxY = (height-BOX_HEIGHT)/2;
  
  cubes.add(new Position(BOX_WIDTH/2 + boxX, BOX_HEIGHT/2 + boxY));
  addToFront();
  addToFront();
  addToFront();
  addToFront();
  addToFront();
  newFood();
  
  
  
  STATE = 2;
  frameRate(10);
}

void draw() {
  switch(STATE) {
  case 1:
    //onIntroState();
    break;
  case 2:
    onRunState();
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

void onRunState() {
  clear();
  
  // Move the snake
  cubes.remove(0);
  Position pos = cubes.get(cubes.size()-1).clone();
  pos.move(direction, CUBE_SIZE);
  cubes.add(pos);
  print("X: " + pos.x + " Y: " + pos.y + "\n");
  
  // Draw the Cube
  fill(255);
  for (Position cube : cubes) {
    // Check if collision with self.
    if (cubes.indexOf(cube) != cubes.size()-1 && cube.at(pos))
      STATE = 4; 
      
    rect(cube.x, cube.y, CUBE_SIZE, CUBE_SIZE);
  }
  
   // Check if out of bounds
  if (pos.x > boxX + BOX_WIDTH || pos.x < boxX || pos.y > boxY + BOX_HEIGHT || pos.y < boxY)
    STATE = 4;
  
  // Check if colliding with food
  if (pos.at(food)) {
    newFood();
    addToFront();
  }
  
  //Food
  fill(50);
  rect(food.x, food.y, CUBE_SIZE, CUBE_SIZE);
  
  noFill();
  stroke(255);
  // TODO fix this
  rect(boxX - 10, boxY - 10, BOX_WIDTH + 30, BOX_HEIGHT + 30);
}

void gameOverState() {
  textAlign(CENTER,CENTER);
  textSize(30);
  text("You Loose!", width/2, height/2);
}

void keyPressed() {
  if (keyCode == UP && direction != 2)
    direction = 0;
    else if (keyCode == LEFT && direction != 3)
    direction = 1;
    else if (keyCode == RIGHT && direction != 1)
    direction = 3;
    else if (keyCode == DOWN && direction != 0)
    direction = 2;
}