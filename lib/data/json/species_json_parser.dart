import 'dart:convert';

import 'package:tank_mates/data/json/species_json_data.dart';
import 'package:tank_mates/data/model/species.dart';

class SpeciesJsonParser {
  List<Species> parseJsonToSpeciesList(String jsonData) {
    var jsonObjects = jsonDecode(jsonData)['freshwater_data'] as List;

    List<SpeciesJsonData> speciesJsonDataList = jsonObjects
        .map((tagJson) => SpeciesJsonData.fromJson(tagJson))
        .toList();

    var speciesList = <Species>[];

    for (int i = 0; i < speciesJsonDataList.length; i++) {
      try {
        speciesList.add(parseSpecies(speciesJsonDataList[i]));
        speciesList[i].key = speciesJsonDataList[i].scientificName;
      } catch (e) {
        // If species cannot be parsed log error and continue to next
        print('Error parsing JSON for species: ${e.toString()}');
      }
    }

    return speciesList;
  }

  Species parseSpecies(SpeciesJsonData speciesJsonData) {
    Species species = new Species.empty();

    species.name = speciesJsonData.name;
    species.scientificName = speciesJsonData.scientificName;
    species.speciesGroup = speciesJsonData.speciesGroup;

    species.aggressiveness =
        parseAggressivenessFromString(speciesJsonData.aggressiveness);

    species.phMin = parsePhMinFromRange(speciesJsonData.phRange);
    species.phMax = parsePhMaxFromRange(speciesJsonData.phRange);

    species.tempMin = parseTempMinFromRange(speciesJsonData.temperatureRange);
    species.tempMax = parseTempMaxFromRange(speciesJsonData.temperatureRange);

    species.hardnessMin = parseHardnessMinFromRange(speciesJsonData.hardness);
    species.hardnessMax = parseHardnessMaxFromRange(speciesJsonData.hardness);

    species.careLevel = parseCareLevelFromString(speciesJsonData.careLevel);
    species.maximumAdultSize = parseMaxSize(speciesJsonData.maximumAdultSize);
    species.diet = parseDietFromString(speciesJsonData.diet);
    species.minTankSize = parseMinTankSize(speciesJsonData.minTankSize);

    return species;
  }

  Aggressiveness parseAggressivenessFromString(String aggrString) {
    switch (aggrString.toLowerCase().trim()) {
      case "aggressive":
        {
          return Aggressiveness.aggressive;
        }
        break;
      case "moderate":
        {
          return Aggressiveness.moderate;
        }
        break;
      case "peaceful":
        {
          return Aggressiveness.peaceful;
        }
        break;
      case "semi_aggressive":
        {
          return Aggressiveness.semi_aggressive;
        }
        break;
      default:
        {
          return Aggressiveness.moderate;
        }
        break;
    }
  }

  double parsePhMinFromRange(String phRangeString) {
    List<String> splitRangeString = phRangeString.split('-');
    return double.parse(splitRangeString[0].trim());
  }

  double parsePhMaxFromRange(String phRangeString) {
    List<String> splitRangeString = phRangeString.split('-');
    return double.parse(splitRangeString[1].trim());
  }

  int parseTempMinFromRange(String tempRangeString) {
    List<String> splitRangeString = tempRangeString.split('-');
    return int.parse(splitRangeString[0].trim());
  }

  int parseTempMaxFromRange(String tempRangeString) {
    List<String> splitRangeString = tempRangeString.split('-');
    return int.parse(splitRangeString[1].trim());
  }

  int parseHardnessMinFromRange(String hardnessRangeString) {
    List<String> splitRangeString = hardnessRangeString.split('-');
    return int.parse(splitRangeString[0].trim());
  }

  int parseHardnessMaxFromRange(String hardnessRangeString) {
    List<String> splitRangeString = hardnessRangeString.split('-');
    return int.parse(splitRangeString[1].trim());
  }

  CareLevel parseCareLevelFromString(String careLevelString) {
    switch (careLevelString.toLowerCase().trim()) {
      case "easy":
        {
          return CareLevel.easy;
        }
        break;
      case "moderate":
        {
          return CareLevel.moderate;
        }
        break;
      case "difficult":
        {
          return CareLevel.difficult;
        }
        break;
      case "expert":
        {
          return CareLevel.expert;
        }
        break;
      default:
        {
          return CareLevel.moderate;
        }
        break;
    }
  }

  double parseMaxSize(String maxSizeString) {
    return double.parse(maxSizeString.trim());
  }

  Diet parseDietFromString(String dietString) {
    switch (dietString.toLowerCase().trim()) {
      case "herbivore":
        {
          return Diet.herbivore;
        }
        break;
      case "omnivore":
        {
          return Diet.omnivore;
        }
        break;
      case "carnivore":
        {
          return Diet.carnivore;
        }
        break;
      default:
        {
          return Diet.omnivore;
        }
        break;
    }
  }

  int parseMinTankSize(String minTankSizeString) {
    return int.parse(minTankSizeString.trim());
  }
}
