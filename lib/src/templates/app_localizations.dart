import 'package:code_builder/code_builder.dart';

/// Creates app_localizations.dart contents with ready to use extension
/// for the application.
String createAppLocalizations() {
  final dartEmitter = DartEmitter(
    orderDirectives: true,
    useNullSafetySyntax: true,
  );
  final localizationsDart = Library(
    (b) => b.body.addAll([
      Directive.import('package:flutter/widgets.dart'),
      Directive.import(
        'package:flutter_gen/gen_l10n/app_localizations.dart',
      ),
      Directive.export(
        'package:flutter_gen/gen_l10n/app_localizations.dart',
      ),
      Extension(
        (b) => b
          ..name = 'AppLocalizationsX'
          ..on = refer('BuildContext')
          ..methods.add(
            Method(
              (b) => b
                ..name = 'l10n'
                ..type = MethodType.getter
                ..returns = refer('AppLocalizations')
                ..body = refer('AppLocalizations')
                    .property('of')
                    .call([refer('this')])
                    .nullChecked
                    .code,
            ),
          ),
      ),
    ]),
  );
  return '${localizationsDart.accept(dartEmitter)}';
}
