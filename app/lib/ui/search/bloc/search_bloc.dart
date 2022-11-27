import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';

@Injectable()
class SearchBloc extends BaseBloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState()) {
    on<SearchPageInitiated>(
      _onSearchPageInitiated,
      transformer: log(),
    );
  }

  FutureOr<void> _onSearchPageInitiated(SearchPageInitiated event, Emitter<SearchState> emit) {
    // Xin hãy ghi nhớ đặt tên Event theo convention:
    // <Tên Widget><Verb ở dạng Quá khứ>. VD: LoginButtonPressed, EmailTextFieldChanged, HomePageRefreshed
  }
}
