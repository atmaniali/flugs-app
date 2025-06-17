# Flugs App

A Flutter application for exploring countries by region, viewing country details, and displaying locations on a map.

## Features

- Browse countries by region (Africa, Asia, Europe, Oceania, Americas)
- View detailed information for each country:
  - Name, capital, region, subregion, population, currency, and flag
  - Bordering countries with names and flags
  - Location displayed on an interactive map (OpenStreetMap)
- Search for countries by name or abbreviation (API-based)
- Responsive UI using [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)
- Uses [flutter_map](https://pub.dev/packages/flutter_map) for map display

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Internet connection (for API and map tiles)

### Installation

1. **Clone the repository:**
   ```sh
   git clone <your-repo-url>
   cd flugs_app
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/screens/home.dart` — Home screen with region selection and country list
- `lib/screens/country.dart` — Country details screen with map and border info
- `lib/utils/api_service.dart` — API service for fetching country data
- `pubspec.yaml` — Project dependencies

## Dependencies

- [http](https://pub.dev/packages/http) — For REST API requests
- [flutter_map](https://pub.dev/packages/flutter_map) — Map widget
- [latlong2](https://pub.dev/packages/latlong2) — LatLng support for maps
- [chip_list](https://pub.dev/packages/chip_list) — Region selection chips
- [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) — Responsive sizing

## API

- Uses [REST Countries API v3.1](https://restcountries.com/) for country data

## Notes

- Make sure you have internet permission enabled for Android (`android/app/src/main/AndroidManifest.xml`):
  ```xml
  <uses-permission android:name="android.permission.INTERNET"/>
  ```
- The app is designed for educational/demo purposes and may require further enhancements for production use.

## License

This project is licensed under the MIT License.

## Importsnt Limk 

[Flags API](https://restcountries.com/)

[Super hero API links](https://superheroapi.com/)
