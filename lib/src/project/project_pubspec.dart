import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:yaml_edit/yaml_edit.dart';

import 'project_paths.dart';

String? _pubspecRawContent;

/// Returns the [YamlEditor] for the pubspec.yaml file.
/// 
/// To get the parsed [Pubspec], use [pubspec].
/// 
/// To save the changes, use [savePubspecToFile].
YamlEditor get pubspecEditor {
  if (_pubspecRawContent != null) {
    return YamlEditor(_pubspecRawContent!);
  }
  _pubspecRawContent = pubspecFile.readAsStringSync();
  return YamlEditor(_pubspecRawContent!);
}

/// Saves the [pubspec] editor to the pubspec.yaml file.
///
/// Overwrites the file.
void savePubspecToFile(YamlEditor pubspec) {
  final pubspecContent = pubspec.toString();
  pubspecFile.writeAsStringSync(pubspecContent);
  _pubspecRawContent = pubspecContent;
}

/// Returns the parsed [Pubspec] (read-only) from the pubspec.yaml file.
/// 
/// To modify the pubspec, use [pubspecEditor].
Pubspec get pubspec {
  if (_pubspecRawContent != null) {
    return Pubspec.parse(_pubspecRawContent!);
  }
  final pubspecContent = pubspecFile.readAsStringSync();
  return Pubspec.parse(pubspecContent);
}
