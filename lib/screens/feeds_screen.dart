import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/consts/global_colors.dart';

import '../models/products_model.dart';
import '../services/api_handler.dart';
import '../widget/feeds_widget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> productsList = [];

  int limit = 10;
  bool _isloading = false;
  //bool _isLimit = false;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  Future<void> getProducts() async {
    productsList = await APIHendler.getAllProducts(limit: limit.toString());
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isloading = true;
        limit += 10;
        print("limit $limit");
        await getProducts();
        _isloading = true;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightScaffoldColor,
        title: const Text("Al l Products"),
        //elevation: 0,
      ),
      body: productsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0.0,
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.0,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productsList[index],
                            child: const FeedsWidget());
                      }),
                  if (_isloading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
    );
  }
}
