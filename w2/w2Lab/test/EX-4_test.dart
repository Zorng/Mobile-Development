import '../EX-4.dart';
import 'package:test/test.dart';

void main() {
  Store myStore = Store("OkayStore", "011 999 909090", "tea", "Arkham", "SHA-256");
  
  myStore.registerProducts([
    Product(1, "Book", 2.0),
    Product(2, "Pen", 0.7),
    Product(3, "Mechanical Pencil", 1.5),
    Product(4, "Eraser", 0.2),
  ]);

  test("Correctly create products", (){
    expect(myStore.products, equals({
      1: Product(1, "Book", 2.0),
      2: Product(2, "Pen", 0.7),
      3: Product(3, "Mechanical Pencil", 1.5),
      4: Product(4, "Eraser", 0.2)
    }));
  });

  test("Duplicated product key registeration:", (){
    expect(() => myStore.registerProducts([
      Product(4, "Godzilla", 2000.0)
    ]), throwsA(
      predicate((e) => e is ArgumentError && e.message.toString().contains("Duplicated product key"))
    ));
  });

  Customer c1 = myStore.createCustomer(1, "Jean", "011 88 44 55");
  Customer c2 = myStore.createCustomer(2, "Ronan", "012 885 41 55");
  Customer c99 = myStore.createCustomer(3, "Chicka", "011 13 41 59");

  test("correctly create customers ", (){
    expect(myStore.customers, {
      1: Customer(1, "Jean", "011 88 44 55"),
      2: Customer(2, "Ronan", "012 885 41 55"),
      3: Customer(3, "Chicka", "011 13 41 59")
    });
  });

  test("duplicated customer id creation", () {
    expect(() => myStore.createCustomer(1, "imposter", "0xx xx xx xx"), throwsA(
      predicate((e) => e is ArgumentError && e.message.toString().contains("Duplicated customer id"))
    ));
  });


    Order o1 = c1.createOrder(1, OrderStatus.deliver);
    Order o2 = c1.createOrder(2, OrderStatus.pickup);
  test("Correctly register order", (){
    expect(myStore.orders, [
      Order.deliver(1, 1),
      Order.pickup(2, 1)
    ]);
  });

}