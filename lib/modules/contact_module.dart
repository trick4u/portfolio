import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/contact_controller.dart';

class ContactForm extends StatelessWidget {
  final ContactController _controller = Get.put(ContactController());

  ContactForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 800;

    return Container(
      margin: const EdgeInsets.all(50),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJargonText(context),
                const SizedBox(height: 40),
                _buildForm(context),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _buildJargonText(context),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: _buildForm(context),
                ),
              ],
            ),
    );
  }

  Widget _buildJargonText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Connect!",
          style: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Have a project in mind? Want to collaborate? Or just want to say hi? Feel free to reach out!",
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      labelStyle: GoogleFonts.poppins(
        color: Colors.grey[700],
      ),
      floatingLabelStyle: GoogleFonts.poppins(
        color: Colors.grey[700],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _controller.nameController,
                decoration: inputDecoration.copyWith(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (_) => _controller.update(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controller.emailController,
                decoration: inputDecoration.copyWith(labelText: 'Your Email'),
                onChanged: (_) => _controller.update(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _controller.messageController,
                decoration: inputDecoration.copyWith(labelText: 'Your Message'),
                maxLines: 5,
                onChanged: (_) => _controller.update(),
              ),
              const SizedBox(height: 30),
              Obx(() {
                if (_controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _controller.hasContent.value
                    ? ElevatedButton(
                        onPressed: _controller.sendEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Send Message',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(); // Hide button when no content
              })
            ],
          ),
        ),
      ),
    );
  }
}
