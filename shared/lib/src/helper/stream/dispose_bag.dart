import 'dart:async';

import 'package:flutter/material.dart';

import '../../../shared.dart';

class DisposeBag with LogMixin {
  static const _enableLogging = LogConfig.enableDisposeBagLog;
  final List<Object> _disposable = [];
  void addDisposable(Object disposable) {
    _disposable.add(disposable);
  }

  void dispose() {
    _disposable.forEach((disposable) {
      if (disposable is StreamSubscription) {
        disposable.cancel();
        if (_enableLogging) {
          logD('Canceled $disposable');
        }
      } else if (disposable is StreamController) {
        disposable.close();
        if (_enableLogging) {
          logD('Closed $disposable');
        }
      } else if (disposable is ChangeNotifier) {
        disposable.dispose();
        if (_enableLogging) {
          logD('Disposed $disposable');
        }
      } else if (disposable is Disposable) {
        disposable.dispose();
      }
    });

    _disposable.clear();
  }
}

extension StreamSubscriptionExtensions<T> on StreamSubscription<T> {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension StreamControllerExtensions<T> on StreamController<T> {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension ChangeNotifierExtensions on ChangeNotifier {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}

extension DisposableExtensions on Disposable {
  void disposeBy(DisposeBag disposeBag) {
    disposeBag.addDisposable(this);
  }
}
