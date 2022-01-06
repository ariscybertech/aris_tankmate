import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:tank_mates/data/model/settings.dart';
import 'package:tank_mates/data/persistence/dao/settings_dao.dart';
import 'package:tank_mates/util/unit_conversions.dart';

class SettingsViewModel extends ChangeNotifier {
  SettingsDao _settingsDao = SettingsDao();
  Settings _currentSettings = Settings.general();

  Settings get settings {
    return _currentSettings;
  }

  Future loadSettings() async {
    Settings settings = await _settingsDao.getSettings();

    if (settings != null) {
      _currentSettings = settings;
      _settingsDao.update(settings);
    }
  }

  void updateTemperatureUnit(TemperatureUnit newUnit) async {
    _currentSettings.temperatureUnit = newUnit;
    _settingsDao.update(settings);
    _currentSettings = settings;
  }

  void updateVolumeUnit(VolumeUnit newUnit) async {
    _currentSettings.volumeUnit = newUnit;
    _settingsDao.update(settings);
    _currentSettings = settings;
  }

  int volume(int gallons) {
    VolumeUnit volumeUnit = _currentSettings.volumeUnit;

    if (volumeUnit == VolumeUnit.gallons)
      return gallons;
    else
      return UnitConversions.gallonsToLiters(gallons);
  }

  String volumeUnit() {
    VolumeUnit volumeUnit = _currentSettings.volumeUnit;

    if (volumeUnit == VolumeUnit.gallons)
      return 'gallon';
    else
      return 'liter';
  }

  int temperature(int fahrenheit) {
    TemperatureUnit temperatureUnit = _currentSettings.temperatureUnit;

    if (temperatureUnit == TemperatureUnit.fahrenheit)
      return fahrenheit;
    else
      return UnitConversions.fahrenheitToCelsius(fahrenheit);
  }

  String temperatureUnit() {
    TemperatureUnit temperatureUnit = _currentSettings.temperatureUnit;

    if (temperatureUnit == TemperatureUnit.fahrenheit)
      return '°F';
    else
      return '°C';
  }
}
