import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/services/url_launcher_service.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void _sendEmail() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        messageController.text.isEmpty) {
      debugPrint('Tous les champs sont requis');
      return;
    }

    final String subject = 'Contact Portfolio - ${nameController.text}';
    final String body =
        'Nom: ${nameController.text}\nEmail: ${emailController.text}\n\nMessage:\n${messageController.text}';

    UrlLauncherService.launchEmail(
      email: 'josoavonjiniaina13@gmail.com',
      subject: subject,
      body: body,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
      color: AppConstants.secondaryDark,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionTitle(title: 'Contactez-moi'),
              const SizedBox(height: 40),
              Text(
                'Je suis ouvert aux collaborations et discussions!',
                style: AppTheme.bodyLarge(),
                textAlign: TextAlign.center,
              ).withFadeIn(delay: const Duration(milliseconds: 200)),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 900;

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: _buildContactForm(),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 2,
                          child: _buildContactInfo(),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        _buildContactForm(),
                        const SizedBox(height: 30),
                        _buildContactInfo(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.12),
            Colors.blue.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Envoyez-moi un message',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lexend',
            ),
          ).withFadeIn(delay: const Duration(milliseconds: 300)),
          const SizedBox(height: 25),
          _buildTextField(
            controller: nameController,
            label: 'Nom',
            icon: Icons.person,
            delay: 350,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
            delay: 400,
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: messageController,
            label: 'Message',
            icon: Icons.message,
            maxLines: 5,
            delay: 450,
          ),
          const SizedBox(height: 25),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.withValues(alpha: 0.15),
                  Colors.blue.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue.withValues(alpha: 0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _sendEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send),
                  const SizedBox(width: 10),
                  Text(
                    'Envoyer le message',
                    style: AppTheme.lexendRegular(
                      16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ).withSlideUp(
            delay: const Duration(milliseconds: 500),
            distance: 10.0,
          ),
        ],
      ),
    ).withSlideUp(
      delay: const Duration(milliseconds: 250),
      distance: 20.0,
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    int delay = 0,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTheme.lexendRegular(16, color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.lexendRegular(14, color: Colors.grey[400]),
        prefixIcon: Icon(icon, color: Colors.blue),
        filled: true,
        fillColor: AppConstants.secondaryDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey[700]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    ).withFadeIn(delay: Duration(milliseconds: delay));
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.withValues(alpha: 0.12),
                Colors.blue.withValues(alpha: 0.06),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: 0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Autres informations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Lexend',
                ),
              ).withFadeIn(delay: const Duration(milliseconds: 300)),
              const SizedBox(height: 25),
              _buildContactInfoItem(
                icon: Icons.location_on,
                title: 'Localisation',
                subtitle: AppConstants.location,
                delay: 350,
              ),
              const SizedBox(height: 20),
              _buildContactInfoItem(
                icon: Icons.work_outline,
                title: 'Organisation',
                subtitle: 'APEXNova Labs',
                delay: 400,
              ),
            ],
          ),
        ).withSlideUp(
          delay: const Duration(milliseconds: 250),
          distance: 20.0,
        ),
        const SizedBox(height: 20),
        _buildSocialContactButton(
          icon: Icons.phone,
          label: 'WhatsApp',
          url: AppConstants.whatsappUrl,
          color: const Color(0xFF25D366),
          delay: 500,
        ),
        const SizedBox(height: 15),
        _buildSocialContactButton(
          icon: Icons.code,
          label: 'GitHub',
          url: AppConstants.githubUrl,
          color: Colors.blue,
          delay: 550,
        ),
        const SizedBox(height: 15),
        _buildSocialContactButton(
          icon: Icons.work,
          label: 'LinkedIn',
          url: AppConstants.linkedinUrl,
          color: Colors.blue,
          delay: 600,
        ),
      ],
    );
  }

  Widget _buildSocialContactButton({
    required IconData icon,
    required String label,
    required String url,
    required Color color,
    required int delay,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60, // Hauteur standardisée
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withValues(alpha: 0.15),
              color.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () => UrlLauncherService.launchURL(url),
          icon: Icon(icon, size: 22),
          label: Text(
            label,
            style: AppTheme.lexendRegular(
              16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: color,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    ).withScaleIn(delay: Duration(milliseconds: delay));
  }

  Widget _buildContactInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
    int delay = 0,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.labelSmall(),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTheme.subtitle(),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (onTap != null)
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 16,
            ),
        ],
      ),
    ).withFadeIn(delay: Duration(milliseconds: delay));
  }
}
