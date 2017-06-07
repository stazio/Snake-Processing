void runState() {
  rectMode(CORNER);
  if (millis() - delta >= 100) {
    delta = millis();
    clear();

    // Move the snake
    cubes.remove(0);
    Position pos = cubes.get(cubes.size()-1).clone();
    pos.move(direction, CUBE_SIZE);
    cubes.add(pos);
    print("X: " + pos.x + " Y: " + pos.y + "\n");

    // Draw the Cube
    fill(255);
    stroke(0);
    for (Position cube : cubes) {
      // Check if collision with self.
      if (cubes.indexOf(cube) != cubes.size()-1 && cube.at(pos)) {
        STATE = 4;
        mouseMoved();
      }

      rect(cube.x, cube.y, CUBE_SIZE, CUBE_SIZE);
    }

    // Check if out of bounds
    if (pos.x > boxX + BOX_WIDTH || pos.x < boxX || pos.y > boxY + BOX_HEIGHT || pos.y < boxY) {
      STATE = 4;

      mouseMoved();
    }

    // Check if colliding with food
    if (pos.at(food)) {
      newFood();
      addToFront();
    }

    //Food
    fill(50);
    stroke(255);
    rect(food.x, food.y, CUBE_SIZE, CUBE_SIZE);

    noFill();
    // TODO fix this
    rect(boxX - 10, boxY - 10, BOX_WIDTH + 30, BOX_HEIGHT + 30);
  }
}

void initGame() {
  cubes.clear();
  cubes.add(new Position(BOX_WIDTH/2 + boxX, BOX_HEIGHT/2 + boxY));
  addToFront();
  addToFront();
  addToFront();
  addToFront();
  addToFront();
  newFood();

  delta = millis();
  STATE = 2;
}