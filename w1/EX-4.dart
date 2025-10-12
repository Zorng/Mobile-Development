void main() {
  // Map of pizza prices
  const pizzaPrices = {
    'margherita': 5.5,
    'pepperoni': 7.5,
    'vegetarian': 6.5,
  };

  // Example order
  const order = ['margherita', 'pepperoni', 'pineapple'];
  

  // Your code
  num total = 0;
  String badInput = "";

  for(String k in order) {
    if(pizzaPrices.containsKey(k)) {
      total += pizzaPrices[k] ?? 0;
    } else {
      badInput += (k + " ");
    }
  }

  print("Total: \$$total");

  print(badInput + "pizza is not on the menu");
}
