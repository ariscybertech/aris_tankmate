class UnitConversions {
  /* Temperature conversions */
  static fahrenheitToCelsius(int fahrenheit) {
    int celsius = ((5 / 9) * (fahrenheit - 32)).round();
    return celsius;
  }

  static celsiusToFahrenheit(int celsius) {
    int fahrenheit = ((celsius * (9 / 5)) + 32).round();
    return fahrenheit;
  }

  /* Volume conversions */
  static gallonsToLiters(int gallons) {
    int liters = (gallons / 0.26417).round();
    return liters;
  }

  static litersToGallons(int liters) {
    int gallons = (liters * 0.26417).round();
    return gallons;
  }

  /* Distance conversions */
  static inchesToCentimeters(double inches) {
    double centimeters = inches * 2.54;
    return centimeters;
  }

  static centimetersToInches(double centimeters) {
    double inches = centimeters / 2.54;
    return inches;
  }
}
