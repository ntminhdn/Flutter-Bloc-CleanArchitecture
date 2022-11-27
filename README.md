# Flutter Bloc - Clean Architecture

Flutter project using clean architecture and bloc pattern.

![Architecture](images/project_architecture.png?raw=true)

## Features

1. Architecture: Clean Architecture
1. State management: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
1. Navigation: [auto_route](https://pub.dev/packages/auto_route)
1. DI: [get_it](https://pub.dev/packages/get_it), [injectable](https://pub.dev/packages/injectable)
1. REST API: [dio](https://pub.dev/packages/dio)
1. GraphQL: [artemis](https://pub.dev/packages/artemis), [graphql_flutter](https://pub.dev/packages/graphql_flutter)
1. Database: [objectbox](https://pub.dev/packages/objectbox)
1. Shared Preferences: [encrypted_shared_preferences](https://pub.dev/packages/encrypted_shared_preferences)
1. Data class: [freezed](https://pub.dev/packages/freezed)
1. Lint: [dart_code_metrics](https://pub.dev/packages/dart_code_metrics), [flutter_lints](https://pub.dev/packages/flutter_lints)
1. CI/CD: Github Actions, Bitbucket Pipelines
1. Unit Test: [mocktail](https://pub.dev/packages/mocktail), [bloc_test](https://pub.dev/packages/bloc_test)
1. Paging: [infinite_scroll_pagination](https://pub.dev/packages/infinite_scroll_pagination)
1. Utils: [rxdart](https://pub.dev/packages/rxdart), [dartx](https://pub.dev/packages/dartx), [async](https://pub.dev/packages/async)
1. Assets generator: [flutter_gen_runner](https://pub.dev/packages/flutter_gen_runner), [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons), [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)

## Getting Started

### Requirements

- Dart: 2.18.5
- Flutter SDK: 3.3.9
- Melos: 2.8.0
- CocoaPods: 1.11.2

### Install

- WARN: If you already installed `melos` and `lefthook`, you could omit this step.

- Install melos:
    - Run `dart pub global activate melos 2.8.0`

- Install lefthook (optional):
    - Run `gem install lefthook`

- Export paths:
    - Add to `.zshrc` or `.bashrc` file
```    
export PATH="$PATH:<path to flutter>/flutter/bin"
export PATH="$PATH:<path to flutter>/flutter/bin/cache/dart-sdk/bin"
export PATH="$PATH:~/.pub-cache/bin"
export PATH="$PATH:~/.gem/gems/lefthook-0.7.7/bin"
```
    - Save file `.zshrc`
    - Run `source ~/.zshrc`

### Config and run app

- cd to root folder of project
- Run `make gen_env`
- Run `make sync`
- Run `lefthook install` (optional)
- Run & Enjoy!

## Upgrade Flutter
- Update Flutter version in:
    - [README.md](#requirements)
    - [bitbucket-pipelines.yml](bitbucket-pipelines.yml)
    - [ci.yaml](.github/workflows/ci.yaml)
    - [cd_develop.yaml](.github/workflows/cd_develop.yaml)
    - [cd_qa.yaml](.github/workflows/cd_qa.yaml)
    - [cd_staging.yaml](.github/workflows/cd_staging.yaml)
    - [cd_production.yaml](.github/workflows/cd_production.yaml)

## Upgrade Melos
- Update Melos version in:
    - [README.md](#requirements)
    - [Install](#install)
    - [bitbucket-pipelines.yml](bitbucket-pipelines.yml)
    - [ci.yaml](.github/workflows/ci.yaml)
    - [cd_develop.yaml](.github/workflows/cd_develop.yaml)
    - [cd_qa.yaml](.github/workflows/cd_qa.yaml)
    - [cd_staging.yaml](.github/workflows/cd_staging.yaml)
    - [cd_production.yaml](.github/workflows/cd_production.yaml)


