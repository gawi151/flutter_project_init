import 'package:flutter_project_init/src/templates/analysis_options.dart';
import 'package:test/test.dart';

void main() {
  test('createAnalysisOptions defaults', () {
    const expected = '''
include: package:very_good_analysis/analysis_options.yaml

linter:
  rules:
    always_use_package_imports: false
    avoid_relative_lib_imports: false
    prefer_relative_imports: true
    public_member_api_docs: false
''';

    expect(createAnalysisOptions(), expected);
  });
}
