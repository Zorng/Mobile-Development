import 'package:test/test.dart';
import '../BONUS-1.dart';

void main(){
  test("Case 1:", () {
    Robot robot = Robot(7, 3, Direction.north);
    robot.processInstruction("RAALAL");
    print(robot);
    expect(robot.x, equals(9));
    expect(robot.y, equals(4));
    expect(robot.direction, equals(Direction.west));
  });

  test("Case 2:", () {
    Robot robot = Robot(0, 0, Direction.east);
    robot.processInstruction("LAAARALA");
    print(robot);
    expect(robot.x, equals(1));
    expect(robot.y, equals(4));
    expect(robot.direction, equals(Direction.north));
  });

  test("Case 3:", () {
    Robot robot = Robot(2, 5, Direction.south);
    robot.processInstruction("RRAAAAALA");
    print(robot);
    expect(robot.x, equals(1));
    expect(robot.y, equals(10));
    expect(robot.direction, equals(Direction.west));
  });

  test("Case 4:", () {
    Robot robot = Robot(5, 5, Direction.west);
    robot.processInstruction("AAAA");
    print(robot);
    expect(robot.x, equals(1));
    expect(robot.y, equals(5));
    expect(robot.direction, equals(Direction.west));
  });
  test("Case 4:", () {
    Robot robot = Robot(3, 3, Direction.north);
    robot.processInstruction("AAAA");
    print(robot);
    expect(robot.x, equals(3));
    expect(robot.y, equals(7));
    expect(robot.direction, equals(Direction.north));
  });
}