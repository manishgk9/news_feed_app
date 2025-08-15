# News Feed App

A modern Flutter news feed application with bookmarking, offline support, and rich UI features.

---

## ✨ Features

- 📰 **Latest News:** Fetch trending news from various sources.
- 📑 **Bookmarks:** Save articles to read later with offline access.
- 🔍 **Search:** Search for news articles by keyword.
- 📡 **Offline Handling:** Detect network connectivity using `connectivity_plus`.
- 📤 **Sharing:** Share news articles using `share_plus`.
- 🎨 **Professional UI:** Smooth animations, shimmer loading, and modern design.
- 🖋️ **Custom Fonts:** Integrated Google Fonts for a polished look.
- 🌙 **Dark & Light Mode:** Adaptive themes for user comfort.

---

## 📸 Screenshots & Demo

> ⚠️ _Screenshots and video demo will be added soon._

<!-- Placeholder for screenshots -->

```
[ Add screenshots here ]
```

<!-- Placeholder for demo video -->

```
[ Add video demo link here ]
```

---

## 🧭 App Screens / Pages

- `HomePage` – Displays the list of news articles.
- `SearchPage` – Search and display results.
- `BookmarkPage` – View bookmarked articles.
- `ArticleDetailPage` – Detailed view of a single article.
- `OnboardingScreen` – Initial walkthrough for new users.
- `SplashScreen` – Splash screen before app launch.

---

## 🔧 State Management

- **GetX** for reactive state management and navigation.

### 📂 Controllers

- `NewsController` – Handles news fetching and search logic.
- `BookmarksController` – Manages bookmarks and persistence.
- `ThemeController` – Toggles dark/light mode and stores preferences.

---

## 📁 Folder Structure

```
lib/
├── additional_screens/
│   ├── onboarding.dart
│   └── splash.dart
├── bindings/
│   └── app_bindings.dart
├── controllers/
│   ├── bookmarks_controller.dart
│   ├── news_controller.dart
│   └── theme_controller.dart
├── models/
│   ├── article.dart
│   └── news_response.dart
├── pages/
│   ├── article_detail_page.dart
│   ├── bookmark_page.dart
│   ├── home_page.dart
│   └── search_page.dart
├── utils/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── on_boarded.dart
│   │   └── storage_keys.dart
│   ├── services/
│   │   ├── cache_service.dart
│   │   ├── dio_client.dart
│   │   └── news_api.dart
│   ├── theme/
│   │   ├── date_utils.dart
│   │   └── theme.dart
│   └── widgets/
│       ├── article_tile.dart
│       ├── modern_appbar.dart
│       ├── modern_search_bar.dart
│       ├── news_list_shimmer.dart
│       ├── offline_banner.dart
│       └── ...
└── main.dart
```

---

## 📦 Packages Used

| Package                | Description                |
| ---------------------- | -------------------------- |
| `get`                  | State management & routing |
| `dio`                  | HTTP client                |
| `get_storage`          | Local storage              |
| `connectivity_plus`    | Network status detection   |
| `intl`                 | Date formatting            |
| `cached_network_image` | Efficient image caching    |
| `shimmer`              | Loading animations         |
| `share_plus`           | Article sharing            |
| `url_launcher`         | Open URLs in browser       |
| `google_fonts`         | Custom fonts integration   |
| `cupertino_icons`      | iOS-style icons            |

---

## 🚀 Getting Started

1. **Clone the repository**

```bash
git clone <repo_url>
cd news_feed_app
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

4. **Assets Setup**

Ensure images like `onboard_1.jpg`, `onboard_2.jpg`, `onboard_3.jpg` are placed inside the `assets/` folder and referenced in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/onboard_1.jpg
    - assets/onboard_2.jpg
    - assets/onboard_3.jpg
```

---

## 👤 About the Developer

Developed with ❤️ by **Manish Yadav**

- **GitHub:** [manishgk9](https://github.com/manishgk9)
- **X (Twitter):** [@manishgk9](https://x.com/manishgk9)
- **X (Linkedin):** [@manishgk9](https://linkedin.com/in/manishgk9)

---

## 📄 License

This project is licensed under the **MIT License**.
See the [LICENSE](LICENSE) file for more information.

---
