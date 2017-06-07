void gameOverState() {
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text("You Loose!", width/2, height/3);

  rectMode(CENTER);

  if (isHoverOnPlay) 
    fill(134, 134, 134); 
  else 
  fill(255);
  noStroke();
  rect(width/2, height/2+5, 200, 50);

  fill(0);
  text("Play Again?", width/2, height/2);
}

boolean isHoverOnPlay = false;

void introState() {
  clear();
  textAlign(CENTER, CENTER);
  textSize(30);
  fill(255);
  text("Snake", width/2, height/3);

  rectMode(CENTER);

  if (isHoverOnPlay) 
    fill(134, 134, 134); 
  else 
  fill(255);
  rect(width/2, height/2+5, 100, 50);

  fill(0);
  text("Play", width/2, height/2);
}

void mouseMoved() {
  if (STATE == 1)
    isHoverOnPlay = 
      mouseX >= width/2 - 50 && mouseX <= width/2+50 &&
      mouseY >= height/2-25 && mouseY <= height/2+30;
  else if (STATE == 4)
    isHoverOnPlay = 
      mouseX >= width/2 - 100 && mouseX <= width/2+100 &&
      mouseY >= height/2-25 && mouseY <= height/2+30;
  else
    isHoverOnPlay = false;
}

void mouseClicked() {
  if (STATE == 1 || STATE == 4)  
    if (isHoverOnPlay) {
      STATE = 0;
    }
}