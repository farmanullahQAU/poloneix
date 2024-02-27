import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poloniex_app/views/auth/login.dart';
import 'package:poloniex_app/views/home.dart';

import '../../models/user_model.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs; // for loading indicator

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Rxn<User> firebaseUser = Rxn<User>();

  // Sign up
  Future<void> signUp(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      try {
        final UserModel userModel = UserModel(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: userModel.email,
          password: userModel.password,
        );
        User? user = userCredential.user;
        firebaseUser.value = user;
        Get.snackbar('Success', 'User registered successfully');
        isLoading.toggle();
        Get.off(() => LoginPage());
      } catch (e) {
        isLoading.toggle(); //close laoder

        Get.snackbar('Sign Up Failed', e.toString());
      }
    }
  }

  // Sign in
  Future<void> signIn(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        User? user = userCredential.user;
        firebaseUser.value = user;
        isLoading.toggle();

        Get.snackbar('Success', 'User signed in successfully');

        Get.offAll(() => PoloniexApp());
      } catch (e) {
        isLoading.toggle();

        Get.snackbar('Sign In Failed', e.toString());
      }
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      firebaseUser.value = null;
      Get.snackbar('Sign Out Success', 'User signed out successfully');
    } catch (e) {
      Get.snackbar('Sign Out Failed', e.toString());
    }
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter field';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter confirm password';
    }
    if (value.trim() != passwordController.text.trim()) {
      return 'Password does not match';
    }
    return null;
  }
}
