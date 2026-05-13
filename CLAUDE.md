# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run

This is a native iOS app using Xcode. There is no `Package.swift` — dependencies are managed via Swift Package Manager embedded in Xcode.

```bash
# Open in Xcode
open BaseSwiftUI.xcodeproj

# Build from command line (replace simulator ID as needed)
xcodebuild -project BaseSwiftUI.xcodeproj -scheme BaseSwiftUI -destination 'platform=iOS Simulator,name=iPhone 15' build

# Run tests
xcodebuild -project BaseSwiftUI.xcodeproj -scheme BaseSwiftUI -destination 'platform=iOS Simulator,name=iPhone 15' test
```

## Getting Started (New Project Checklist)

1. **Bundle ID** — Change in Xcode target settings
2. **App Name** — Update `Shared/Localization/Strings/en.lproj/InfoPlist.strings` and `ar.lproj/InfoPlist.strings`
3. **API config** — Set `API_BASE_URL`, `API_KEY`, and `GOOGLE_MAPS_KEY` in `Core/Info.plist`
4. **Firebase** — Replace `GoogleService-Info.plist` with your project's file
5. **Colors** — Update `Core/Assets.xcassets/Colors/` (PrimaryMain, SecondaryMain, etc.)
6. **Font** — Replace `SomarRounded` font files in `Shared/Resourses/FontFamily/` and update `AppFont.swift` family name
7. **App Icon** — Replace in `Core/Assets.xcassets/AppIcon.appiconset/`
8. **Google Maps** — If not needed, remove `GMSServices.provideAPIKey(...)` from `NewSwiftUIBaseApp.swift` and remove GoogleMaps from Package Dependencies
9. **Push notification types** — Add your app's types to `FCM/PushNotificationType.swift`

## Architecture

**Pattern:** Clean Architecture (Domain / Data / Presentation) + MVVM + Coordinator + DIContainer

Each feature cycle is organized as:
```
App/<FeatureName>Cycle/
  DIContainer/         # Factory: wires Repository → UseCases → ViewModels
  Domain/
    Entity/            # Pure data models (Codable)
    Interfaces/        # Repository protocol (abstract contract)
    UseCases/          # Business logic — one class per operation
  Data/
    Repository/        # Implements the protocol, calls Endpoints via BaseRepository
    Network/
      EndPoints/       # Endpoint<T> definitions for this cycle
      DataMapping/     # DTOs / response wrappers (if needed)
  Presentation/
    ViewModel/         # Inherits BaseViewModel; calls use cases only
    View/              # SwiftUI views; accept ViewModel via init(_:)
  <Feature>Coordinator/  # Coordinator holds DIContainer; builds VMs in destination(for:)
```

See `App/ExampleFeature/` for a complete working template of this pattern.

---

### Layer responsibilities

| Layer | Role |
|-------|------|
| **Entity** | Plain Swift structs/enums (Codable). No business logic. |
| **RepositoryProtocol** | Swift protocol defining what data the domain needs. |
| **UseCase** | Single-responsibility class. Calls one or more repository methods. |
| **Repository** | Extends `BaseRepository`. Implements the protocol using `Endpoint<T>`. |
| **EndPoints** | Static factories returning `Endpoint<BaseResponse<T>>`. |
| **ViewModel** | Inherits `BaseViewModel`. Holds use cases, publishes state, no raw endpoints. |
| **View** | Receives ViewModel via `init`; uses `@StateObject`. |
| **DIContainer** | Creates instances in the right order: Repository → UseCases → ViewModel. |
| **Coordinator** | Holds `let container = XxxDIContainer()`. Calls `container.makeXxxViewModel()` in `destination(for:)` and RootView. |

---

### DIContainer → SwiftUI wiring pattern

```swift
// Coordinator holds the container
final class HomeCoordinator: BaseCoordinator<HomeRoute> {
    let container = HomeDIContainer()

    func destination(for route: HomeRoute) -> some View {
        switch route {
        case .createOrder:
            CreateOrderView(viewModel: container.makeCreateOrderViewModel())
        }
    }
}

// RootView creates the initial ViewModel from the container
struct HomeRootView: View {
    @EnvironmentObject var homeCoordinator: HomeCoordinator
    var body: some View {
        NavigationStack(path: $homeCoordinator.path) {
            HomeView(viewModel: homeCoordinator.container.makeHomeViewModel())
        }
    }
}

// Views accept ViewModel via init
struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
}
```

---

**Coordinator Pattern** (`Coordinator/`): All navigation is handled by coordinators that inherit from `BaseCoordinator<Route>`. Key methods: `push()`, `pop()`, `popToRoot()`, `present()`, `dismiss()`, `reset()`. The app root (`RootCoordinatorView`) switches between `.splash`, `.auth`, and `.mainTabs` states.

**BaseViewModel** (`Networking/BaseViewModel.swift`): All ViewModels inherit this. Provides Combine subjects: `isLoadingSubject`, `errorSubject`, `successSubject`, `warningSubject`. Always use `weak self` in closures.

**BaseRepository** (`Networking/BaseRepository.swift`): All repositories extend this. Mirrors BaseViewModel's `request()` / `getFullResponse()` logic so repositories don't duplicate network-response handling.

**Networking** (`Networking/`): Generic `Endpoint<T: Decodable>` defines API calls. `DefaultNetworkExecuter` (Alamofire-based) executes requests. `BaseResponse<T>` is the standard server response wrapper with a `key` field (success/fail/unauthenticated) and `data: T?`. Endpoint files live inside each cycle under `Data/Network/EndPoints/`.

**Config** (`Networking/AppConfig.swift`): Reads `API_BASE_URL`, `API_KEY`, `GOOGLE_MAPS_KEY` from `Info.plist`. Never hardcode secrets in source files.

**Persistence** (`Shared/Foundation/UserDefaults.swift`): Two custom property wrappers — `@ValueDefault<Value>` for primitives and `@ModelsDefault<Model: Codable>` for JSON-encoded objects. Key stored values: `accessToken`, `user`, `isLogin`, `pushNotificationToken`.

## Key Files

| File | Purpose |
|------|---------|
| `Core/NewSwiftUIBaseApp.swift` | App entry: keyboard manager, Google Maps init, localization setup |
| `Core/AppDelegate.swift` | Firebase init, FCM push notification handling |
| `Coordinator/BaseCoordinator/RootCoordinatorView.swift` | Root scene; handles push notification routing, global modals |
| `Networking/BaseViewModel.swift` | Base class for all ViewModels |
| `Networking/BaseRepository.swift` | Base class for all Repositories |
| `Networking/AppConfig.swift` | Centralized config read from Info.plist |
| `Networking/HandleResponse/` | Network response pipeline |
| `Shared/Foundation/UserDefaults.swift` | All UserDefaults keys and property wrappers |
| `App/ExampleFeature/` | Full clean architecture template for adding a new feature |

## Dependencies (SPM)

- **Alamofire** — HTTP networking
- **Firebase** (Core, Messaging, Analytics, AppCheck, AI, InAppMessaging)
- **GoogleMaps** — Maps and location tracking (optional — remove if not needed)
- **Kingfisher** — Remote image loading/caching
- **Lottie** — JSON-based animations
- **IQKeyboardManagerSwift** — Keyboard management

## Localization & Layout

Multi-language (Arabic RTL supported). Language managed via `AppLanguageManager` in `Shared/Localization/`. The app forces light color scheme. String resources live in `Shared/Localization/Strings/`.

## Push Notification Routing

Push notification types are defined in `FCM/PushNotificationType.swift`. Add your app's types there. `RootCoordinatorView` handles tap routing — new notification types require updates in `handlePushTap(_:)` and `AppDelegate`.

## Adding a New Feature

1. Copy `App/ExampleFeature/` and rename everything from "Example" to your feature name
2. Define your entity model in `Domain/Entity/`
3. Add your endpoint methods in `Data/Network/EndPoints/YourEndPoint.swift`
4. Implement `YourRepository` in `Data/Repository/` extending `BaseRepository`
5. Declare the protocol in `Domain/Interfaces/YourRepositoryProtocol.swift`
6. Write use cases in `Domain/UseCases/` — one class per operation
7. Wire everything in `DIContainer/YourDIContainer.swift`
8. Implement your ViewModel in `Presentation/ViewModel/` — inject use cases via `init`
9. Build your View in `Presentation/View/` — accept ViewModel via `init(viewModel:)`
10. Add a route case to the relevant coordinator and call `container.makeYourViewModel()` in `destination(for:)`
