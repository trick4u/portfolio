import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/contact_controller.dart';
// Import the controller

class ContactForm extends StatelessWidget {
  final ContactController _controller = Get.put(ContactController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Container(
            child: Column(
              children: [
                // Name Field
                TextFormField(
                  controller: _controller.nameController,
                  decoration: const InputDecoration(labelText: 'Your Name'),
                ),
                // Email Field
                TextFormField(
                  controller: _controller.emailController,
                  decoration: const InputDecoration(labelText: 'Your Email'),
                ),
                // Message Field
                TextFormField(
                  controller: _controller.messageController,
                  decoration: const InputDecoration(labelText: 'Your Message'),
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                // Send Button
                Obx(() {
                  return _controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _controller.sendEmail,
                          child: const Text('Send Message'),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
