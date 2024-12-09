import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/controllers/AuthController.dart';

class LoginView extends GetView<AuthController> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'POS System Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () => controller.login(
                          usernameController.text,
                          passwordController.text,
                        ),
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
              ),
              SizedBox(height: 16),
              Obx(() => Text(
                    controller.error.value,
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
