
class Position {

  public int x, y;

  public Position(int x, int y) { 
    this.x = x;
    this.y = y;
  }

  public Position(int x) {
    this(x, 0);
  }

  public Position() {
    this(0, 0);
  }

  /**
   Moves in the direcrtion specified by the distance
   **/
  void move(int direction, int distance) {
    if (direction % 2 == 0) // Vert or Horiz?
      this.y += (distance*(direction-1)); // dir - 1 to make it positive or negative
    else
      this.x += (distance*(direction-2)); // dir - 2 to make it positive or negative
  }
  
  boolean at(Position other) {
    return this.x == other.x && this.y == other.y;
  }
  
  Position clone() {
    return new Position(this.x, this.y);    
  }
}