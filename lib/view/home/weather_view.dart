import 'package:assignment4/view_model/weather_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WeatherView extends HookConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WeatherInfoViewModel 구독
    final weather = ref.watch(weatherInfoViewModelProvider);

    // UI 렌더링
    return weather.when(
      data: (w) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 10,
        children: [
          // 시간
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              Text(
                style: TextStyle(fontSize: 15),
                "업데이트 시간: ${w.time.year}년 ${w.time.month}월 ${w.time.day}일 ${w.time.hour}시 ${w.time.minute}분",
              ),
              Icon(
                6 <= w.time.hour && w.time.hour < 18
                    ? Icons.light_mode
                    : Icons.dark_mode,
              ),
            ],
          ),
          // 날씨 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            spacing: 10,
            children: [
              Text(
                style: TextStyle(fontSize: 15),
                "날씨: ${w.weatherDescription}",
              ),
              Text(style: TextStyle(fontSize: 15), "온도: ${w.temperature}°C"),
              Text(style: TextStyle(fontSize: 15), "풍속: ${w.windSpeed}"),
            ],
          ),
          // 자외선 정보 (나만의 추가 기능 구현)
          Text(style: TextStyle(fontSize: 15), "자외선: ${w.uv}"),
        ],
      ),
      loading: () => Center(
        child: Text("날씨 정보를 불러오는 중...", style: TextStyle(fontSize: 14)),
      ),

      error: (e, s) => Center(
        child: Text("날씨 정보를 불러올 수 없습니다.", style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
