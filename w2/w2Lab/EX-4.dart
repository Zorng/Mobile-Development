class Address {
  String _street;
  String _city;
  String _zipCode;

  Address(String this._street, String this._city, String this._zipCode);

  @override
  String toString() {
    return "$_street, $_city, $_zipCode";
  }
}

enum OrderStatus { deliver, pickup }

class Product{
  int _productId;
  String _name;
  double _unitPrice;

  Product(this._productId, this._name, this._unitPrice);

  @override
  String toString() {
    return "id: $_productId, name: $_name, unit price: $_unitPrice";
  }

  @override
  bool operator ==(Object other) =>
      other is Product &&
      other._productId == _productId &&
      other._name == _name &&
      other._unitPrice == _unitPrice;

  @override
  int get hashCode => Object.hash(_productId, _name, _unitPrice);
}

class Store {
  String _name;
  String _phone;
  Address address;
  Map<int, Customer> _customers = {};
  //{{order_id, customer_id}, order} 
  List<Order> _orders = [];
  Map<int, Product> _products = {};

  Store(String this._name, String this._phone, String street, String city,
      String zipCode)
      : address = Address(street, city, zipCode);

  Customer createCustomer(int id, String name, String phone) {
    if (_customers.containsKey(id)) {
      throw ArgumentError("Duplicated customer id");
    }
    Customer temp = Customer(id, name, phone);
    _customers.addAll({id: temp});
    return temp;
  }

  void registerProducts(List<Product> products) {
    products.forEach((product) {
      if(_products.containsKey(product._productId)) {
        throw ArgumentError("Duplicated product id");
      }
      _products.addAll({product._productId: product});
    });
  }

  void registerOrder(Order inputOrder) {
    _orders.forEach((order) {
      if(order._customerId == inputOrder._orderId){
        throw ArgumentError("Duplicated order id");
      }
    });
    _orders.add(inputOrder);
  }

  Map<int, Product> get products => _products;
  Map<int, Customer> get customers => _customers;
  List<Order> get orders => _orders;

  @override
  String toString() {
    return '''
name: $_name
phone: $_phone
address: $address
''';
  }
}

class Customer {
  final int _customerId;
  String _name;
  String _phone;

  Customer(this._customerId, this._name, this._phone);

  Order createOrder(int orderId, OrderStatus status) {
    if(status == OrderStatus.deliver) {
      return Order.deliver(orderId, _customerId);
    } 
    return Order.pickup(orderId, _customerId);
  }

  @override
  String toString() {
    return '''
id: $_customerId
name: $_name
phone: $_phone
''';
  }
}

class Order {
  final int _orderId;
  final int _customerId;
  OrderStatus _status;
  Map<int, OrderProduct> orderProduct = {};

  Order.deliver(this._orderId, this._customerId): this._status = OrderStatus.deliver;
  Order.pickup(this._orderId, this._customerId): this._status = OrderStatus.pickup;
  
  @override
  String toString() {
    return '''

total: \$xx
''';
  }
}

class OrderProduct {
  Product _product;
  int _quantity;

  OrderProduct(
    this._product,
    int quantity
  ):assert(quantity > 0, "Quantity cannot be zero or less"),
    assert(quantity < 1000, "Quantity shall not exceed 1000"),
    _quantity = quantity;

  double get total => this._product._unitPrice * this._quantity;
}



/*
  need to make sure order id is not duplicated
  therefore it need to be stored at the Store and 
  not stored individually by customers because there
  is no way to track which id are used.

  what would be the process of creating an order?

  PROCESS
  a customer create an order (provides product and quantity) => the order is registered to the store.

  it should called the register

*/