import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'bloc/item_detail.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({
    required this.user,
    required this.userId,
    required this.email,
    super.key,
  });

  final User user;
  final String userId;
  final String email;

  @override
  State<StatefulWidget> createState() {
    return _ItemDetailPageState();
  }
}

class _ItemDetailPageState extends BasePageState<ItemDetailPage, ItemDetailBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.userId,
              style: AppTextStyles.s14w400Primary(),
            ),
            InkWell(
              onTap: () => navigator.push(AppRouteInfo.login(), useRootNavigator: true),
              child: Text(
                widget.email,
                style: AppTextStyles.s14w400Primary(),
              ),
            ),
            InkWell(
              onTap: () => navigator.push(AppRouteInfo.registerAccount()),
              child: Text(
                widget.user.toString(),
                style: AppTextStyles.s14w400Primary(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
