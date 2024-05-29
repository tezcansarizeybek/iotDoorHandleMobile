class TempHumModel {
  TempHumModel({this.humidity, this.temperature});

  final double? temperature;
  final double? humidity;

  factory TempHumModel.fromJson(Map<String, dynamic> json) => TempHumModel(
        temperature: json["temperature"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "humidity": humidity,
      };
}
