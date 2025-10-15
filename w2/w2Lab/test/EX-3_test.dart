import 'dart:math';

import '../EX-3.dart';
import 'package:test/test.dart';

void main() {
  //note to self

  test("Negative duration", () {
    //this confirms that the constructor throws an assertionError but does not care about the detail of the error
    expect(() => CustomDuration(-99), throwsA(isA<AssertionError>()));
  });

  test("Negative duration(details)", () {
    //to match assertion error to its detail, do the following
    expect(() => CustomDuration(-1999),
      throwsA(
        predicate((e) => e is AssertionError && e.message.toString().contains("Negative input not allowed"))
      )
    );
  });

  test("3 hours > 120 minutes", () {
    expect(() => CustomDuration.fromHours(2) > CustomDuration.fromMinutes(120), equals(true));
  });

  test("small duration - bigger duration", () {
    expect(() => CustomDuration(120) - CustomDuration(400), throwsException);
  });


  //Had a hard time doing this one because I wrote the function to throw Exception
  //It is better to throw ArgumentError as it is more specific of what went wrong
  //and also has .message property which can be used to compare thrown message
  test("small duration - bigger duration (detailed)", () {
    expect(() => (CustomDuration(120) - CustomDuration(400)), throwsA(
      predicate((e) => e is ArgumentError && e.message.toString().contains("Error: negative result"))
    ));
  });
}