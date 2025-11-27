import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
abstract class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    @JsonKey(fromJson: convertToDateTime) required DateTime time,
    @JsonKey(name: "is_day") required num isDay,
    @JsonKey(name: "weather_code", fromJson: convertWeatherCode)
    required String weatherDescription,
    @JsonKey(name: "temperature_2m") required num temperature,
    @JsonKey(name: "wind_speed_10m") required num windSpeed,
    @JsonKey(name: "uv_index", fromJson: convertUvIndex) required String uv,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, Object?> json) =>
      _$WeatherModelFromJson(json);
}

DateTime convertToDateTime(String timeString) {
  return DateTime.parse(timeString);
}

String convertWeatherCode(int code) {
  if (code == 0) return "맑음";
  if ([1, 2, 3].contains(code)) return "부분 흐림 또는 구름 많음";
  if ([45, 48].contains(code)) return "안개";
  if ([51, 53, 55].contains(code)) return "이슬비";
  if ([56, 57].contains(code)) return "언 이슬비";
  if ([61, 63, 65].contains(code)) return "비";
  if ([66, 67].contains(code)) return "언 비";
  if ([71, 73, 75].contains(code)) return "눈";
  if (code == 77) return "눈송이";
  if ([80, 81, 82].contains(code)) return "소나기";
  if ([85, 86].contains(code)) return "눈 소나기";
  if (code == 95) return "천둥 번개";
  if ([96, 99].contains(code)) return "번개와 우박";
  return "알 수 없음";
}

String convertUvIndex(double index) {
  final uv = index.toInt();
  if (uv <= 2) return "낮음 - 겉옷, 자외선 차단제";
  if (uv <= 5) return "보통 - 겉옷, 자외선 차단제";
  if (uv <= 7) return "높음 - 겉옷, 모자, 선글라스, 자외선 차단제";
  if (uv <= 10) return "매우 높음 - 겉옷, 모자, 선글라스, 자외선 차단제";
  if (uv >= 11) return "위험 - 겉옷, 모자, 선글라스, 자외선 차단제 (2시간마다)";
  return "알 수 없음";
}
