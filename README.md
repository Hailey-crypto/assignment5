<h1 align="center">
Just To Do
</h1>
<p align="center">
  <img alt="title" src="./assets/readme_title.webp"/>
</p>

<br/>

## 🔖 프로젝트 개요
### “Just To Do" 는 누구나 손쉽게 사용 가능한 To Do List 입니다.

#### Just To Do 는 다음과 같은 분들을 위해 탄생되었습니다.

> 해야 할 일들이 정리되지 않아 머릿속이 복잡한 분들
> 

> 간단하게 할 일 목록을 만들고, 완료하고, 삭제하고 싶은 분들
> 

> 복잡한 구조 없는 심플한 투두 리스트를 찾고 있는 분들
> 

<br/>     

## 🎨 앱 디자인 설계
<p align="center">
  <img alt="design" src="./assets/readme_design.webp"/>
</p>

<br/>

## 📌 주요 기능
1. 제목과 세부 내용(선택) 을 작성해 To Do 생성
2. To Do 목록 확인
3. To Do 를 눌러 세부 내용 확인
4. To Do 완료 여부 표시
5. To Do 즐겨찾기 여부 표시
6. To Do 삭제 
7. 현재 위치와 시간에 따른 날씨 정보 제공

<br/>

## 📂 프로젝트 구조
<pre>
lib/
 ㄴ main                           : 메인 실행 파일
 ㄴ core/
     ㄴ app_theme                  : 앱 전체의 테마 지정 (라이트/다크 모드 지원)
     ㄴ firebase_option            : Firebase 구셩파일
     ㄴ fixed_colors               : 테마 전환에도 변경되지 않는 색 정의 
     ㄴ variable_colors            : 테마 전환 시 변경되는 색 정의 
 ㄴ model/
     ㄴ to_do_model                : To Do 목록 Model 클래스
     ㄴ weather_model              : 날씨정보 Model 클래스
 ㄴ repository/
     ㄴ to_do_repository           : To Do 목록 Repository 클래스
     ㄴ weather_repository         : 날씨정보 Repository 클래스
 ㄴ view_model/
     ㄴ to_do_view_model           : To Do 목록 ViewModel 클래스
     ㄴ weather_info_view_model    : 날씨정보 ViewModel 클래스
 ㄴ view/
     ㄴ home/
         ㄴ add_to_do_dialog       : To Do 추가 위젯
         ㄴ home_page              : 홈 페이지
         ㄴ no_to_do               : To Do 가 없을 때 화면에 띄우는 위젯
         ㄴ to_do_view             : To Do 가 있을 때 화면에 띄우는 위젯
         ㄴ weather_view           : 현재 위치와 시간에 따른 날씨 정보 위젯
     ㄴ to_do_detail/
         ㄴ to_do_detail_page      : 세부 내용 페이지
assets/   : 앱 내에서 사용된 이미지 파일
README.md : 프로젝트 설명 문서
</pre>

<br/>

## 📝 커밋 컨벤션

- feat: 새로운 기능 추가
- fix: 버그 수정
- docs: 문서 수정
- style: 코드 포맷팅, 세미콜론 누락 등
- refactor: 코드 리팩터링
- test: 테스트 코드 추가
- chore: 빌드, 패키지 매니저 등 환경 설정
