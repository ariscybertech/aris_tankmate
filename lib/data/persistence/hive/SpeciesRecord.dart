import 'package:hive/hive.dart';

part 'SpeciesRecord.g.dart';

/*
 * Note: For future use, not currently used.
 */
@HiveType(typeId: 1)
class SpeciesRecord {
  @HiveField(0)
  final String key;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String scientificName;

  @HiveField(3)
  final String speciesGroup;

  @HiveField(4)
  final int aggressiveness;

  @HiveField(5)
  final double phMin;

  @HiveField(6)
  final double phMax;

  @HiveField(7)
  final int tempMin;

  @HiveField(8)
  final int tempMax;

  @HiveField(9)
  final int hardnessMin;

  @HiveField(10)
  final int hardnessMax;

  @HiveField(11)
  final int careLevel;

  @HiveField(12)
  final double maximumAdultSize;

  @HiveField(13)
  final int diet;

  @HiveField(14)
  final int minTankSize;

  SpeciesRecord(
      this.key,
      this.name,
      this.scientificName,
      this.speciesGroup,
      this.aggressiveness,
      this.phMin,
      this.phMax,
      this.tempMin,
      this.tempMax,
      this.hardnessMin,
      this.hardnessMax,
      this.careLevel,
      this.maximumAdultSize,
      this.diet,
      this.minTankSize);
}
