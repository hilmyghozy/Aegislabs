import 'package:aegislabs/common/app/VColor.dart';
import 'package:aegislabs/common/base_view.dart';
import 'package:aegislabs/pages/ui/Cart/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends BaseView<CartController> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carts')),
      body: Obx(() {
        // If carts are empty or loading, show a loading indicator
        if (controller.carts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: ctrl.carts.length,
          itemBuilder: (context, index) {
            final cart = controller.carts[index]!;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  ListTile(
                    title: Text('Cart ID: ${cart.id}'),
                    subtitle: Text('Date: ${cart.date}'),
                    trailing: InkWell(
                      onTap: () {
                        ctrl.removeCart(cart.id!);
                      },
                      child: Text(
                        'Remove',
                        style: textTheme.bodySmall?.copyWith(color: VColor.red),
                      ),
                    ),
                  ),
                  Divider(),
                  ...cart.products!.map((cartItem) {
                    return ListTile(
                      title: Text(cartItem.products?.title ?? "loading..."),
                      subtitle: Text(
                          'Quantity: ${cartItem.quantity}\nPrice: \$${cartItem.products?.price ?? 0}'),
                      trailing: IconButton(
                        icon: Icon(Icons.shopping_cart_checkout),
                        onPressed: () {
                          // Handle removing item from cart
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
