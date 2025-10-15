class Address {
  String _street;
  String _city;
  String _zipCode;

  Address(
    String this._street,
    String this._city,
    String this._zipCode
  );

  @override
  String toString() {
    return "$_street, $_city, $_zipCode";
  }
}

class Store{
  String _name;
  String _phone;
  Address address;
  Map<int, Customer> customers = {};

  Store(
    String this._name,
    String this._phone,
    String street,
    String city,
    String zipCode
  ):address = Address(street, city, zipCode);

  Customer createCustomer(int id, String name, String phone){
    if(customers.containsKey(id)) {
      throw ArgumentError("Error: id taken");
    }
    Customer temp = Customer(id, name, phone);
    customers.addAll({id: temp});
    return temp;
  }

  @override
  String toString() {  
    return
'''
name: $_name
phone: $_phone
address: $address
'''    
    ;
  }
}


class Customer{
  final int _id;
  String _name;
  String _phone;

  Customer(this._id, this._name, this._phone);

    @override
  String toString() {  
    return
'''
id: $_id
name: $_name
phone: $_phone
'''    
    ;
  }
}