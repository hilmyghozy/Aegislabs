import 'package:loggy/loggy.dart';

mixin ModelLogger implements LoggyType {
  @override
  Loggy<ModelLogger> get loggy => Loggy<ModelLogger>('MODEL: $runtimeType');
}

mixin UiLogger implements LoggyType {
  @override
  Loggy<UiLogger> get loggy => Loggy<UiLogger>('UI: $runtimeType');
}

mixin ControllerLogger implements LoggyType {
  @override
  Loggy<ControllerLogger> get loggy =>
      Loggy<ControllerLogger>('CONTROLLER: $runtimeType');
}

mixin RepositoryLogger implements LoggyType {
  @override
  Loggy<RepositoryLogger> get loggy =>
      Loggy<RepositoryLogger>('REPOSITORY: $runtimeType');
}

mixin ProviderLogger implements LoggyType {
  @override
  Loggy<ProviderLogger> get loggy =>
      Loggy<ProviderLogger>('PROVIDER: $runtimeType');
}

class SysLogger implements LoggyType {
  @override
  Loggy<SysLogger> get loggy => Loggy<SysLogger>('APP: $runtimeType');

  void sys(String text, {bool isError = false}) {
    if (!isError) {
      Future.microtask(() => loggy.debug(text));
    } else {
      Future.microtask(() => loggy.error(text));
    }
  }

  void write(
      {required String? runtimeType,
      required String? method,
      required String? message}) {
    loggy.debug("[$runtimeType $method] => $message");
  }
}
