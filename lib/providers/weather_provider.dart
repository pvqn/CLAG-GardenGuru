import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:gardenguru/models/weather.dart';

class WeatherProvider extends ChangeNotifier {
  Weather _weather =
      Weather(description: 'test', temperature: 30, main: 'clear');

  Weather? get weather => _weather;

  Future<Weather> getWeather(String city) async {
    String apiKey = 'b187ae66c5954d73f58ed45096ff93d8';

    final apiUrl = 'https://api.openweathermap.org/data/2.5/weather';
    final response = await http.get(Uri.parse('$apiUrl?q=$city&appid=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      _weather = Weather(
          description: jsonData['weather'][0]['description'],
          temperature: jsonData['main']['temp'],
          main: jsonData['weather'][0]['main']
          // Parse other properties as needed
          );
      notifyListeners(); // Notify listeners about the updated weather data
      return _weather;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
