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
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJargonText(context),
                const SizedBox(height: 40),
                _buildForm(context),
              ],
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Row(
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
              ),
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
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Have a project in mind? Want to collaborate? Or just want to say hi? Feel free to reach out!",
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Obx(
      () {
        if (_controller.isSuccess.value) {
          return _buildSuccessContainer(context);
        } else {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _controller.nameController,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Your Name'),
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
                      decoration:
                          inputDecoration.copyWith(labelText: 'Your Email'),
                      onChanged: (_) => _controller.update(),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _controller.messageController,
                      decoration:
                          inputDecoration.copyWith(labelText: 'Your Message'),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
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
                          : const SizedBox
                              .shrink(); // Hide button when no content
                    })
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSuccessContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline,
                size: 60, color: Colors.green[700]),
            const SizedBox(height: 25),
            Text(
              'Message Sent Successfully!',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Thank you for reaching out!\nWe\'ll respond to your message shortly.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                _controller.isSuccess.value = false;
              },
              child: Text(
                'Send Another Message',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
