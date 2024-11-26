import 'package:aegislabs/common/base_view.dart';
import 'package:aegislabs/pages/routes/pages.dart';
import 'package:aegislabs/pages/ui/Checkout/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends BaseView<CheckoutController> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Cart',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Display the details of the product
                    Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Image.network(ctrl.products.value!.image!,
                            width: 50, height: 50),
                        title: Text(ctrl.products.value!.title!),
                        subtitle: Text('Quantity: 1'),
                        trailing: Text(
                            '\$${(ctrl.products.value!.price! * 1).toStringAsFixed(2)}'),
                      ),
                    ),
                    // Total price section
                  ],
                );
              }),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${(ctrl.products.value!.price! * 1).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ).marginSymmetric(horizontal: 16),
          SafeArea(
            top: false,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Checkout'),
                      content: Text('Thank you for your purchase!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.MAIN);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Proceed to Checkout'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
