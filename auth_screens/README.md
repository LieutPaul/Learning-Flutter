# sample_crud

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Initializing Firebase

Run the following commands to initialize firebase in the project:

```shell
flutterfire configure --project=samplecrud-76f99
flutter pub add firebase_core
flutter pub add firebase_auth
```

and change the android/build.gradle to

```gradle

dependencies {
    classpath 'com.android.tools.build:gradle:7.3.0'
    // START: FlutterFire Configuration
    classpath 'com.google.gms:google-services:4.3.15'
    // END: FlutterFire Configuration
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
}

```
