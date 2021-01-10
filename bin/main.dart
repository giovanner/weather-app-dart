import 'dart:io';

import 'weather_api_client.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1) {
    print('Syntax valid is : dart bin/main.dart <city>');
    return;
  }
  final cityReturn = WeatherApiClient();
  final city = arguments.first;
  try {
    final cityWeather = await cityReturn.getWeather(city);
    print(cityWeather);
  } on WeatherApiException catch (e) {
    print(e.message);
  } on SocketException catch (_) {
    print('You are Offline, please go online to use ther weather App');
  } catch (e) {
    print(e);
  }
}
