// include: package:very_good_analysis/analysis_options.yaml
// ```
// then add dev packages with `flutter pub add --dev $package_name`:

import 'package:flutter_project_init/src/commands/commands.dart' as cmd;
import 'package:flutter_project_init/src/packages/packages.dart';
import 'package:flutter_project_init/src/project/project.dart';

void main(List<String> args) {
  cmd.createFlutterProject(args);
  initProjectTemplate(args);
  setupPackages(projectDirectoryPath);
  setupProjectStructure(workingDirectory: projectDirectoryPath);
  cmd.dartFixApply(workingDirectory: projectDirectoryPath);
  cmd.dartFormat(workingDirectory: projectDirectoryPath);
}
