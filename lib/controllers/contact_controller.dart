import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactController extends GetxController {
  // Form field controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  // Regex for email validation
  final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Observable for loading state
  var isLoading = false.obs;

  // Validate the form
  bool validateForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your name');
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return false;
    }
    if (!_emailRegex.hasMatch(emailController.text)) {
      Get.snackbar('Error', 'Please enter a valid email address');
      return false;
    }
    if (messageController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your message');
      return false;
    }
    return true;
  }

  // Send email using EmailJS
  Future<void> sendEmail() async {
    if (!validateForm()) return;

    isLoading.value = true; // Show loading indicator

    const serviceId = 'service_in9m8sl';
    const templateId = 'template_kckc8ej';
    const userId = 'p_Go_zT5XFzCrvKJU';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'name': nameController.text,
            'email': emailController.text,
            'message': messageController.text,
          },
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Message sent successfully!');
      } else {
        Get.snackbar('Error', 'Failed to send message. Please try again.');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  @override
  void onClose() {
    // Dispose controllers when the controller is closed
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
