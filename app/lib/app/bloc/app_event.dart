import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'app_event.freezed.dart';

abstract class AppEvent extends BaseBlocEvent {
  const AppEvent();
}

@freezed
class IsLoggedInStatusChanged extends AppEvent with _$IsLoggedInStatusChanged {
  const factory IsLoggedInStatusChanged({
    required bool isLoggedIn,
  }) = _IsLoggedInStatusChanged;
}

@freezed
class AppThemeChanged extends AppEvent with _$AppThemeChanged {
  const factory AppThemeChanged({
    required bool isDarkTheme,
  }) = _AppThemeChanged;
}

@freezed
class AppLanguageChanged extends AppEvent with _$AppLanguageChanged {
  const factory AppLanguageChanged({
    required LanguageCode languageCode,
  }) = _AppLanguageChanged;
}

@freezed
class AppInitiated extends AppEvent with _$AppInitiated {
  const factory AppInitiated() = _AppInitiated;
}
