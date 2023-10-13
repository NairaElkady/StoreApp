import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/consts/global_colors.dart';
import 'package:storeapp/models/categories_model.dart';
import 'package:storeapp/widget/category_widget.dart';
import '../services/api_handler.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightCardColor,
        title: const Text("Categories"),
      ),
      body: FutureBuilder<List<CategoriesModel>>(
        future: APIHendler.getAllCategories(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text("An error occured ${snapshot.error}"),
            );
          } else if (snapshot.data == null) {
            const Center(
              child: Text("No products has been added yet"),
            );
          }

          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 0.0,
                crossAxisCount: 2,
                mainAxisSpacing: 0.0,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: snapshot.data![index],
                    child: const CategoryWidget());
              });
        }),
      ),
    );
  }
}
