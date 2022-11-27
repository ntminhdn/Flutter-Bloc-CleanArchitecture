import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class ItemDetailBloc extends BaseBloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc(this._fakeLoginUseCase) : super(const ItemDetailState()) {
    on<ItemDetailPageInitiated>(
      _onItemDetailPageInitiated,
      transformer: log(),
    );

    on<ItemDetailPressed>(
      _onItemDetailPressed,
      transformer: log(),
    );
  }

  final FakeLoginUseCase _fakeLoginUseCase;

  FutureOr<void> _onItemDetailPageInitiated(
    ItemDetailPageInitiated event,
    Emitter<ItemDetailState> emit,
  ) {
    // Xin hãy ghi nhớ đặt tên Event theo convention:
    // <Tên Widget><Verb ở dạng Quá khứ>. VD: LoginButtonPressed, EmailTextFieldChanged, HomePageRefreshed
  }

  FutureOr<void> _onItemDetailPressed(ItemDetailPressed event, Emitter<ItemDetailState> emit) {
    return runBlocCatching(
      action: () async {
        final output = await _fakeLoginUseCase.execute(const FakeLoginInput());
        logD(output.status);
      },
    );
  }
}
