void main() {
  // List of student scores
  List<int> scores = [45, 67, 82, 49, 51, 78, 92, 30];

  List<int> passed = scores.where((score) => score >= 50).toList();
  // You code
  print(passed);
  print(passed.length.toString() + " students has passed");
}