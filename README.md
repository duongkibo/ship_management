# ship_management

### Flutter version: 3.7.5

## Run app

```sh
flutter run --flavor dev -t lib/main.dart
```

## Build android app

```sh
flutter build apk --flavor dev -t lib/main.dart

flutter build appbundle --flavor prd -t lib/main_prd.dart
```

## Build iOS app

Use Xcode

##### Use fvm

Replace flutter command-line `flutter` by `fvm flutter`.

```sh
fvm flutter build apk --flavor dev -t lib/main.dart

fvm flutter build apk --flavor prd -t lib/main_prd.dart

...
```
