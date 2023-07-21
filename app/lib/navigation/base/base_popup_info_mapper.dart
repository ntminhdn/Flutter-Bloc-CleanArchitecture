import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

abstract class BasePopupInfoMapper {
  Widget map({
    required AppPopupInfo appPopupInfo,
    required AppNavigator navigator,
  });
}
