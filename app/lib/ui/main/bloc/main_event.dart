import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';

part 'main_event.freezed.dart';

abstract class MainEvent extends BaseBlocEvent {
  const MainEvent();
}

@freezed
class MainPageInitiated extends MainEvent with _$MainPageInitiated {
  const factory MainPageInitiated({
    required int id,
  }) = _MainPageInitiated;
}
