import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:storeapp/consts/global_colors.dart';
import 'package:storeapp/models/products_model.dart';
import 'package:storeapp/services/api_handler.dart';

class ProductDetalis extends StatefulWidget {
  const ProductDetalis({super.key, required this.id});
  final String id;

  @override
  State<ProductDetalis> createState() => _ProductDetalisState();
}

class _ProductDetalisState extends State<ProductDetalis> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  ProductsModel? productsModel;
  Future<void> getProductInfo() async {
    try {
      productsModel = await APIHendler.getAllProductById(id: widget.id);
    } catch (error) {
      log('error $error' as num);
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: productsModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      const BackButton(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              productsModel!.category!.name.toString(),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Text(
                                    productsModel!.title.toString(),
                                    textAlign: TextAlign.start,
                                    style: titleStyle,
                                  ),
                                ),
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                        text: "\$",
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color:
                                              Color.fromRGBO(33, 150, 243, 1),
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                productsModel!.price.toString(),
                                            style: TextStyle(
                                                color: lightTextColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                            const Gap(12),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.4,
                        child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return FancyShimmerImage(
                              width: double.infinity,
                              imageUrl:
                                  productsModel!.images![index].toString(),
                              boxFit: BoxFit.fill,
                            );
                          },
                          autoplay: true,
                          itemCount: 3,
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const Gap(12),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Description', style: titleStyle),
                            const Gap(12),
                            Text(
                              productsModel!.description.toString(),
                              textAlign: TextAlign.start,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}
