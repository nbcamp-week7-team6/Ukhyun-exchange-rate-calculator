# 📱 Exchange Rate Calculator

실시간 환율 정보를 제공하고 통화 변환을 계산하는 iOS 애플리케이션  
(Swift, UIKit, CoreData, MVVM 패턴 기반)

---

## ✨ 주요 기능
- **실시간 환율 조회** (Open Exchange Rates API 연동)
- **통화 변환 계산기** (금액 입력 → 대상 통화로 즉시 계산)
- **즐겨찾기 관리** (CoreData 기반 지속성 저장)
- **다크 모드 지원** (Asset Catalog로 시스템 색상 자동 대응)
- **검색 기능** (통화 코드/국가명으로 빠른 필터링)
- **환율 변동 추적** (이전 대비 상승🔺/하락🔻 아이콘 표시)

---

## 🛠 기술 스택
- **UIKit**: 100% 코드 베이스 UI 구현
- **CoreData**: 환율 캐싱 & 즐겨찾기 지속성 관리
- **MVVM**: 상태 관리 패턴 적용 (`ViewModelState`/`ViewModelAction`)
- **네트워크**: Alamofire 기반 REST API 통신
- **다크 모드**: 시스템 컬러 + 커스텀 Asset 색상 적용

---

## 📂 프로젝트 구조
```bash
└── exchange-rate-calculator
    ├── exchange-rate-calculator
       ├── Application
       │   ├── AppDelegate.swift
       │   ├── Assets.xcassets
       │   │   ├── AccentColor.colorset
       │   │   ├── AppIcon.appiconset
       │   │   ├── BackgroundColor.colorset
       │   │   ├── ButtonColor.colorset
       │   │   ├── CellBackgroundColor.colorset
       │   │   ├── Contents.json
       │   │   ├── FavoriteColor.colorset
       │   │   ├── SecondaryTextColor.colorset
       │   │   └── TextColor.colorset
       │   ├── Base.lproj
       │   │   └── LaunchScreen.storyboard
       │   ├── Info.plist
       │   └── SceneDelegate.swift
       ├── CachedExchangeRate+CoreDataClass.swift
       ├── CachedExchangeRate+CoreDataProperties.swift
       ├── Domain
       │   └── Model
       │       ├── CurrencyData.swift
       │       └── ExchangeRateData.swift
       ├── FavoriteCurrency+CoreDataClass.swift
       ├── FavoriteCurrency+CoreDataProperties.swift
       ├── Manager
       │   ├── ExchangeRateCacheManager.swift
       │   ├── FavoriteCurrencyManager.swift
       │   └── NetworkManager.swift
       ├── Model.xcdatamodeld
       │   └── Model.xcdatamodel
       │       └── contents
       ├── Presentation
       │   ├── State
       │   │   ├── CalculatorViewModelAction.swift
       │   │   ├── CalculatorViewModelState.swift
       │   │   ├── ViewModelAction.swift
       │   │   └── ViewModelState.swift
       │   ├── ViewControllers
       │   │   ├── CalculatorViewController.swift
       │   │   ├── ExchangeRateTableViewCell.swift
       │   │   └── ViewController.swift
       │   ├── ViewModels
       │   │   ├── CalculatorViewModel.swift
       │   │   └── ViewModel.swift
       │   └── Views
       │       ├── CalculatorView.swift
       │       ├── ExchangeRateCellView.swift
       │       └── MainView.swift
       └── Utily
           ├── Double+Extensions.swift
           └── UIViewController+Extensions.swift
```
