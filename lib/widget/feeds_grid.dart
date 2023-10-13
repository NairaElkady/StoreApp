import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import 'feeds_widget.dart';

// ignore: must_be_immutable
class FeedsGridWidget extends StatelessWidget {
  FeedsGridWidget({Key? key, required this.productsList}) : super(key: key);

  List<ProductsModel> productsList = [];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0.0,
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
              value: productsList[index], child: const FeedsWidget());
        });
  }
}
