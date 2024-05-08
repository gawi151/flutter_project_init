import 'dart:io';

import '../utils.dart';

/// Runs `flutter create` command to create a new Flutter project.
///
/// The [args] is a list of arguments to pass to the `flutter create` command.
void createFlutterProject(List<String> args) {
  _runInShell(
    'flutter',
    ['create', '-e', '--no-pub', ...args],
  );
}

/// Runs `flutter pub get` command in [workingDirectory] path.
void pubGet({String? workingDirectory}) {
  _runInShell(
    'flutter',
    ['pub', 'get'],
    workingDirectory: workingDirectory,
  );
}

/// Runs `flutter pub add` command to add [packages] to the project.
void pubAdd(List<String> packages, {String? sdk, String? workingDirectory}) {
  _runInShell(
    'flutter',
    [
      'pub',
      'add',
      ...packages,
      if (sdk != null) '--sdk=$sdk',
    ],
    workingDirectory: workingDirectory,
  );
}

/// Runs `flutter pub remove` command to remove [packages] from the project.
void pubRemove(List<String> packages, {String? workingDirectory}) {
  _runInShell(
    'flutter',
    ['pub', 'remove', ...packages],
    workingDirectory: workingDirectory,
  );
}

/// Initializes a git repository in the [workingDirectory] path.
void gitInit({String? workingDirectory}) {
  _runInShell(
    'git',
    ['init'],
    workingDirectory: workingDirectory,
  );
}

void _runInShell(
  String executable,
  List<String> args, {
  String? workingDirectory,
  bool runInShell = true,
}) {
  final processResult = Process.runSync(
    executable,
    args,
    runInShell: runInShell,
    workingDirectory: workingDirectory,
  );
  printMessage(processResult.stdout);
  printError(processResult.stderr);
  if (processResult.exitCode != 0) {
    printError('Failed to run $executable');
    exit(processResult.exitCode);
  }
}

/// Runs `dart format` command in [workingDirectory] path.
void dartFormat({String? workingDirectory}) {
  _runInShell(
    'dart',
    ['format', '.'],
    workingDirectory: workingDirectory,
  );
}

/// Runs `dart fix --apply` command in [workingDirectory] path.
void dartFixApply({String? workingDirectory}) {
  _runInShell(
    'dart',
    ['fix', '--apply'],
    workingDirectory: workingDirectory,
  );
}
