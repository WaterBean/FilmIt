# FilmIt
마음에 드는 영화를 검색하고 저장하세요!

##  앱 소개
FilmIt은 영화 탐색 및 북마크 기능을 제공하는 iOS 앱입니다. TMDB API를 활용하여 영화 정보를 제공하고, 사용자가 관심 있는 영화를 저장할 수 있습니다.

### 진행 기간
2025.01.24 ~ 2025.02(진행 중)

### 개발 환경

- iOS 16.0+
- Swift 5
- Xcode 16

### 팀 / 역할
1인 / iOS

### 사용 기술

#### 프레임워크 & 라이브러리
- UIKit(Codebase)
- SnapKit, Kingfisher, Alamofire with Swift Package Manager

#### 아키텍처 패턴
Cocoa MVC → MVVM 리팩토링 진행 중...

#### OpenAPI
The Movie Data Base API [trending](https://developer.themoviedb.org/reference/trending-movies), [search](https://developer.themoviedb.org/reference/search-movie), [image](https://developer.themoviedb.org/reference/movie-images), [credit](https://developer.themoviedb.org/reference/movie-credits)

### 앱 기능

|온보딩 & 프로필 설정|메인 화면|
|---|---|
|• 초기 프로필 설정<br>• 닉네임 유효성 검사<br>• MBTI 설정<br>• 프로필 이미지 선택<br><br>[이미지 추가 예정]|• 사용자 프로필 표시<br>• 최근 검색어 목록<br>• 트렌딩 영화 목록<br>• 좋아요 개수 표시<br><br>[이미지 추가 예정]|
|**영화 검색**|**영화 상세**|
|• 영화 제목 검색<br>• 검색어 하이라이팅<br>• 무한 스크롤<br>• 장르/개봉일 표시<br><br>[이미지 추가 예정]|• 백드롭 이미지 슬라이더<br>• 시놉시스 확장/축소<br>• 출연진 정보<br>• 포스터 갤러리<br><br>[이미지 추가 예정]|

## 기술적 특징

### 1. 네트워크 계층 구조화

- Router 패턴을 활용한 API 요청 로직 관리
- Alamofire에서 제공하는 `URLRequestConvertible` 프로토콜을 채택한 라우터 정의
- 유연한 타입 제약을 통해 재사용 가능한 네트워크 클라이언트 구현

### 2. 효과적인 영화 저장 로직

- 영화 조회, 삽입, 삭제 어떤 경우에서도 O(1)의 시간복잡도를 가지는 좋아요 목록 관리
- `Set` 자료형을 사용
- UserDefaults를 활용해 로컬 데이터 저장

### 3. 최적화

- `final` 키워드를 통한 Direct Dispatch 최적화
- `private` 접근 제어자를 통한 캡슐화

### 4. 보안

- `xcconfig`를 통한 API 키, endpoint 관리
- Debug/Release 환경 분리

### 5. 이벤트 처리

- Custom Delegate를 통한 명시적인 이벤트 처리
- NotificationCenter를 활용해 재사용 뷰 실시간 UI 업데이트
- Expandable UI
- 최근 검색어 업데이트 UI

### 6. 유지보수성 향상

- Base Class Pattern 활용
- View를 여러개의 ContainerView로 분리해 관리

## 트러블 슈팅
### 레이아웃 대응
- iphone se3 해상도부터 일부 레이아웃이 적용되지 않는 문제 발생

## 라이센스
- TMDB API
