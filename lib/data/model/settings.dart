class Settings {
  TemperatureUnit temperatureUnit = TemperatureUnit.fahrenheit;
  VolumeUnit volumeUnit = VolumeUnit.gallons;

  Settings(this.temperatureUnit, this.volumeUnit);

  Settings.general() {
    this.temperatureUnit = TemperatureUnit.fahrenheit;
    this.volumeUnit = VolumeUnit.gallons;
  }
}

enum TemperatureUnit { fahrenheit, celsius }

enum VolumeUnit { gallons, liters }
