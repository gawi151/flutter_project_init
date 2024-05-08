/// Creates contents for l10n.yaml configuration for flutter_localizations
String createL10nYaml({
  String arbDir = 'lib/l10n',
  String templateArbFile = 'app_en.arb',
  String outputLocalizationFile = 'app_localizations.dart',
}) {
  return '''
arb-dir: $arbDir
template-arb-file: $templateArbFile
output-localization-file: $outputLocalizationFile
''';
}
