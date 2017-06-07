
/*
0 - INIT
 1 - INTRO SCREEN
 2 - RUNNING
 3 - PAUSE
 4 - YOU LOOSE SCREEN
 */
int STATE = 0;

ArrayList<Position> cubes = new ArrayList();
Position food = null;

int cubeSize =10;

/*
0 - UP
 1 - RIGHT
 2 - DOWN
 3 - LEFT
 */
int direction = 0;

void setup() {
  size(800, 600);
  cubes.add(new Position(800/2 - 10, 600/2 - 10));
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
  newPos.move(direction, cubeSize);
  cubes.add(newPos);
  print("New X: " + newPos.x + " Y: " + newPos.y);
}

void newFood() {
  if (food == null)
    food = new Position();
  
  food.x = floor((int)random(0, width)/10)*10;
  food.y = floor((int)random(0, height)/10)*10;
}

void onRunState() {
  clear();
  
  // Move the snake
  cubes.remove(0);
  Position pos = cubes.get(cubes.size()-1).clone();
  pos.move(direction, cubeSize);
  cubes.add(pos);
  print("X: " + pos.x + " Y: " + pos.y + "\n");
  
  // Check if out of bounds
  if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0)
    STATE = 4; 
  
  // Draw the Cube
  fill(255);
  for (Position cube : cubes) {
    // Check if collision with self.
    if (cubes.indexOf(cube) != cubes.size()-1 && cube.at(pos))
      STATE = 4; 
      
    rect(cube.x, cube.y, cubeSize, cubeSize);
  }
  
  // Check if colliding with food
  if (pos.at(food)) {
    newFood();
    addToFront();
  }
  
  //Food
  fill(50);
  rect(food.x, food.y, cubeSize, cubeSize);
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