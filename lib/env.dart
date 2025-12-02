class Env {
  static const apiKey = String.fromEnvironment('apiKey');
  static const authDomain = String.fromEnvironment('authDomain');
  static const projectId = String.fromEnvironment('projectId');
  static const storageBucket = String.fromEnvironment('storageBucket');
  static const messagingSenderId =
      String.fromEnvironment('messagingSenderId');
  static const appId = String.fromEnvironment('appId');
  static const measurementId = String.fromEnvironment('measurementId');
  static const prodUrl = String.fromEnvironment('prodUrl');
}
