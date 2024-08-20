# acote_flutter_engineer

개발환경
장비 : 맥M1 pro
IDE : Android Studio Iguana 2023.2.1 Patch 2
Flutter / dart version : 3.22.3 / 3.3.4

에러가 있다면 프로젝트 경로 터미널에서 
flutter clean -> flutter pub get -> dart run build_runner build
입력 후 실행합니다.

홈화면은 BottomNavationBar-IndexedStack를 이용하여 구현 및
메모리효율을 위해 ListView.builder를 사용하였으며
화면에 진입하자마자 api호출을 위한 AsyncNotifier/FutureProvider를 
사용하여 구현하였습니다.

사용해보지 않은 Getx와 비교적 복잡하지 않기 때문에 Bloc는 제외하였으며, 
Riverved 채용를 하였습니다.