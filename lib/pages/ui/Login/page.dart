import 'package:aegislabs/common/base_view.dart';
import 'package:aegislabs/pages/ui/Login/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends BaseView<LoginController> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Username'),
              controller: ctrl.username,
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
              controller: ctrl.password,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: controller.login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
