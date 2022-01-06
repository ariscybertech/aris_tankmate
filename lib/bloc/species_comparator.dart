import 'package:tank_mates/data/model/species.dart';
import 'package:tank_mates/util/constants.dart';

class SpeciesComparator {
  Aggressiveness determineAggressiveness(List<Species> speciesList) {
    Aggressiveness highestAggressiveness = Aggressiveness.peaceful;
    List<Aggressiveness> aggressionLevels = [];

    speciesList.forEach((species) {
      if (species.aggressiveness == Aggressiveness.moderate)
        aggressionLevels.add(Aggressiveness.moderate);
      else if (species.aggressiveness == Aggressiveness.semi_aggressive)
        aggressionLevels.add(Aggressiveness.semi_aggressive);
      else if (species.aggressiveness == Aggressiveness.aggressive)
        aggressionLevels.add(Aggressiveness.aggressive);
    });

    if (aggressionLevels.contains(Aggressiveness.aggressive))
      highestAggressiveness = Aggressiveness.aggressive;
    else if (aggressionLevels.contains(Aggressiveness.semi_aggressive))
      highestAggressiveness = Aggressiveness.semi_aggressive;
    else if (aggressionLevels.contains(Aggressiveness.moderate))
      highestAggressiveness = Aggressiveness.moderate;

    return highestAggressiveness;
  }

  CareLevel determineCareLevel(List<Species> speciesList) {
    CareLevel highestCareLevel = CareLevel.easy;
    List<CareLevel> careLevels = [];

    speciesList.forEach((species) {
      if (species.careLevel == CareLevel.moderate)
        careLevels.add(CareLevel.moderate);
      else if (species.careLevel == CareLevel.difficult)
        careLevels.add(CareLevel.difficult);
      else if (species.careLevel == CareLevel.expert)
        careLevels.add(CareLevel.expert);
    });

    if (careLevels.contains(CareLevel.expert))
      highestCareLevel = CareLevel.expert;
    else if (careLevels.contains(CareLevel.difficult))
      highestCareLevel = CareLevel.difficult;
    else if (careLevels.contains(CareLevel.moderate))
      highestCareLevel = CareLevel.moderate;

    return highestCareLevel;
  }

  int determineMinTankSize(List<Species> speciesList) {
    int greatestMinTank = 0;

    speciesList.forEach((species) {
      if (species.minTankSize > greatestMinTank) {
        greatestMinTank = species.minTankSize;
      }
    });

    return greatestMinTank;
  }

  //TODO: determine better formula other than inch per gallon
  int determineStockingPercent(List<Species> speciesList, int tankGallons) {
    if (speciesList.isEmpty) {
      return 0;
    }

    if (tankGallons == 0) {
      return 999;
    }

    double stockingPercent = 0.00;
    double totalInchesOfFish = 0.00;

    speciesList.forEach((species) {
      totalInchesOfFish += species.maximumAdultSize;
    });

    stockingPercent = totalInchesOfFish / tankGallons * 100;

    return stockingPercent.round();
  }

  int determineMinTemp(List<Species> speciesList) {
    int minTemp = 0;

    speciesList.forEach((species) {
      if (minTemp < species.tempMin) minTemp = species.tempMin;
    });

    return minTemp;
  }

  int determineMaxTemp(List<Species> speciesList) {
    int maxTemp = 100;

    speciesList.forEach((species) {
      if (maxTemp > species.tempMax) maxTemp = species.tempMax;
    });

    return maxTemp;
  }

  double determineMinPh(List<Species> speciesList) {
    double minPh = 0.0;

    speciesList.forEach((species) {
      if (minPh < species.phMin) minPh = species.phMin;
    });

    return minPh;
  }

  double determineMaxPh(List<Species> speciesList) {
    double maxPh = 14.0;

    speciesList.forEach((species) {
      if (maxPh > species.phMax) maxPh = species.phMax;
    });

    return maxPh;
  }

  int determineMinHardness(List<Species> speciesList) {
    int minHardness = 0;

    speciesList.forEach((species) {
      if (minHardness < species.hardnessMin) minHardness = species.hardnessMin;
    });

    return minHardness;
  }

  int determineMaxHardness(List<Species> speciesList) {
    int maxHardness = 100;

    speciesList.forEach((species) {
      if (maxHardness > species.hardnessMax) maxHardness = species.hardnessMax;
    });

    return maxHardness;
  }

  String determineRecommendationFood(List<Species> speciesList) {
    bool hasCarnivore = false;
    bool hasHerbivore = false;
    bool hasOmnivore = false;

    speciesList.forEach((species) {
      if (species.diet == Diet.carnivore)
        hasCarnivore = true;
      else if (species.diet == Diet.herbivore)
        hasHerbivore = true;
      else if (species.diet == Diet.omnivore) hasOmnivore = true;
    });

    if (hasOmnivore || (hasCarnivore && hasHerbivore)) {
      return kRecFoodOmnivore;
    }

    if (hasHerbivore && !hasCarnivore) {
      return kRecFoodHerbivore;
    }

    if (hasCarnivore && !hasHerbivore) {
      return kRecFoodCarnivore;
    }

    return null;
  }

  List<Species> determineFishOverMinTankSize(
      List<Species> speciesList, int tankSize) {
    List<Species> overSizedSpecies = [];

    speciesList.forEach((species) {
      if (species.minTankSize > tankSize &&
          (!overSizedSpecies.contains(species))) {
        overSizedSpecies.add(species);
      }
    });

    return overSizedSpecies;
  }
}
