import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/data/model/settings.dart';
import 'package:tank_mates/data/persistence/dao/settings_dao.dart';
import 'package:tank_mates/data/persistence/hive/SettingsRecord.dart';

void main() {
  toModel();
  toRecord();
}

void toModel() {
  test('toModel() returns the expected Settings', () {
    final settingsRecord = SettingsRecord(
        TemperatureUnit.fahrenheit.index, VolumeUnit.gallons.index);
    final model = SettingsDao.toModel(settingsRecord);

    expect(model.temperatureUnit, TemperatureUnit.fahrenheit);
    expect(model.volumeUnit, VolumeUnit.gallons);
  });
}

void toRecord() {
  test('toRecord() returns the expected record', () {
    final settings = Settings(TemperatureUnit.fahrenheit, VolumeUnit.gallons);
    final record = SettingsDao.toRecord(settings);

    expect(record.temperatureUnit, TemperatureUnit.fahrenheit.index);
    expect(record.volumeUnit, VolumeUnit.gallons.index);
  });
}
