# Travel App — Flutter Lab 3

A multi-screen Travel App UI built with Flutter as part of the Mobile and System Design course (Lab 3). All data is hard-coded in Dart files. No API or database is used — the focus is entirely on UI design, widget composition, and screen navigation.

---

## Screenshots

| Home Screen | Detail Screen | Booking Screen | Confirmation |
|---|---|---|---|
| Dashboard with search, category chips, and destination grid | Full destination info with hero image and Book Now | Trip summary, price breakdown, and confirm button | Booked place view with trip details and total paid |

---

## Features

- **4 Screens**: Home, Detail, Booking, Booking Confirmation
- **Hard-coded data**: 6 destinations, categories, prices, ratings — all in `travel_data.dart`
- **29 Flutter widgets** used across the app (requirement: 18)
- **Custom reusable widgets**: 5 widget classes in `lib/widgets/`
- **Gradient overlays** on destination cards and detail header
- **Box shadows** on cards, bottom bars, and containers
- **Responsive grid**: 2 columns on mobile, 3 on wide web/desktop
- **Favorite toggle** on each destination card
- **Booking confirmation screen** showing the booked destination with full trip details
- Runs on **Android**, **Windows**, and **Web**

---

## Navigation Flow

```
HomeScreen
    │
    │  tap destination card
    ▼
DetailScreen
    │
    │  tap "Book Now"
    ▼
BookingScreen
    │
    │  tap "Confirm Booking"
    ▼
BookingConfirmationScreen
    │
    │  tap "Back to Home"
    ▼
HomeScreen  ◄─────────────────── (popUntil first route)
```

---

## Project Structure

```
travel_app/
├── assets/
│   └── images/
│       ├── paris.jpg
│       ├── bali.jpg
│       ├── maldives.jpg
│       ├── tokyo.jpg
│       ├── santorini.jpg
│       ├── new_york.jpg
│       └── placeholder.jpg
├── lib/
│   ├── main.dart                              # App entry point, MaterialApp
│   ├── theme/
│   │   └── app_theme.dart                     # AppColors, AppTextStyles, ThemeData
│   ├── models/
│   │   └── destination.dart                   # Destination data class
│   ├── data/
│   │   └── travel_data.dart                   # Hard-coded destinations & categories
│   ├── screens/
│   │   ├── home_screen.dart                   # Dashboard screen
│   │   ├── detail_screen.dart                 # Destination detail screen
│   │   ├── booking_screen.dart                # Booking summary screen
│   │   └── booking_confirmation_screen.dart   # Confirmation + booked place view
│   └── widgets/
│       ├── destination_card.dart              # Card with image, gradient, favorite
│       ├── category_chip.dart                 # Animated category selector chip
│       ├── rating_bar.dart                    # Star rating display
│       ├── info_row.dart                      # Icon + label row
│       └── section_header.dart               # Section title with optional action
├── pubspec.yaml
└── README.md
```

---

## Screens

### 1. Home Screen
- `AppBar` with menu icon, subtitle, notification icon, and `CircleAvatar`
- `TextField` search bar (UI only) with filter icon
- Horizontal `ListView.builder` of `CategoryChip` widgets (All, Beach, City, Mountain, Cultural, Adventure)
- `GridView.builder` of `DestinationCard` widgets (2–3 columns depending on screen width)
- Tapping a card navigates to the Detail Screen

### 2. Detail Screen
- Full-width hero image with `LinearGradient` overlay
- Back button and favorite toggle overlaid on the image using `Stack` + `Positioned`
- Destination name, country, and rating
- `InfoRow` widgets for Duration, Weather, and Category
- Scrollable description via `SingleChildScrollView`
- Fixed bottom bar with price and **Book Now** `ElevatedButton`

### 3. Booking Screen
- Destination thumbnail (`ClipRRect`) and summary card
- Trip details panel: check-in, check-out, guests, room type (hard-coded)
- Price breakdown: base price × nights, taxes (12%), and total
- **Confirm Booking** button navigates to the Confirmation Screen
- Free cancellation note

### 4. Booking Confirmation Screen
- Large destination image header with overlay
- **"Booking Confirmed!"** green badge overlapping the image
- Booking reference number (`#TRV-2025-4891`)
- Star rating of the booked destination
- Complete trip summary (dates, duration, guests, room, weather)
- Total paid displayed in a teal gradient banner
- **Back to Home** and **Explore More** buttons

---

## Widgets Used (29 total)

| # | Widget | Location |
|---|---|---|
| 1 | `MaterialApp` | `main.dart` |
| 2 | `Scaffold` | All screens |
| 3 | `AppBar` | Home, Booking screens |
| 4 | `GridView.builder` | Home Screen |
| 5 | `ListView.builder` | Home Screen (horizontal categories) |
| 6 | `Card` | DestinationCard, Booking Screen |
| 7 | `Stack` | DetailScreen header, DestinationCard |
| 8 | `Positioned` | DetailScreen, DestinationCard |
| 9 | `Container` | Everywhere — BoxDecoration, gradients |
| 10 | `Row` | Everywhere |
| 11 | `Column` | Everywhere |
| 12 | `Text` | Everywhere |
| 13 | `Icon` | AppBar, InfoRow, RatingBar |
| 14 | `IconButton` | AppBar, DestinationCard favorite |
| 15 | `ElevatedButton` | Detail, Booking, Confirmation screens |
| 16 | `OutlinedButton` | Confirmation Screen |
| 17 | `TextField` | Home Screen search bar |
| 18 | `SingleChildScrollView` | Detail, Booking, Confirmation screens |
| 19 | `ClipRRect` | DestinationCard, Booking Screen |
| 20 | `Image.asset` | All screens |
| 21 | `CircleAvatar` | Home Screen AppBar |
| 22 | `Divider` | Detail, Booking, Confirmation screens |
| 23 | `GestureDetector` | DestinationCard, SectionHeader |
| 24 | `Padding` | Everywhere |
| 25 | `SizedBox` | Everywhere |
| 26 | `Expanded` / `Flexible` | Row/Column children |
| 27 | `AnimatedContainer` | CategoryChip |
| 28 | `Transform.translate` | Confirmation Screen badge overlap |
| 29 | `Center` | Multiple screens |

---

## Hard-Coded Data

All data lives in `lib/data/travel_data.dart`:

```dart
const List<String> travelCategories = [
  'All', 'Beach', 'City', 'Mountain', 'Cultural', 'Adventure',
];

const List<Destination> destinations = [
  // Paris, Bali, Maldives, Tokyo, Santorini, New York
];
```

Each `Destination` object contains:

| Field | Type | Description |
|---|---|---|
| `id` | `String` | Unique identifier |
| `name` | `String` | Destination name |
| `country` | `String` | Country name |
| `imageAsset` | `String` | Path to local asset image |
| `description` | `String` | Multi-paragraph description |
| `rating` | `double` | Star rating (e.g. 4.8) |
| `reviewCount` | `int` | Number of reviews |
| `pricePerNight` | `double` | Price in USD |
| `duration` | `String` | e.g. "7 Days / 6 Nights" |
| `weather` | `String` | e.g. "Sunny, 30°C" |
| `category` | `String` | e.g. "Beach", "City" |
| `isFeatured` | `bool` | Featured flag |

---

## Color Theme

| Role | Color | Hex |
|---|---|---|
| Primary | Deep Teal | `#006D77` |
| Primary Dark | Dark Teal | `#004D56` |
| Accent / CTA | Coral Orange | `#FF6B6B` |
| Background | Off-White | `#F8F9FA` |
| Surface | White | `#FFFFFF` |
| Text Primary | Dark Charcoal | `#1A1A2E` |
| Text Secondary | Cool Grey | `#6C757D` |
| Star / Rating | Amber Gold | `#FFC107` |
| Divider | Light Grey | `#E9ECEF` |

---

## How to Run

### Prerequisites
- Flutter SDK installed — run `flutter --version` to verify
- Android Studio with an emulator, **or** a physical Android device, **or** Chrome browser

### Steps

```bash
# 1. Navigate to the project folder
cd travel_app

# 2. Install dependencies
flutter pub get

# 3. Check for connected devices / emulators
flutter devices

# 4. Run on Android emulator (Android Studio)
flutter run -d <emulator_id>

# 5. Run on Windows desktop
flutter run -d windows

# 6. Run on Web (Chrome)
flutter run -d chrome
```

### Verify code quality
```bash
flutter analyze
# Expected output: No issues found!
```

---

## Requirements Checklist

| Requirement | Status |
|---|---|
| All data hard-coded in Dart files | ✅ `travel_data.dart` |
| Home Screen: AppBar, search bar, categories, grid | ✅ |
| Destination cards: image, text overlay, favorite icon | ✅ |
| Detail Screen: hero image, description, rating, price, Book Now | ✅ |
| Booking Screen: summary, form layout, confirmation | ✅ |
| Navigation: Home → Detail → Booking → Back | ✅ |
| At least 18 different Flutter widgets | ✅ 29 widgets |
| Custom reusable widget classes | ✅ 5 classes |
| Gradients | ✅ Cards, detail header, confirmation banner |
| Shadows | ✅ Cards, bottom bars, containers |
| Images from assets folder | ✅ `assets/images/` |
| Consistent color theme | ✅ `app_theme.dart` |
| `Navigator.push` / `Navigator.pop` | ✅ |
| Hard-coded data passed between screens | ✅ `Destination` object |
| Runs on Android, Windows, Web | ✅ |

---

## Author

**Course**: Mobile and System Design
**Lab**: Lab 3 — Multi-Screen Travel App UI
**Platform**: Flutter 3.x (Dart)

# Travel_app
This is a travel app
