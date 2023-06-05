# social_media

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```shell
flutterfire configure --project=samplecrud-76f99
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
```

and change the android/build.gradle classpath to 'com.google.gms:google-services:4.3.15'

```gradle

dependencies {
    classpath 'com.android.tools.build:gradle:7.3.0'
    // START: FlutterFire Configuration
    classpath 'com.google.gms:google-services:4.3.15'
    // END: FlutterFire Configuration
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
}

```

After creating a new Cloud Firestore database, change the following in the Rules:

```
allow read, write: if true;
```