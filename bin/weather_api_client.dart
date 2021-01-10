import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/weather.dart';

class WeatherApiException implements Exception {
  const WeatherApiException(this.message);
  final String message;
}

class WeatherApiClient {
  static const baseUrl = 'https://www.metaweather.com/api';

  Future<int> getCityId(String cityName) async {
    final localtionUrl = '$baseUrl/location/search/?query=$cityName';
    final locationResponse = await http.get(localtionUrl);
    if (locationResponse.statusCode != 200) {
      throw WeatherApiException(
          'Error code ${locationResponse.statusCode} when trying to get the city  ');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    if (locationJson.isEmpty) {
      throw WeatherApiException('City not Found');
    }
    return locationJson.first['woeid'] as int;
  }

  Future<Weather> fechWeather(int locaton) async {
    final weatherUrl = '$baseUrl/location/$locaton';
    final weatherResponse = await http.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception(
          'Error code ${weatherResponse.statusCode} when trying to get the city  ');
    }
    final weatehrJson = jsonDecode(weatherResponse.body);
    final consolidadeWeather = weatehrJson['consolidated_weather'] as List;
    if (consolidadeWeather.isEmpty) {
      throw WeatherApiException('No Weather to this location');
    }
    return Weather.fromJson(consolidadeWeather[0]);
  }

  Future<Weather> getWeather(String city) async {
    final locationId = await getCityId(city);
    return fechWeather(locationId);
  }
}
