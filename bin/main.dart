import 'weather_api_client.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1) {
    print('Syntax valid is : dart bin/main.dart <city>');
    return;
  }
  final cityReturn = WeatherApiClient();
  final city = arguments.first;
  final cityWeather = await cityReturn.getWeather(city);
  print(cityWeather);
}
