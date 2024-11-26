import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/base_view.dart';
import 'package:aegislabs/common/components/widget/VWidget.dart';
import 'package:aegislabs/pages/ui/ProductDetail/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends BaseView<ProductDetailController> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Product Details")),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () {
                    final product = controller.products.value;

                    if (product == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(product.image ?? ""),
                          SizedBox(height: 16),
                          Text(
                            product.title ?? '',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                            style: TextStyle(fontSize: 20, color: Colors.green),
                          ),
                          SizedBox(height: 16),
                          Text(
                            product.description ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          if (product.rating != null)
                            Row(
                              children: [
                                Text("Rating: "),
                                Icon(Icons.star, color: Colors.orange),
                                Text(
                                    "${product.rating?.rate ?? 0.0} (${product.rating?.count ?? 0} reviews)"),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                color: VColor.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Obx(() => SizedBox(
                          width: getWidth(context) / 2.3,
                          child: VTextButton(
                            onPressed: () {
                              ctrl.onTapCheckOut();
                            },
                            text: 'Check Out',
                            disabled: ctrl.token.value.isEmpty,
                            fontSize: 16,
                            bgColor: ctrl.token.value.isEmpty
                                ? VColor.grey700
                                : VColor.accent,
                          ),
                        )),
                    Obx(() => SizedBox(
                          width: getWidth(context) / 2.3,
                          child: VTextButton(
                            onPressed: () {
                              ctrl.onTapInsertCart();
                            },
                            disabled: ctrl.token.value.isEmpty,
                            bgColor: Colors.white,
                            textColor: ctrl.token.value.isEmpty
                                ? VColor.grey700
                                : VColor.accent,
                            fontSize: 16,
                            text: 'Cart',
                          ),
                        )),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
