// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) =>
    _WeatherModel(
      time: convertToDateTime(json['time'] as String),
      isDay: json['is_day'] as num,
      weatherDescription: convertWeatherCode(
        (json['weather_code'] as num).toInt(),
      ),
      temperature: json['temperature_2m'] as num,
      windSpeed: json['wind_speed_10m'] as num,
      uv: convertUvIndex((json['uv_index'] as num).toDouble()),
    );

Map<String, dynamic> _$WeatherModelToJson(_WeatherModel instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'is_day': instance.isDay,
      'weather_code': instance.weatherDescription,
      'temperature_2m': instance.temperature,
      'wind_speed_10m': instance.windSpeed,
      'uv_index': instance.uv,
    };
