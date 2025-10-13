class Distance {
  late final double _meter; //meters

  Distance(this._meter): assert(_meter >= 0, "Distance cannot be negative");

  Distance.meter(this._meter);

  // Distance.kilometer(double km) {
  //   //_meter = km * 1000;
  //   this:meter(km * 1000);
  // }

  Distance.kilometer(double km): this(km * 1000);
  
  

  Distance.centimeter(double cm) {
    _meter = cm / 100;
  }

  Distance.millimeter(double mm) {
    _meter = mm / 1000;
  }


  Distance operator+ (Distance other){
    return Distance.meter(this.meter + other.meter);
  }

  double get meter => _meter;
  double get kilometer => _meter / 1000;
  double get centimeter => _meter * 100;
  double get millimeter => _meter * 1000;
}

void main() {
  Distance d1 = Distance.kilometer(1);
  Distance d2 = Distance.millimeter(3_000_000);
  Distance d4 = Distance.centimeter(5000);
  Distance d5 = Distance.millimeter(9);

  Distance d3 = d2 + d1 + d4 + d5;

  print((d2+d5).meter.toString() + " m");

  print("${d3.kilometer} km");
  print("${d3.meter} m");
  print("${d3.centimeter} cm");
  print("${d3.millimeter} mm");
  
} 