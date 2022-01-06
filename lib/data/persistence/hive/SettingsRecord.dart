import 'package:hive/hive.dart';

part 'SettingsRecord.g.dart';

@HiveType(typeId: 0)
class SettingsRecord {
  @HiveField(0)
  final int temperatureUnit;
  @HiveField(1)
  final int volumeUnit;

  SettingsRecord(this.temperatureUnit, this.volumeUnit);
}
