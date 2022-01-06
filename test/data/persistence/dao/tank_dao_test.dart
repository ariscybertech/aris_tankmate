import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/data/model/tank.dart';
import 'package:tank_mates/data/persistence/dao/tank_dao.dart';
import 'package:tank_mates/data/persistence/hive/TankRecord.dart';

final puffer = Species(
    "Tetraodon abei",
    "Abei Puffer",
    "Tetraodon abei",
    "puffer",
    Aggressiveness.aggressive,
    6.0,
    7.8,
    73,
    81,
    3,
    15,
    CareLevel.moderate,
    4,
    Diet.carnivore,
    20);

final acara = Species(
    "Aequidens diadema",
    "Acara",
    "Aequidens diadema",
    "american cichlids",
    Aggressiveness.semi_aggressive,
    6.6,
    7.5,
    72,
    83,
    4,
    20,
    CareLevel.moderate,
    4.7,
    Diet.omnivore,
    29);

final catfish = Species(
    "Leiarius marmoratus",
    "Achara Catfish",
    "Leiarius marmoratus",
    "misc catfish",
    Aggressiveness.semi_aggressive,
    5.8,
    7.4,
    69,
    77,
    8,
    18,
    CareLevel.moderate,
    31,
    Diet.carnivore,
    150);

final availableSpecies = [puffer, acara, catfish];

void main() {
  toModel();
  toRecord();
}

void toModel() {
  test('toModel() returns the expected Tank', () {
    final tankRecord = TankRecord(0, 'my tank', 20, ["Tetraodon abei"]);
    final model = TankDao.toModel(123, tankRecord, availableSpecies);

    expect(model.id, 123);
    expect(model.name, 'my tank');
    expect(model.gallons, 20);
    expect(model.species.length, 1);
    expect(model.species[0] == puffer, true);
  });
}

void toRecord() {
  test('toRecord() returns the expected record', () {
    final tank = Tank(321, 'my tank', 20, [catfish]);
    final record = TankDao.toRecord(tank);

    expect(record.id, 321);
    expect(record.name, 'my tank');
    expect(record.gallons, 20);
    expect(record.speciesKeys.length, 1);
    expect(record.speciesKeys[0] == catfish.key, true);
  });
}
