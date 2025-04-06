
set VERSION=1.1.0
:: Build the APK

rename .\build\app\outputs\flutter-apk\app-release.apk dr-perro-helper-%VERSION%.apk
rename .\build\app\outputs\flutter-apk\app-release.apk.sha1 dr-perro-helper-%VERSION%.apk.sha1