import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poloniex_app/views/auth/controller.dart';
import 'package:poloniex_app/views/auth/signup.dart';

class LoginPage extends StatelessWidget {
  final AuthController controller = Get.put(AuthController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  validator: controller.validateField,
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                      labelText: 'Email')),
              const SizedBox(height: 20),
              TextFormField(
                  validator: controller.validatePassword,
                  controller: controller.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                      labelText: 'Password')),
              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.isTrue
                    ? const CircularProgressIndicator()
                    : FilledButton(
                        onPressed: () => controller.signIn(formKey),
                        child: Obx(() => controller.isLoading.isTrue
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Sign in")),
                      ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => SignupPage());
                },
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
