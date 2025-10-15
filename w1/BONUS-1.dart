// For this exercise, I use class to define datastructure because it feels more natural.

enum Direction { north, east, south, west }

class Robot {
  int x, y;
  Direction direction;
  Robot(this.x, this.y, this.direction);

  void advance() {
    switch (direction) {
      case Direction.north: 
        this.y++;
      case Direction.east:
        this.x++;
      case Direction.south:
        this.y--;
      default: // west as default
        this.x--;
    }
  }

  void turnLeft() {
    switch (direction) {
      case Direction.north: 
        this.direction = Direction.west;
      case Direction.east:
        this.direction = Direction.north;
      case Direction.south:
        this.direction = Direction.east;
      default: // west as default
        this.direction = Direction.south;
    }
  }

  void turnRight() {
    switch (direction) {
      case Direction.north: 
        this.direction = Direction.east;
      case Direction.east:
        this.direction = Direction.south;
      case Direction.south:
        this.direction = Direction.west;
      default: // west as default
        this.direction = Direction.north;
    }
  }

  void processInstruction(String ins) {
    for(int i = 0; i < ins.length; i++) {
      switch(ins[i]) {
        case 'A': advance();
        case 'R': turnRight();
        case 'L': turnLeft();
        default: { //unknown instruction
          print("Error: unknown instruction");
          //break; I tried using break but the loop does not stop when encouter bad input
          throw FormatException("${ins[i]} is not a valid instruction");
        }
      }
    }
  }

  @override
  String toString() {
    
    return "x = $x, y = $y, direction = $direction";
  }
  
}
 
void main() {
  // Initial position {7, 3} and facing north
  // int x = 7;
  // int y = 3;
  // Direction direction = Direction.north;
  Robot r1 = Robot(7,3, Direction.north);

  // Example instruction sequence
  const instructions = "RAALAL";
  
  // Process the instructions and get the final position and direction
  try {
    r1.processInstruction(instructions);
  } catch (e) {
    print(e);
  }
  

  // Print the final position and direction
  print("Final position: (x, y) = (${r1.x}, ${r1.y})");
  print("Facing:  ${r1.direction}");
}
