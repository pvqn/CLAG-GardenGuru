import 'package:gardenguru/models/province.dart';

int getAverageTemperature(Province province) {
  int januaryMin = province.months['January']?.min ?? 0;
  int januaryMax = province.months['January']?.max ?? 0;
  int julyMin = province.months['July']?.min ?? 0;
  int julyMax = province.months['July']?.max ?? 0;

  // Calculate the average of January and July minimum temperatures
  int januaryAvg = (januaryMin + januaryMax) ~/ 2;
  int julyAvg = (julyMin + julyMax) ~/ 2;

  // Calculate the overall average temperature
  int averageTemperature = (januaryAvg + julyAvg) ~/ 2;

  return averageTemperature;
}

int getAverageTemperatureForSixMonths(Province province, bool isJanuary) {
  int januaryMin = province.months['January']?.min ?? 0;
  int januaryMax = province.months['January']?.max ?? 0;
  int julyMin = province.months['July']?.min ?? 0;
  int julyMax = province.months['July']?.max ?? 0;

  // Calculate the average of January and July minimum temperatures
  int januaryAvg = (januaryMin + januaryMax) ~/ 2;
  int julyAvg = (julyMin + julyMax) ~/ 2;

  if (isJanuary) {
    return januaryAvg;
  } else
    return julyAvg;
}

bool isJanuary() {
  DateTime now = DateTime.now();
  int currentMonth = now.month;
  if (currentMonth < 7) {
    return true;
  } else {
    return false;
  }
}

int celsiusToFahrenheit(int celsius) {
  return ((celsius * 9 / 5) + 32).toInt();
}
