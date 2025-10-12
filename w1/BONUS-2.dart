bool isBalanced(String text) {
  List<String> stack = [];

  for (int i = 0; i < text.length; i++) {
    switch (text[i]) {
      case '[' || '(' || '{' : 
        stack.add(text[i]);
      case ']' || ')' || '}':
      {
        if(stack.isEmpty) {
          return false;
        } else if ((stack.last == '[' && text[i] != ']') || (stack.last == '(' && text[i] != ')') || (stack.last == '{' && text[i] != '}')){
          return false;
        } else {
          stack.removeLast();
        }
      }
    }
  }

  return stack.isEmpty ? true : false;

}

void main() {
  List<String> testInput = ["{what is (42)}?", "[text}", "{[[(a)b]c]d}"];
  testInput.forEach((str) {isBalanced(str)? print("Balanced") : print("Not balanced");});
}