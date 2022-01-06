import 'package:hive/hive.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/data/persistence/hive/SpeciesRecord.dart';
import 'package:tank_mates/data/persistence/hive/hive_constants.dart';

/*
 * Note: For future use, not currently used.
 */
class SpeciesDao {
  void updateOrInsert(Species species) async {
    final box = await Hive.openBox(kSpeciesTableKey);
    box.put(species.key, species);
  }

  Future<Species> getSpecies(String key) async {
    final box = await Hive.openBox(kSpeciesTableKey);
    return box.get(key);
  }

  Future<List<Species>> getAllSpecies() async {
    final box = await Hive.openBox(kSpeciesTableKey);
    return box.values.toList();
  }

  static Species toModel(SpeciesRecord record) {
    return Species(
        record.key,
        record.name,
        record.scientificName,
        record.speciesGroup,
        Aggressiveness.values[record.aggressiveness],
        record.phMin,
        record.phMax,
        record.tempMin,
        record.tempMax,
        record.hardnessMin,
        record.hardnessMax,
        CareLevel.values[record.careLevel],
        record.maximumAdultSize,
        Diet.values[record.diet],
        record.minTankSize);
  }

  static SpeciesRecord toRecord(Species model) {
    return SpeciesRecord(
        model.key,
        model.name,
        model.scientificName,
        model.speciesGroup,
        model.aggressiveness.index,
        model.phMin,
        model.phMax,
        model.tempMin,
        model.tempMax,
        model.hardnessMin,
        model.hardnessMax,
        model.careLevel.index,
        model.maximumAdultSize,
        model.diet.index,
        model.minTankSize);
  }
}
