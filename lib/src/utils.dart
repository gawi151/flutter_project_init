import 'dart:io';

/// check if running in debug mode
bool isDebug() {
  var isDebug = false;
  assert(
    () {
      // ignore: avoid_print
      print('Running in debug mode');
      isDebug = true;
      return true;
    }(),
    'setup code for debug mode',
  );
  return isDebug;
}

/// print debug message (only in debug mode)
void debugPrint(String message) {
  if (isDebug()) {
    // ignore: avoid_print
    print(message);
  }
}

/// prints message to standard output
void printMessage(Object? message) {
  stdout.writeln(message);
}

/// prints message to standard error output
void printError(Object? message) {
  stderr.writeln(message);
}
