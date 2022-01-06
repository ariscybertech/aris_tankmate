import 'package:hive/hive.dart';
import 'package:tank_mates/data/model/settings.dart';
import 'package:tank_mates/data/persistence/hive/SettingsRecord.dart';
import 'package:tank_mates/data/persistence/hive/hive_constants.dart';

class SettingsDao {
  Future<Settings> update(Settings settings) async {
    final box = Hive.box(kSettingsTableKey);
    final record = toRecord(settings);

    box.put('settings', record);
    return settings;
  }

  Future<Settings> getSettings() async {
    final box = Hive.box(kSettingsTableKey);
    SettingsRecord record = await box.get('settings');

    if (record == null) return Settings.general();

    return toModel(record);
  }

  static Settings toModel(SettingsRecord record) {
    return Settings(TemperatureUnit.values[record.temperatureUnit],
        VolumeUnit.values[record.volumeUnit]);
  }

  static SettingsRecord toRecord(Settings model) {
    return SettingsRecord(model.temperatureUnit.index, model.volumeUnit.index);
  }
}
