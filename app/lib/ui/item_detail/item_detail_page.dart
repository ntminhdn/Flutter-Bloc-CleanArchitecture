import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../app.dart';
import 'bloc/item_detail.dart';

@RoutePage()
class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({
    required this.user,
    super.key,
  });

  final User user;

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
        child: Text(
          widget.user.toString(),
          style: AppTextStyles.s14w400Primary(),
        ),
      ),
    );
  }
}
