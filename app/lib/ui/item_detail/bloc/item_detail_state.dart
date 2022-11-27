import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'item_detail_state.freezed.dart';

@freezed
class ItemDetailState extends BaseBlocState with _$ItemDetailState {
  const factory ItemDetailState({
    @Default('') String id,
  }) = _ItemDetailState;
}
