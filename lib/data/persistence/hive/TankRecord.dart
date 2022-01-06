import 'package:hive/hive.dart';

part 'TankRecord.g.dart';

@HiveType(typeId: 2)
class TankRecord {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int gallons;

  @HiveField(3)
  final List<String> speciesKeys;

  TankRecord(this.id, this.name, this.gallons, this.speciesKeys);
}
