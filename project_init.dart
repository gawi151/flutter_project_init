// first ask for the project name
// check if the project name is valid for a dart package
// then create the project folder
// then run `flutter create $project_name`
// then run `flutter pub get`
// then init git
// then add packages with `flutter pub add $package_name`:
// - go_router
// - equatable
// - hooks_riverpod
// - flutter_hooks
// - riverpod_annotation
// - dev:riverpod_generator
// - dev:build_runner
// - dev:custom_lint
// - dev:riverpod_lint
// - dev:very_good_analysis
// - dev:mocktail
// then add the following to the `analysis_options.yaml` file:
// ```
// include: package:very_good_analysis/analysis_options.yaml
// ```
// then add dev packages with `flutter pub add --dev $package_name`:
import 'dart:io';

bool isDebug() {
  var isDebug = false;
  assert(() {
    print('Running in debug mode');
    isDebug = true;
    return true;
  }());
  return isDebug;
}

void debugPrint(String message) {
  if (isDebug()) {
    print(message);
  }
}

void main(List<String> args) {
  final projectName = args[0];
  debugPrint('Project name: $projectName');
  Process.runSync('flutter create', [projectName]);
  Process.runSync('flutter pub get', []);
  Process.runSync('git init', []);
}
