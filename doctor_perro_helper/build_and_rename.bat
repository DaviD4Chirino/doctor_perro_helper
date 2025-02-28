
set VERSION=0.4.0
:: Build the APK
flutter build apk

rename .\build\app\outputs\flutter-apk\app-release.apk dr-perro-helper-%VERSION%.apk
rename .\build\app\outputs\flutter-apk\app-release.apk.sha1 dr-perro-helper-%VERSION%.apk.sha1