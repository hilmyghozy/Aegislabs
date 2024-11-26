# Aegislabs GetX

Aegislabs

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Running the app
  ```bash
  $ git clone https://github.com/hilmyghozy/Aegislabs
  $ dart pub global activate derry
  $ dart pub global activate fvm
  $ fvm install 3.24.1
  $ fvm use 3.24.1

  #to get all dependencies
  $ derry get 
  
  #to run development apk
  $ derry run_dev 
  
  #to build production apk
  $ derry build_apk_prod 
  ```
	
## Flavors & Environment 
Generated using [flutter_flavorizr](https://pub.dev/packages/flutter_flavorizr) in the file **`flavorizr.yaml`**.

Environment files you can find at **`assets/flavors/`**, after you set the env file you must run the build_runner with ***`derry build_once`*** or ***`derry watch`*** 

For VS Code just run this configurations for each platform & environment
- Android-PROD
- Android-DEV
- iPhone-PROD
- iPhone-DEV
