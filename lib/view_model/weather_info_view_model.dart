import 'package:assignment4/model/weather_model.dart';
import 'package:assignment4/repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_info_view_model.g.dart';

@riverpod
class WeatherInfoViewModel extends _$WeatherInfoViewModel {
  final WeatherRepository weatherRepository = WeatherRepository(); // 객체 생성

  @override
  Future<WeatherModel> build() async {
    // Geolocator 로 위치 정보 가져오기
    Future<Position?> getPosition() async {
      final permission = await Geolocator.checkPermission();
      // 1. 현재 권한이 허용되지 않았을때 권한 요청하기
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // 2. 권한 요청 후 결과가 거부일 때 예외 처리
        final permission2 = await Geolocator.requestPermission();
        if (permission2 == LocationPermission.denied ||
            permission2 == LocationPermission.deniedForever) {
          throw Exception("위치 권한 거부됨");
        }
      }
      // 3. 권한이 허용되었을 때 위치 정보 가져와서 반환
      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        ),
      );
      return position;
    }

    // 위치 기반 날씨 가져오기
    Future<WeatherModel> getWeather() async {
      final position = await getPosition();

      final data = await weatherRepository.fetchWeather(
        lat: position!.latitude,
        lon: position!.longitude,
      );
      // 날씨 정보 가져와서 fromJson (Map > Dart 객체)
      return WeatherModel.fromJson(data["current"] as Map<String, dynamic>);
    }

    return await getWeather();
  }
}
