// TODO(gawi151): extend the builder to support more properties of analysis_options.yaml
// TODO(gawi151): consider using some type safety here (define object for rules)

/// Creates a analysis_options.yaml content based on params.
String createAnalysisOptions({
  String? includeValue = 'package:very_good_analysis/analysis_options.yaml',
  Map<String, bool> rules = const {
    'always_use_package_imports': false,
    'avoid_relative_lib_imports': false,
    'prefer_relative_imports': true,
    'public_member_api_docs': false,
  },
}) {
  final fileContent = '''
${includeValue != null ? 'include: $includeValue' : ''}

linter:
  rules:
${_rulesToString(rules)}
''';
  return '${fileContent.trim()}\n';
}

String _rulesToString(Map<String, bool> rules) {
  final rulesBuffer = StringBuffer();
  const indentation = '    ';
  const separator = ': ';
  for (final entry in rules.entries) {
    rulesBuffer
      ..write(indentation)
      ..write(entry.key)
      ..write(separator)
      ..writeln(entry.value);
  }
  return rulesBuffer.toString();
}
