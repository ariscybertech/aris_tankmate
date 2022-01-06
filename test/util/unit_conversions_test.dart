import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/util/unit_conversions.dart';

void main() {
  fahrenheitToCelsius();
  celsiusToFahrenheit();
  gallonsToLiters();
  litersToGallons();
  inchesToCentimeters();
  centimetersToInches();
}

void fahrenheitToCelsius() {
  test('fahrenheitToCelsius() returns the expected value', () {
    expect(UnitConversions.fahrenheitToCelsius(32), 0);
    expect(UnitConversions.fahrenheitToCelsius(78), 26);
    expect(UnitConversions.fahrenheitToCelsius(82), 28);
    expect(UnitConversions.fahrenheitToCelsius(65), 18);
  });
}

void celsiusToFahrenheit() {
  test('celsiusToFahrenheit() returns the expected value', () {
    expect(UnitConversions.celsiusToFahrenheit(0), 32);
    expect(UnitConversions.celsiusToFahrenheit(26), 79);
    expect(UnitConversions.celsiusToFahrenheit(28), 82);
    expect(UnitConversions.celsiusToFahrenheit(18), 64);
  });
}

void gallonsToLiters() {
  test('gallonsToLiters() returns the expected value', () {
    expect(UnitConversions.gallonsToLiters(1), 4);
    expect(UnitConversions.gallonsToLiters(20), 76);
    expect(UnitConversions.gallonsToLiters(55), 208);
  });
}

void litersToGallons() {
  test('litersToGallons() returns the expected value', () {
    expect(UnitConversions.litersToGallons(4), 1);
    expect(UnitConversions.litersToGallons(76), 20);
    expect(UnitConversions.litersToGallons(208), 55);
  });
}

void inchesToCentimeters() {
  test('inchesToCentimeters() returns the expected value', () {
    expect(UnitConversions.inchesToCentimeters(1), 2.54);
    expect(UnitConversions.inchesToCentimeters(12), 30.48);
    expect(UnitConversions.inchesToCentimeters(48), 121.92);
  });
}

void centimetersToInches() {
  test('centimetersToInches() returns the expected value', () {
    expect(UnitConversions.centimetersToInches(2.54), 1);
    expect(UnitConversions.centimetersToInches(30.48), 12);
    expect(UnitConversions.centimetersToInches(121.92), 48);
  });
}
