/*
 |---------------|------------|----------------|
 |Field          |Type        |Nullable        |
 |---------------|------------|----------------|
 | Passenger     |class       |maybe yes or no |
 | Destination   |String      |no              |
 | Travel class  |enum        |no              |
 | Discount code |String      |yes             |
 |---------------|------------|----------------|
*/

class Passport {
  //...
}

enum TravelClass {firstClass, business, economy}

class Passenger {
  final String id;
  final Passport passport;
  Passenger(this.id, this.passport);
}

class Ticket {
  Passenger? passenger;
  String dest;
  TravelClass travelClass;
  String? discountCode;

  Ticket({
    this.passenger = null, 
    required this.dest, 
    required this.travelClass,
    this.discountCode = null
  });
}