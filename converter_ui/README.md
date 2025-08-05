# 🚀 Converter UI

A Flutter mini-app for currency conversion, built for a coding interview assignment.

---

## ✨ Features

- **Splash Screen**: Custom animated splash screen on startup.
- **Dark Mode**: Toggle between light and dark themes.
- Currency conversion between FIAT and CRYPTO.
- Responsive UI and clean code structure.

---

## 📌 API Behavior Note

While integrating the currency recommendation endpoint, I found that **requests below a certain amount (in COP) return no data**.

For instance:

- This request returns an empty result:
  ```
  amount=1000.0
  https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations?type=1&cryptoCurrencyId=TATUM-TRON-USDT&fiatCurrencyId=COP&amount=1000.0&amountCurrencyId=COP
  → {"data": {}}
  ```

- But this one returns a valid response:
  ```
  amount=20000.0
  https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage/orderbook/public/recommendations?type=1&cryptoCurrencyId=TATUM-TRON-USDT&fiatCurrencyId=COP&amount=20000.0&amountCurrencyId=COP
  → {"data": { byPrice: {...}, ... }}
  ```

From the successful response, it’s clear that the `limits.fiat.minLimit` is **18938.2**, meaning the API only returns conversion data when the requested amount meets or exceeds this minimum.

Consider this behaviour to exchange small quantities of a currency. 

---

## 🛠️ Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart](https://dart.dev/get-dart)
- (Optional) [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)

### Installation

```bash
git clone https://github.com/your-username/converter_ui.git
cd converter_ui
flutter pub get
```

---

## ▶️ Running the App

### On Android/iOS

```bash
flutter run
```

### On Web

```bash
flutter run -d chrome
```

### On Desktop (Windows, macOS, Linux)

```bash
flutter run -d windows   # or macos, linux
```

---

## 📁 Project Structure

```
lib/
  core/
    theme/         # Theme and color definitions
    app_routes.dart
  presentation/
    components/    # UI components (calculator, background, etc.)
    screens/       # App screens (splash, main)
  data/
    providers/     # State management providers
```

---

## 💬 Contact

For questions, reach out via [LinkedIn](https://www.linkedin.com/in/monica-sofia-restrepo-leon/).
