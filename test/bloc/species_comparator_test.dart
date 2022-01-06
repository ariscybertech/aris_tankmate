import 'package:flutter_test/flutter_test.dart';
import 'package:tank_mates/bloc/species_comparator.dart';
import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/util/constants.dart';

void main() {
  testDetermineAggressiveness();
  testDetermineCareLevel();
  testDetermineMinTankSize();
  testDetermineStockingPercent();
  testDetermineMinTemp();
  testDetermineMaxTemp();
  testDetermineMinPh();
  testDetermineMaxPh();
  testDetermineMinHardness();
  testDetermineMaxHardness();
  testDetermineRecommendationFood();
  testDetermineFishOverMinTankSize();
}

void testDetermineAggressiveness() {
  final speciesComparator = SpeciesComparator();

  final Species peacefulFish = Species.empty();
  peacefulFish.aggressiveness = Aggressiveness.peaceful;

  final Species moderateFish = Species.empty();
  moderateFish.aggressiveness = Aggressiveness.moderate;

  final Species semiAggressiveFish = Species.empty();
  semiAggressiveFish.aggressiveness = Aggressiveness.semi_aggressive;

  final Species aggressiveFish = Species.empty();
  aggressiveFish.aggressiveness = Aggressiveness.aggressive;

  test('determineAggressiveness returns peaceful for empty list', () {
    final List<Species> fishList = [];

    Aggressiveness foundAggressiveness =
        speciesComparator.determineAggressiveness(fishList);

    expect(foundAggressiveness, Aggressiveness.peaceful);
  });

  test(
      'determineAggressiveness returns peaceful if only peaceful fish are in list',
      () {
    final List<Species> fishList = [
      peacefulFish,
      peacefulFish,
      peacefulFish,
      peacefulFish
    ];

    Aggressiveness determinedAggressiveness =
        speciesComparator.determineAggressiveness(fishList);

    expect(determinedAggressiveness, Aggressiveness.peaceful);
  });

  test(
      'determineAggressiveness returns moderate if peaceful and moderate are in list',
      () {
    final List<Species> fishList = [
      peacefulFish,
      moderateFish,
      peacefulFish,
      peacefulFish
    ];

    Aggressiveness determinedAggressiveness =
        speciesComparator.determineAggressiveness(fishList);

    expect(determinedAggressiveness, Aggressiveness.moderate);
  });

  test(
      'determineAggressiveness returns semi_aggressive if peaceful, moderate, and semi-aggressive are in list',
      () {
    final List<Species> fishList = [
      peacefulFish,
      moderateFish,
      semiAggressiveFish,
      peacefulFish
    ];

    Aggressiveness determinedAggressiveness =
        speciesComparator.determineAggressiveness(fishList);

    expect(determinedAggressiveness, Aggressiveness.semi_aggressive);
  });

  test('determineAggressiveness returns aggressive if aggressive is in list',
      () {
    final List<Species> fishList = [
      peacefulFish,
      moderateFish,
      semiAggressiveFish,
      aggressiveFish
    ];

    Aggressiveness determinedAggressiveness =
        speciesComparator.determineAggressiveness(fishList);

    expect(determinedAggressiveness, Aggressiveness.aggressive);
  });
}

void testDetermineCareLevel() {
  final speciesComparator = SpeciesComparator();

  final Species easyFish = Species.empty();
  easyFish.careLevel = CareLevel.easy;

  final Species moderateFish = Species.empty();
  moderateFish.careLevel = CareLevel.moderate;

  final Species difficultFish = Species.empty();
  difficultFish.careLevel = CareLevel.difficult;

  final Species expertFish = Species.empty();
  expertFish.careLevel = CareLevel.expert;

  test('determineCareLevel returns easy for empty list', () {
    final List<Species> fishList = [];
    CareLevel determinedCareLevel =
        speciesComparator.determineCareLevel(fishList);

    expect(determinedCareLevel, CareLevel.easy);
  });

  test('determineCareLevel returns easy if only easy fish are in list', () {
    final List<Species> fishList = [easyFish, easyFish, easyFish, easyFish];
    CareLevel determinedCareLevel =
        speciesComparator.determineCareLevel(fishList);

    expect(determinedCareLevel, CareLevel.easy);
  });

  test('determineCareLevel returns moderate if easy and moderate are in list',
      () {
    final List<Species> fishList = [easyFish, moderateFish, easyFish, easyFish];
    CareLevel determinedCareLevel =
        speciesComparator.determineCareLevel(fishList);

    expect(determinedCareLevel, CareLevel.moderate);
  });

  test(
      'determineCareLevel returns difficult if easy, moderate, and difficult are in list',
      () {
    final List<Species> fishList = [
      easyFish,
      moderateFish,
      difficultFish,
      easyFish
    ];

    CareLevel determinedCareLevel =
        speciesComparator.determineCareLevel(fishList);

    expect(determinedCareLevel, CareLevel.difficult);
  });

  test('determineCareLevel returns expert if expert is in list', () {
    final List<Species> fishList = [
      easyFish,
      moderateFish,
      difficultFish,
      expertFish
    ];

    CareLevel determinedCareLevel =
        speciesComparator.determineCareLevel(fishList);

    expect(determinedCareLevel, CareLevel.expert);
  });
}

void testDetermineMinTankSize() {
  final speciesComparator = SpeciesComparator();

  final Species fishSize1 = Species.empty();
  fishSize1.minTankSize = 1;

  final Species fishSize2 = Species.empty();
  fishSize2.minTankSize = 2;

  test('determineMinTankSize returns 0 for empty list', () {
    final List<Species> fishList = [];
    int minTankSize = speciesComparator.determineMinTankSize(fishList);

    expect(minTankSize, 0);
  });

  test(
      'determineMinTankSize returns minTankSize of single fish in list only containing that fish',
      () {
    final List<Species> fishList = [fishSize1];
    int minTankSize = speciesComparator.determineMinTankSize(fishList);

    expect(minTankSize, fishSize1.minTankSize);
  });

  test(
      'determineMinTankSize returns minTankSize of fish with largest minTankSize in list of differing fish',
      () {
    final List<Species> fishList = [fishSize1, fishSize2];
    int minTankSize = speciesComparator.determineMinTankSize(fishList);

    expect(minTankSize, fishSize2.minTankSize);
  });
}

void testDetermineStockingPercent() {
  final speciesComparator = SpeciesComparator();

  final Species fishSize1 = Species.empty();
  fishSize1.maximumAdultSize = 1;

  test(
      'determineStocking returns 0 (int) when passed an empty list and 0 gallons',
      () {
    final List<Species> fishList = [];
    final int gallons = 0;
    int stockingPercent =
        speciesComparator.determineStockingPercent(fishList, gallons);

    expect(stockingPercent, 0);
  });

  test(
      'determineStockingPercent returns 100 when passed a single fish of equal inches to gallons',
      () {
    final List<Species> fishList = [fishSize1];
    final int gallons = fishSize1.maximumAdultSize.toInt();
    int stockingPercent =
        speciesComparator.determineStockingPercent(fishList, gallons);

    expect(stockingPercent, 100);
  });

  test(
      'determineStockingPercent returns 50 when passed a single fish of double gallons to max size',
      () {
    final List<Species> fishList = [fishSize1];
    final int gallons = fishSize1.maximumAdultSize.toInt() * 2;
    int stockingPercent =
        speciesComparator.determineStockingPercent(fishList, gallons);

    expect(stockingPercent, 50);
  });

  test(
      'determineStockingPercent returns 200 when passed a two fish of half gallons to total max size',
      () {
    final List<Species> fishList = [fishSize1, fishSize1];
    final int gallons = fishSize1.maximumAdultSize.toInt();
    int stockingPercent =
        speciesComparator.determineStockingPercent(fishList, gallons);

    expect(stockingPercent, 200);
  });

  test('determineStockingPercent returns 999 when passed a fish and 0 gallons',
      () {
    final List<Species> fishList = [fishSize1];
    final int gallons = 0;
    int stockingPercent =
        speciesComparator.determineStockingPercent(fishList, gallons);

    expect(stockingPercent, 999);
  });
}

void testDetermineMinTemp() {
  final speciesComparator = SpeciesComparator();

  final Species fish1 = Species.empty();
  fish1.tempMin = 70;
  fish1.tempMax = 80;

  final Species fish2 = Species.empty();
  fish2.tempMin = 65;
  fish2.tempMax = 80;

  final Species fish3 = Species.empty();
  fish3.tempMin = 40;
  fish3.tempMax = 80;

  test('determineMinTemp returns 0 (int) when passed an empty fish list', () {
    final List<Species> fishList = [];
    int minTemp = speciesComparator.determineMinTemp(fishList);

    expect(minTemp, 0);
  });

  test(
      'determineMinTemp returns the tempMin of a Fish if it is the only one in a list',
      () {
    final List<Species> fishList = [fish1];
    int minTemp = speciesComparator.determineMinTemp(fishList);

    expect(minTemp, fish1.tempMin);
  });

  test(
      'determineMinTemp returns the highest tempMin of three fish with different tempMins',
      () {
    final List<Species> fishList = [fish1, fish2, fish3];
    int minTemp = speciesComparator.determineMinTemp(fishList);

    expect(minTemp, fish1.tempMin);
  });
}

void testDetermineMaxTemp() {
  final speciesComparator = SpeciesComparator();

  final Species fish1 = Species.empty();
  fish1.tempMin = 50;
  fish1.tempMax = 60;

  final Species fish2 = Species.empty();
  fish2.tempMin = 65;
  fish2.tempMax = 70;

  final Species fish3 = Species.empty();
  fish3.tempMin = 40;
  fish3.tempMax = 80;

  test('determineMaxTemp returns 100 (int) when passed an empty fish list', () {
    final List<Species> fishList = [];
    int maxTemp = speciesComparator.determineMaxTemp(fishList);

    expect(maxTemp, 100);
  });

  test(
      'determineMaxTemp returns the tempMax of a Fish if it is the only one in a list',
      () {
    final List<Species> fishList = [fish1];
    int maxTemp = speciesComparator.determineMaxTemp(fishList);

    expect(maxTemp, fish1.tempMax);
  });

  test(
      'determineMaxTemp returns the smallest tempMax of three fish with different tempMaxes',
      () {
    final List<Species> fishList = [fish1, fish2, fish3];
    int maxTemp = speciesComparator.determineMaxTemp(fishList);

    expect(maxTemp, fish1.tempMax);
  });
}

void testDetermineMinPh() {
  final speciesComparator = SpeciesComparator();

  final Species fish1 = Species.empty();
  fish1.phMin = 6.0;
  fish1.phMax = 8.0;

  final Species fish2 = Species.empty();
  fish2.phMin = 7.0;
  fish2.phMax = 8.0;

  final Species fish3 = Species.empty();
  fish3.phMin = 8.0;
  fish3.phMax = 9.0;

  test('determineMinPh returns 0.0 (double) when passed an empty fish list',
      () {
    final List<Species> fishList = [];
    double minPh = speciesComparator.determineMinPh(fishList);

    expect(minPh, 0.0);
  });

  test(
      'determineMinPh returns the phMin of a Fish if it is the only one in a list',
      () {
    final List<Species> fishList = [fish1];
    double minPh = speciesComparator.determineMinPh(fishList);

    expect(minPh, fish1.phMin);
  });

  test(
      'determineMinPh returns the highest phMin of three fish with different phMins',
      () {
    final List<Species> fishList = [fish1, fish2, fish3];
    double minPh = speciesComparator.determineMinPh(fishList);

    expect(minPh, fish3.phMin);
  });
}

void testDetermineMaxPh() {
  final speciesComparator = SpeciesComparator();

  final Species fish1 = Species.empty();
  fish1.phMin = 6.0;
  fish1.phMax = 7.0;

  final Species fish2 = Species.empty();
  fish2.phMin = 7.0;
  fish2.phMax = 8.0;

  final Species fish3 = Species.empty();
  fish3.phMin = 8.0;
  fish3.phMax = 9.0;

  test('determineMaxPh returns 14.0 (double) when passed an empty fish list',
      () {
    final List<Species> fishList = [];
    double maxPh = speciesComparator.determineMaxPh(fishList);

    expect(maxPh, 14.0);
  });

  test(
      'determineMaxPh returns the phMax of a Fish if it is the only one in a list',
      () {
    final List<Species> fishList = [fish1];
    double maxPh = speciesComparator.determineMaxPh(fishList);

    expect(maxPh, fish1.phMax);
  });

  test(
      'determineMaxPh returns the lowest phMax of three fish with different phMaxes',
      () {
    final List<Species> fishList = [fish1, fish2, fish3];
    double maxPh = speciesComparator.determineMaxPh(fishList);

    expect(maxPh, fish1.phMax);
  });
}

void testDetermineMinHardness() {
  final speciesComparator = SpeciesComparator();

  final Species fish1 = Species.empty();
  fish1.hardnessMin = 5;
  fish1.hardnessMax = 20;

  final Species fish2 = Species.empty();
  fish2.hardnessMin = 10;
  fish2.hardnessMax = 20;

  final Species fish3 = Species.empty();
  fish3.hardnessMin = 15;
  fish3.hardnessMax = 20;

  test('determineMinHardness returns 0 (int) when passed an empty fish list',
      () {
    final List<Species> fishList = [];
    int minHardness = speciesComparator.determineMinHardness(fishList);

    expect(minHardness, 0);
  });

  test(
      'determineMinHardness returns the hardnessMin of a Fish if it is the only one in a list',
      () {
    final List<Species> fishList = [fish1];
    int minHardness = speciesComparator.determineMinHardness(fishList);

    expect(minHardness, fish1.hardnessMin);
  });

  test(
      'determineMinHardness returns the highest hardnessMin of three fish with different hardnessMin',
      () {
    final List<Species> fishList = [fish1, fish2, fish3];
    int minHardness = speciesComparator.determineMinHardness(fishList);

    expect(minHardness, fish3.hardnessMin);
  });
}

void testDetermineMaxHardness() {
  final speciesComparator = SpeciesComparator();

  final Species fish1 = Species.empty();
  fish1.hardnessMin = 5;
  fish1.hardnessMax = 10;

  final Species fish2 = Species.empty();
  fish2.hardnessMin = 10;
  fish2.hardnessMax = 15;

  final Species fish3 = Species.empty();
  fish3.hardnessMin = 15;
  fish3.hardnessMax = 20;

  test('determineMaxHardness returns 0 (int) when passed an empty fish list',
      () {
    final List<Species> fishList = [];
    int maxHardness = speciesComparator.determineMaxHardness(fishList);

    expect(maxHardness, 100);
  });

  test(
      'determineMaxHardness returns the hardnessMax of a Fish if it is the only one in a list',
      () {
    final List<Species> fishList = [fish1];
    int maxHardness = speciesComparator.determineMaxHardness(fishList);

    expect(maxHardness, fish1.hardnessMax);
  });

  test(
      'determineMaxHardness returns the highest hardnessMax of three fish with different hardnessMax',
      () {
    final List<Species> fishList = [fish1, fish2, fish3];
    int maxHardness = speciesComparator.determineMaxHardness(fishList);

    expect(maxHardness, fish1.hardnessMax);
  });
}

void testDetermineRecommendationFood() {
  final speciesComparator = SpeciesComparator();

  final Species fishCarnivore = Species.empty();
  fishCarnivore.diet = Diet.carnivore;

  final Species fishHerbivore = Species.empty();
  fishHerbivore.diet = Diet.herbivore;

  final Species fishOmnivore = Species.empty();
  fishOmnivore.diet = Diet.omnivore;

  test(
      'determineRecommendationFood returns null when passed an empty fish list',
      () {
    final List<Species> fishList = [];

    expect(null, speciesComparator.determineRecommendationFood(fishList));
  });

  test(
      'determineRecommendationFood returns kRecFoodCarnivore when passed a list containing only carnivores',
      () {
    final List<Species> fishList = [
      fishCarnivore,
      fishCarnivore,
      fishCarnivore
    ];

    expect(kRecFoodCarnivore,
        speciesComparator.determineRecommendationFood(fishList));
  });

  test(
      'determineRecommendationFood returns kRecFoodHerbivore when passed a list containing only herbivores',
      () {
    final List<Species> fishList = [
      fishHerbivore,
      fishHerbivore,
      fishHerbivore
    ];

    expect(kRecFoodHerbivore,
        speciesComparator.determineRecommendationFood(fishList));
  });

  test(
      'determineRecommendationFood returns kRecFoodOmnivore when passed a list containing herbivores and carnivores',
      () {
    final List<Species> fishList = [
      fishHerbivore,
      fishCarnivore,
      fishHerbivore
    ];

    expect(kRecFoodOmnivore,
        speciesComparator.determineRecommendationFood(fishList));
  });

  test(
      'determineRecommendationFood returns kRecFoodOmnivore when passed a list containing only omnivores',
      () {
    final List<Species> fishList = [fishOmnivore, fishOmnivore, fishOmnivore];

    expect(kRecFoodOmnivore,
        speciesComparator.determineRecommendationFood(fishList));
  });

  test(
      'determineRecommendationFood returns kRecFoodOmnivore when passed a list containing omnivores, herbivores, carnivores',
      () {
    final List<Species> fishList = [fishOmnivore, fishCarnivore, fishHerbivore];

    expect(kRecFoodOmnivore,
        speciesComparator.determineRecommendationFood(fishList));
  });
}

void testDetermineFishOverMinTankSize() {
  final speciesComparator = SpeciesComparator();

  final Species fish10 = Species.empty();
  fish10.name = '10 inch fish';
  fish10.minTankSize = 10;

  final Species fish55 = Species.empty();
  fish55.name = '55 inch fish';
  fish55.minTankSize = 55;

  test(
      'determineFishOverMinTankSize returns an empty list when passed an empty fish list',
      () {
    final List<Species> fishList = [];
    final int tankSize = 20;

    expect(
        [], speciesComparator.determineFishOverMinTankSize(fishList, tankSize));
  });

  test(
      'determineFishOverMinTankSize returns an empty list when passed an all fish under the tank size',
      () {
    final List<Species> fishList = [fish10, fish10];
    final int tankSize = 20;

    expect(
        [], speciesComparator.determineFishOverMinTankSize(fishList, tankSize));
  });

  test(
      'determineFishOverMinTankSize returns the name of a fish over size when passed it',
      () {
    final List<Species> fishList = [fish10, fish55];
    final int tankSize = 20;

    expect([fish55],
        speciesComparator.determineFishOverMinTankSize(fishList, tankSize));
  });

  test(
      'determineFishOverMinTankSize returns only a single item for name of a fish over size when passed multiple versions of it',
      () {
    final List<Species> fishList = [fish55, fish55];
    final int tankSize = 20;

    expect([fish55],
        speciesComparator.determineFishOverMinTankSize(fishList, tankSize));
  });
}
