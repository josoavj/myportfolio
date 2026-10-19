import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/services/url_launcher_service.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/widgets/section_title.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  static const String _email = 'josoavonjiniaina13@gmail.com';
  static const Color _accent = Colors.blue;
  static const Color _accentAlt = Colors.cyan;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final subject = 'Contact Portfolio - ${_nameController.text.trim()}';
    final body = 'Nom: ${_nameController.text.trim()}\n'
        'Email: ${_emailController.text.trim()}\n\n'
        'Message:\n${_messageController.text.trim()}';

    UrlLauncherService.launchEmail(email: _email, subject: subject, body: body);
    _showMessage('Ouverture de votre application de messagerie…');
  }

  Future<void> _copyEmail() async {
    await Clipboard.setData(const ClipboardData(text: _email));
    if (!mounted) return;
    _showMessage('Adresse email copiée');
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text, style: AppTheme.lexendRegular(14, color: Colors.white)),
          backgroundColor: const Color(0xFF1C2230),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
          // Lueurs d'ambiance : dégradés radiaux statiques (aucun flou coûteux).
          const Positioned(top: -140, right: -120, child: _Glow(color: _accent, size: 460)),
          const Positioned(bottom: -160, left: -140, child: _Glow(color: _accentAlt, size: 420)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 60 : 90,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  children: [
                    const SectionTitle(title: 'Contactez-moi'),
                    SizedBox(height: isMobile ? 32 : 56),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final wide = constraints.maxWidth >= 900;
                        if (wide) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 5, child: _buildIntro(isMobile: false)),
                              const SizedBox(width: 64),
                              Expanded(flex: 6, child: _buildFormCard(isMobile: false)),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            _buildIntro(isMobile: isMobile),
                            SizedBox(height: isMobile ? 32 : 40),
                            _buildFormCard(isMobile: isMobile),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }

  Widget _buildIntro({required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Je suis ouvert aux collaborations et discussions !',
          style: AppTheme.lexendRegular(
            isMobile ? 20 : 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            height: 1.25,
          ),
        ).withFadeIn(delay: const Duration(milliseconds: 150)),
        const SizedBox(height: 14),
        Container(
          width: 56,
          height: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [_accent, _accentAlt]),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: isMobile ? 28 : 36),
        _ChannelTile(
          icon: const Icon(Icons.mail_outline_rounded),
          title: 'Email',
          subtitle: _email,
          color: _accent,
          onTap: () => UrlLauncherService.launchURL(AppConstants.emailUrl),
          trailing: _CopyButton(onPressed: _copyEmail),
        ).withSlideUp(delay: const Duration(milliseconds: 250), distance: 14),
        const SizedBox(height: 12),
        _ChannelTile(
          icon: const FaIcon(FontAwesomeIcons.whatsapp),
          title: 'WhatsApp',
          subtitle: 'Message direct',
          color: const Color(0xFF25D366),
          onTap: () => UrlLauncherService.launchURL(AppConstants.whatsappUrl),
        ).withSlideUp(delay: const Duration(milliseconds: 320), distance: 14),
        const SizedBox(height: 12),
        _ChannelTile(
          icon: const FaIcon(FontAwesomeIcons.github),
          title: 'GitHub',
          subtitle: 'github.com/josoavj',
          color: Colors.white,
          onTap: () => UrlLauncherService.launchURL(AppConstants.githubUrl),
        ).withSlideUp(delay: const Duration(milliseconds: 390), distance: 14),
        const SizedBox(height: 12),
        _ChannelTile(
          icon: const FaIcon(FontAwesomeIcons.linkedin),
          title: 'LinkedIn',
          subtitle: 'Réseau professionnel',
          color: const Color(0xFF0A8AD6),
          onTap: () => UrlLauncherService.launchURL(AppConstants.linkedinUrl),
        ).withSlideUp(delay: const Duration(milliseconds: 460), distance: 14),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _InfoPill(icon: Icons.location_on_outlined, label: AppConstants.location),
            _InfoPill(icon: Icons.rocket_launch_outlined, label: 'Side project · APEXNova Labs'),
          ],
        ).withFadeIn(delay: const Duration(milliseconds: 550)),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Colonne droite : formulaire
  // ---------------------------------------------------------------------------

  Widget _buildFormCard({required bool isMobile}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Envoyez-moi un message',
                style: AppTheme.lexendRegular(
                  isMobile ? 20 : 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildField(
                controller: _nameController,
                label: 'Nom',
                icon: Icons.person_outline_rounded,
                autofillHints: const [AutofillHints.name],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.trim().length < 2) {
                    return 'Indiquez votre nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.alternate_email_rounded,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                textInputAction: TextInputAction.next,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
                    return 'Indiquez une adresse email valide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildField(
                controller: _messageController,
                label: 'Message',
                icon: Icons.chat_bubble_outline_rounded,
                minLines: 5,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value == null || value.trim().length < 10) {
                    return 'Votre message est un peu court (10 caractères minimum)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _buildSubmitButton(),
              const SizedBox(height: 14),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(Icons.info_outline, size: 14, color: Colors.grey.shade500),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Votre application de messagerie s\'ouvrira avec le message prêt à envoyer.',
                      style: AppTheme.lexendRegular(12, color: Colors.grey.shade500, height: 1.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).withSlideUp(delay: const Duration(milliseconds: 250), distance: 20);
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    Iterable<String>? autofillHints,
    int minLines = 1,
    int maxLines = 1,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: color, width: width),
      );
    }

    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      minLines: minLines,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: _accent,
      style: AppTheme.lexendRegular(15, color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTheme.lexendRegular(14, color: Colors.grey.shade400),
        floatingLabelStyle: AppTheme.lexendRegular(14, color: Colors.blue.shade300),
        errorStyle: AppTheme.lexendRegular(12, color: Colors.redAccent.shade100),
        // Champ multiligne : pas d'icône (elle serait centrée verticalement).
        prefixIcon: minLines > 1
            ? null
            : Icon(icon, color: Colors.blue.shade300, size: 20),
        alignLabelWithHint: minLines > 1,
        filled: true,
        fillColor: AppConstants.primaryDark.withValues(alpha: 0.6),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: border(Colors.white.withValues(alpha: 0.12)),
        enabledBorder: border(Colors.white.withValues(alpha: 0.12)),
        focusedBorder: border(_accent, 1.6),
        errorBorder: border(Colors.redAccent.shade100.withValues(alpha: 0.7)),
        focusedErrorBorder: border(Colors.redAccent.shade100, 1.6),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Semantics(
      button: true,
      label: 'Envoyer le message',
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [_accent, _accentAlt],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: _submit,
            child: SizedBox(
              height: 56,
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    const SizedBox(width: 10),
                    Text(
                      'Envoyer le message',
                      style: AppTheme.lexendRegular(
                        16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Lueur d'ambiance : disque à dégradé radial, sans flou.
class _Glow extends StatelessWidget {
  final Color color;
  final double size;

  const _Glow({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color.withValues(alpha: 0.16), color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

/// Ligne de contact : pastille d'icône, titre, sous-titre et flèche.
class _ChannelTile extends StatefulWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final Widget? trailing;

  const _ChannelTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.trailing,
  });

  @override
  State<_ChannelTile> createState() => _ChannelTileState();
}

class _ChannelTileState extends State<_ChannelTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.color;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Semantics(
        button: true,
        label: '${widget.title} : ${widget.subtitle}',
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: _hovered ? 0.07 : 0.04),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? color.withValues(alpha: 0.55)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(18),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconTheme(
                        data: IconThemeData(color: color, size: 22),
                        child: Center(child: widget.icon),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: AppTheme.lexendRegular(
                              15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.lexendRegular(12, color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ),
                    if (widget.trailing != null) widget.trailing!,
                    AnimatedSlide(
                      duration: const Duration(milliseconds: 200),
                      offset: _hovered ? const Offset(0.15, -0.15) : Offset.zero,
                      child: Icon(
                        Icons.arrow_outward_rounded,
                        size: 18,
                        color: color.withValues(alpha: _hovered ? 0.9 : 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CopyButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Copier l\'adresse email',
      onPressed: onPressed,
      icon: Icon(Icons.copy_rounded, size: 18, color: Colors.grey.shade400),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue.shade300),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: AppTheme.lexendRegular(12, color: Colors.grey.shade300, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}