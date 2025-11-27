import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepository {
  // Open-Meteo API 로 날씨 정보 가져오기
  Future<Map<String, dynamic>> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    // API URL
    final url = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': lat.toString(),
      'longitude': lon.toString(),
      'current': 'temperature_2m,weather_code,wind_speed_10m,is_day,uv_index',
      'timezone': 'Asia/Seoul',
    });
    // API 요청
    final response = await http.get(url);
    // 요청 실패 시 예외 처리
    if (response.statusCode != 200) {
      throw Exception("API 요청 실패");
    }
    // 요청 성공 시 jsonDecode (String > Map)
    return jsonDecode(response.body);
  }
}
