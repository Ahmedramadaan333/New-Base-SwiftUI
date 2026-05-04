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

**Pattern:** MVVM + Coordinator

Every feature screen is organized as:
```
App/<FeatureName>/
  Model/       # Data models (Codable)
  View/        # SwiftUI views
  ViewModel/   # Business logic, inherits BaseViewModel
```

See `App/ExampleFeature/` for a minimal working template of this pattern.

**Coordinator Pattern** (`Coordinator/`): All navigation is handled by coordinators that inherit from `BaseCoordinator<Route>`. Key methods: `push()`, `pop()`, `popToRoot()`, `present()`, `dismiss()`, `reset()`. The app root (`RootCoordinatorView`) switches between `.splash`, `.auth`, and `.mainTabs` states.

**BaseViewModel** (`Networking/BaseViewModel.swift`): All view models inherit this. It provides Combine subjects: `isLoadingSubject`, `errorSubject`, `successSubject`, `warningSubject`. Always use `weak self` in closures.

**Networking** (`Networking/`): Generic `Endpoint<T: Decodable>` defines API calls. `DefaultNetworkExecuter` (Alamofire-based) executes requests. `BaseResponse<T>` is the standard server response wrapper with a `key` field (success/fail/unauthenticated) and `data: T?`.

**Config** (`Networking/AppConfig.swift`): Reads `API_BASE_URL`, `API_KEY`, `GOOGLE_MAPS_KEY` from `Info.plist`. Never hardcode secrets in source files.

**Persistence** (`Shared/Foundation/UserDefaults.swift`): Two custom property wrappers — `@ValueDefault<Value>` for primitives and `@ModelsDefault<Model: Codable>` for JSON-encoded objects. Key stored values: `accessToken`, `user`, `isLogin`, `pushNotificationToken`.

## Key Files

| File | Purpose |
|------|---------|
| `Core/NewSwiftUIBaseApp.swift` | App entry: keyboard manager, Google Maps init, localization setup |
| `Core/AppDelegate.swift` | Firebase init, FCM push notification handling |
| `Coordinator/BaseCoordinator/RootCoordinatorView.swift` | Root scene; handles push notification routing, global modals |
| `Networking/BaseViewModel.swift` | Base class for all ViewModels |
| `Networking/AppConfig.swift` | Centralized config read from Info.plist |
| `Networking/HandleResponse/` | Network response pipeline |
| `Shared/Foundation/UserDefaults.swift` | All UserDefaults keys and property wrappers |
| `App/ExampleFeature/` | Template for adding a new feature screen |

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

1. Copy `App/ExampleFeature/` and rename to your feature name
2. Define your model in `Model/`
3. Add your endpoint in `Networking/Endpoints/` following the `AuthEndPoint.swift` pattern
4. Implement your ViewModel logic
5. Build your View using existing custom components from `Shared/CustomComponents/`
6. Add a route case to the relevant coordinator (e.g., `MoreCoordinatorRoute`)
7. Add the destination in the coordinator's `destination(for:)` method
