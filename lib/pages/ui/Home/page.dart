import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/components/widget/VImageNetwork.dart';
import 'package:aegislabs/common/utils/Constant.dart';
import 'package:aegislabs/core/models/products/products_model.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:aegislabs/common/base_view.dart';
import 'package:aegislabs/pages/ui/Home/controller.dart';

class HomePage extends BaseView<HomeController> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          Obx(
            () => ctrl.token.value.isEmpty
                ? InkWell(
                    onTap: () {
                      ctrl.goToLogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      margin: const EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: VColor.blue,
                      ),
                      child: Text(
                        'Login',
                        style: textTheme.bodyMedium?.copyWith(
                          color: VColor.mainWhite,
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 16),
                    width: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.CART);
                          },
                          child: Icon(
                            Icons.shopping_bag,
                            color: VColor.blue,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            ctrl.onTaplogout();
                          },
                          child: Icon(
                            Icons.logout,
                            color: VColor.red,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Discover your unique Look',
                  style: textTheme.displayLarge,
                ).marginOnly(
                  left: 16,
                  right: 16,
                  top: 20,
                  bottom: 40,
                ),
                Obx(
                  () => SizedBox(
                    height: 30,
                    width: getWidth(context),
                    child: ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      itemCount: ctrl.categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ctrl.onTapCategories(ctrl.categories[index]!);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: ctrl.selectedCategories.value ==
                                        ctrl.categories[index]!
                                    ? VColor.blue
                                    : Colors.transparent,
                                border: Border.all(
                                  width: 1,
                                  color: VColor.blue,
                                ),
                              ),
                              child: Text(
                                ctrl.categories[index]!,
                                style: textTheme.labelSmall?.copyWith(
                                  color: ctrl.selectedCategories.value ==
                                          ctrl.categories[index]!
                                      ? VColor.mainWhite
                                      : VColor.blue,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: 5),
                    ),
                  ),
                ).marginSymmetric(horizontal: 16, vertical: 16),
                Obx(
                  () => MasonryGridView.builder(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                    ),
                    itemCount: ctrl.products.length,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    itemBuilder: (context, index) {
                      final product = ctrl.products[index]!;
                      return InkWell(
                        onTap: () {
                          ctrl.onTapProduct(product);
                        },
                        child: ProductCard(product: product),
                      );
                    },
                  ),
                ).marginSymmetric(horizontal: 16, vertical: 16),
              ],
            ),
          )),
    );
  }
}

class ProductCard extends StatelessWidget with Constant {
  final Products product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: VColor.pureWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Ensures height is dynamic
        children: [
          VImageNetwork(
            uri: product.image,
            height: getWidth(context) / 2,
            width: getWidth(context) / 2,
            boxFit: BoxFit.fitWidth,
          ),
          Text(
            product.title!,
            style: Theme.of(Get.context!)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 14),
          ),
          Text(
            '${product.rating?.count} Sold',
            style: Theme.of(Get.context!).textTheme.bodyMedium,
            softWrap: true,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${product.price!.toStringAsFixed(2)}',
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  Text('${product.rating!.rate}')
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
