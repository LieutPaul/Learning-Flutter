# Learning-Flutter
Sample Flutter Apps to learn the Framework.

# Initializing Firebase

Run the following commands to initialize firebase in the project:

```shell
flutterfire configure --project=samplecrud-76f99
flutter pub add firebase_core
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
