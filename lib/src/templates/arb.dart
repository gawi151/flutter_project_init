/// Creates initial .arb file contents for [locale].
String createInitialArb({
  String locale = 'en',
}) {
  return '''
{
  "@@locale": "$locale",
  "appName": "Name of the app"
}
''';
}
