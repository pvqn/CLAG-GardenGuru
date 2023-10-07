import 'package:gardenguru/models/plant.dart';
import 'package:gardenguru/models/province.dart';
import 'package:gardenguru/utils/temperature_support.dart';

List<String> getListofPlantName(List<Plant> plants) {
  List<String> names = [];
  for (int i = 0; i < plants.length; ++i) {
    names.add(plants[i].name);
  }
  return names;
}

List<Plant> findByCategory(List<Plant> plants, String category) {
  if (category == 'Any') return plants;
  List<Plant> result = [];
  for (int i = 0; i < plants.length; ++i) {
    if (plants[i].type == category) {
      result.add(plants[i]);
    }
  }
  return result;
}

List<Plant> findByDayAndTemp(List<Plant> plants, int day, Province province) {
  List<Plant> result = [];
  if (province != null && province.months != null) {
    if (day < 365) {
      int temp = getAverageTemperatureForSixMonths(province, isJanuary());

      for (int i = 0; i < plants.length; ++i) {
        if (plants[i].growingDuration != null &&
            plants[i].growingDuration['max'] != null &&
            temp != null &&
            plants[i].temperature != null &&
            plants[i].temperature['max'] != null &&
            plants[i].growingDuration['max']! < day &&
            temp < plants[i].temperature['max']!) {
          // Add null check with '!'
          result.add(plants[
              i]); // Add the plant to the result list if it meets the conditions
        }
      }
    } else if (day >= 365 && day < 365 * 2) {
      int temp = getAverageTemperature(province);

      for (int i = 0; i < plants.length; ++i) {
        if (plants[i].growingDuration != null &&
            plants[i].growingDuration['max'] != null &&
            temp != null &&
            plants[i].temperature != null &&
            plants[i].temperature['max'] != null &&
            plants[i].growingDuration['max']! < day &&
            temp < plants[i].temperature['max']!) {
          result.add(plants[i]);
        }
      }
    } else {
      int temp = getAverageTemperature(province);

      for (int i = 0; i < plants.length; ++i) {
        if (plants[i].growingDuration != null &&
            plants[i].growingDuration['max'] != null &&
            temp != null &&
            plants[i].temperature != null &&
            plants[i].temperature['max'] != null &&
            plants[i].growingDuration['max']! > day &&
            temp < plants[i].temperature['max']!) {
          result.add(plants[i]);
        }
      }
    }
  }

  return result;
}
