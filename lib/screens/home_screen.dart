import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:storeapp/consts/global_colors.dart';
import 'package:storeapp/models/products_model.dart';
import 'package:storeapp/screens/categories_screen.dart';
import 'package:storeapp/screens/feeds_screen.dart';
import 'package:storeapp/screens/user_screen.dart';
import 'package:storeapp/services/api_handler.dart';
import 'package:storeapp/widget/appbar_icons.dart';
import 'package:storeapp/widget/feeds_grid.dart';
import 'package:storeapp/widget/sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  //List<ProductsModel> productsList = [];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // @override
  // void didChangeDependencies() {
  //   getProducts();
  //   super.didChangeDependencies();
  // }

  // Future<void> getProducts() async {
  //   productsList = await APIHendler.getAllProducts();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: lightCardColor,
          title: const Text("Home"),
          leading: AppBarIcons(
            function: () {
              Navigator.push(
                context,
                PageTransition(
                    child: const CategoriesScreen(),
                    type: PageTransitionType.fade),
              );
            },
            icon: IconlyBold.category,
          ),
          actions: [
            AppBarIcons(
                function: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: const UserScreen(),
                          type: PageTransitionType.fade));
                },
                icon: IconlyBold.user3),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Gap(12),
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconsColor,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const SaleWidget();
                          },
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "All Products",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                        child: const FeedScreen(),
                                        type: PageTransitionType.fade,
                                      ));
                                },
                                icon: IconlyBold.arrowRight),
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductsModel>>(
                        future: APIHendler.getAllProducts(limit: '8'),
                        builder: ((context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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

                          return FeedsGridWidget(productsList: snapshot.data!);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// productsList.isEmpty
//                           ? Container()
//                           : FeedsGridWidget(productsList: productsList),