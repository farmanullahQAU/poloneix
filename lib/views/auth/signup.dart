import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poloniex_app/views/auth/controller.dart';

class SignupPage extends StatelessWidget {
  final AuthController controller = Get.find();

  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          children: [
            TextFormField(
                validator: controller.validateField,
                controller: controller.firstNameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'First name')),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
                validator: controller.validateField,
                controller: controller.lastNameController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Last name')),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
                validator: controller.validateField,
                controller: controller.emailController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Email')),
            const SizedBox(
              height: 12,
            ),
            TextFormField(
                validator: controller.validatePassword,
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Password')),
            const SizedBox(height: 20),
            TextFormField(
                validator: controller.validateConfirmPassword,
                controller: controller.confirmPasswordController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Confirm ')),
            const SizedBox(
              height: 12,
            ),
            FilledButton(
              onPressed: () => controller.signUp(formKey),
              child: Obx(() => controller.isLoading.isTrue
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text('Sign Up')),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Already have an account'),
            ),
          ],
        ),
      ),
    );
  }
}
