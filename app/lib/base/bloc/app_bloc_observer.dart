import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver({
    this.logOnChange = LogConfig.logOnBlocChange,
    this.logOnCreate = LogConfig.logOnBlocCreate,
    this.logOnClose = LogConfig.logOnBlocClose,
    this.logOnError = LogConfig.logOnBlocError,
    this.logOnEvent = LogConfig.logOnBlocEvent,
    this.logOnTransition = LogConfig.logOnBlocTransition,
  });

  final bool logOnChange;
  final bool logOnCreate;
  final bool logOnClose;
  final bool logOnError;
  final bool logOnEvent;
  final bool logOnTransition;

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (logOnChange) {
      Log.d('onChange $change', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    if (logOnCreate) {
      Log.d('created', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    if (logOnClose) {
      Log.d('closed', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (logOnError) {
      Log.d('onError $error', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (logOnEvent) {
      Log.d('onEvent $event', name: bloc.runtimeType.toString());
    }
  }

  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    if (logOnTransition) {
      Log.d('onTransition $transition', name: bloc.runtimeType.toString());
    }
  }
}
