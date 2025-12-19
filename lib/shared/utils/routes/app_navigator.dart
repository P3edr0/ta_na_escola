import '../../../main.dart';

class AppNavigator {
  AppNavigator();

  Future<void> _push(String route, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(route, arguments: args);
  }

  Future<void> _replace(String route, {Object? args}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      route,
      arguments: args,
    );
  }

  Future<void> _clearStack(String route, {Object? args}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route,
      (route) => false,
      arguments: args,
    );
  }

  Future<void> goto(
    String route, {
    bool push = false,
    bool replace = false,
    bool clearStack = false,
  }) async {
    if (clearStack) {
      await _clearStack(route);
      return;
    }
    if (replace) {
      await _replace(route);
      return;
    }
    _push(route);
  }
}
