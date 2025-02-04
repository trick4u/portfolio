import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ContactController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final isLoading = false.obs;
  final hasContent = false.obs;

  DateTime? _lastMessageTime;
  static const int _cooldownMinutes = 2;

  final _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(updateContentStatus);
    emailController.addListener(updateContentStatus);
    messageController.addListener(updateContentStatus);
  }

  void updateContentStatus() {
    hasContent.value = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        messageController.text.isNotEmpty;
  }

  void _showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  bool _checkRateLimit() {
    if (_lastMessageTime != null) {
      final timeSinceLastMessage = DateTime.now().difference(_lastMessageTime!);
      if (timeSinceLastMessage.inMinutes < _cooldownMinutes) {
        final remainingTime = _cooldownMinutes - timeSinceLastMessage.inMinutes;
        _showErrorDialog(
            'Please wait $remainingTime minute${remainingTime > 1 ? 's' : ''} before sending another message.');
        return false;
      }
    }
    return true;
  }

  bool validateForm() {
    if (nameController.text.isEmpty) {
      _showErrorDialog('Please enter your name');
      return false;
    }
    if (emailController.text.isEmpty) {
      _showErrorDialog('Please enter your email');
      return false;
    }
    if (!_emailRegex.hasMatch(emailController.text)) {
      _showErrorDialog('Please enter a valid email address');
      return false;
    }
    if (messageController.text.isEmpty) {
      _showErrorDialog('Please enter your message');
      return false;
    }
    return true;
  }

  void _clearForm() {
    nameController.clear();
    emailController.clear();
    messageController.clear();
    hasContent.value = false;
  }

  Future<void> sendEmail() async {
    if (!validateForm() || !_checkRateLimit()) return;

    isLoading.value = true;

    const serviceId = 'service_in9m8sl';
    const templateId = 'template_kckc8ej';
    const userId = 'p_Go_zT5XFzCrvKJU';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
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
        _lastMessageTime = DateTime.now();
        _showSuccessDialog('Message sent successfully!');
        _clearForm();
      } else {
        _showErrorDialog('Failed to send message. Please try again later.');
      }
    } catch (e) {
      _showErrorDialog(
          'Network error. Please check your connection and try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void _showSuccessDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
