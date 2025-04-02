// ignore_for_file: prefer_typing_uninitialized_variables

class Weather {
  final cityname;
  final temperature;
  final condition;

  Weather({
    required this.cityname,
    required this.temperature,
    required this.condition,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityname: json['name'],
      temperature: json['main']['temp'].todouble(),
      condition: json['weather']['0']['main'],
    );
  }

  get mainCondition => null;
}
