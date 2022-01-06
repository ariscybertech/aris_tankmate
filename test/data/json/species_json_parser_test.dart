import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/data/json/species_json_parser.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/util/constants.dart';

final SpeciesJsonParser jsonParser = SpeciesJsonParser();

void main() async {
  // Required to use rootBundle for asset loading in tests
  TestWidgetsFlutterBinding.ensureInitialized();

  // Parse json to Species list
  final json = await rootBundle.loadString(kFreshwaterSpeciesJson);
  List<Species> species = jsonParser.parseJsonToSpeciesList(json);

  // Run tests
  parsingReturnsExpectedNumSpecies(species);
  noNullValues(species);
  keysMatchScientificNames(species);
  noDuplicateKeysExist(species);
  invalidSpeciesIsSkipped();
}

void parsingReturnsExpectedNumSpecies(List<Species> species) {
  test('parse returns the expected number of species', () {
    expect(species.length, 596);
  });
}

void noNullValues(List<Species> species) {
  test('no null values are present in any species', () {
    for (var i = 0; i < species.length; i++) {
      expect(species[i].key != null, true);
      expect(species[i].name != null, true);
      expect(species[i].scientificName != null, true);
      expect(species[i].speciesGroup != null, true);
      expect(species[i].aggressiveness != null, true);
      expect(species[i].phMin != null, true);
      expect(species[i].phMax != null, true);
      expect(species[i].tempMin != null, true);
      expect(species[i].tempMax != null, true);
      expect(species[i].hardnessMin != null, true);
      expect(species[i].hardnessMax != null, true);
      expect(species[i].careLevel != null, true);
      expect(species[i].maximumAdultSize != null, true);
      expect(species[i].diet != null, true);
      expect(species[i].minTankSize != null, true);
    }
  });
}

void keysMatchScientificNames(List<Species> species) {
  test('each key matches the species scientific name', () {
    for (var i = 0; i < species.length; i++) {
      expect(species[i].key == species[i].scientificName, true);
    }
  });
}

void noDuplicateKeysExist(List<Species> species) {
  test('no duplicate keys exist in the species list', () {
    List<String> keys = species.map((item) => item.key).toList();
    List<String> distinctKeys = keys.toSet().toList();

    print('keys: ${keys.length}');
    print('distinctKeys: ${distinctKeys.length}');
    expect(keys.length == distinctKeys.length, true);
  });
}

void invalidSpeciesIsSkipped() {
  test('invalid species in json is skipped', () async {
    final json =
        await rootBundle.loadString('assets/freshwater_data_invalid.json');
    List<Species> species = jsonParser.parseJsonToSpeciesList(json);
    expect(species.length, 595);
  });
}
