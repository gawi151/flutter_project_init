# Flutter project init

CLI tool that generates flutter project boilerplate with initial set of libraries and 
configurations related to libraries that require setup (like l10n or routing).

Plugin setups project with the following libraries: 

- GoRouter [https://pub.dev/packages/go_router] - Routing library
- Flutter Localizations [https://flutter.dev/docs/development/accessibility-and-localization/internationalization] - Internationalization library
- Equatable [https://pub.dev/packages/equatable] - Library for value equality
- Riverpod [https://pub.dev/packages/riverpod] - State management library
- Flutter Hooks [https://pub.dev/packages/flutter_hooks] - Hooks for Flutter (local state management)
- Json Serializable [https://pub.dev/packages/json_serializable] - Library for JSON serialization
- Build Runner [https://pub.dev/packages/build_runner] - Library for code generation
- Very Good Analysis [https://pub.dev/packages/very_good_analysis] - Linter rules
- Mocktail [https://pub.dev/packages/mocktail] - Mocking library

## Usage

activate the package from git repository by running the following command:

// TODO(gawi151): replace <git_repository_url> with the actual git repository url

```shell
dart pub global activate --source git <git_repository_url>
```

and

add the following to your `.bashrc` or `.zshrc` file:

```shell
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

then

run the command:

```shell
flutter_project_init {project_name}
```

or if you don't want to setup PATH run:

```shell
dart pub global run flutter_project_init {project_name}
```

TODO:
- [ ] Add tests
- [ ] Add more libraries
- [ ] Add plugin system for adding custom libraries and configurations
- [ ] Add ability to enable/disable libraries
- [ ] Add ability to override default configurations
