class CustomDuration{
  int _millisecond;

  CustomDuration([int millisecond = 0]):assert(millisecond >= 0, "Negative input not allowed"), _millisecond = millisecond;

  CustomDuration.fromHours([int hours = 0]):assert(hours >= 0, "Negative input not allowed"), _millisecond = hours * 3_600_000;

  CustomDuration.fromMinutes([int minutes = 0]):assert(minutes >= 0,"Negative input not allowed"), _millisecond = minutes * 60_000;

  CustomDuration.fromSeconds([int seconds = 0]):assert(seconds >= 0, "Negative input not allowed"),
  _millisecond = seconds * 1000;

  bool operator> (CustomDuration other) {
    return this._millisecond > other._millisecond;
  }
  
  CustomDuration operator+ (CustomDuration other) {
    return CustomDuration(this._millisecond + other._millisecond);
  }

  CustomDuration operator- (CustomDuration other) {
    if(other._millisecond > this._millisecond) {
      throw ArgumentError("Error: negative result");
    }
    return CustomDuration(this._millisecond - other._millisecond); 
  }

  double get hours => _millisecond / 3_600_000;
  double get minutes => _millisecond / 60_000;
  double get seconds => _millisecond / 1000;
  int get millisecond => _millisecond;

  @override
  String toString() {
    return "${_millisecond}";
  }
}