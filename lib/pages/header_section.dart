import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/widgets/social_button.dart';
import 'package:myportfolio/widgets/cv_download_button.dart';
import 'package:myportfolio/widgets/responsive_layout.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = ResponsiveLayout.isMobile(context);

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryDark,
            const Color(0xFF161B22),
            Colors.blue.shade900.withValues(alpha: 0.2),
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
            child: ResponsiveLayout(
              mobile: _buildMobileLayout(context),
              desktop: _buildDesktopLayout(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAvatar(isMobile: true),
        const SizedBox(height: 30),
        _buildHeaderText(isMobile: true),
        const SizedBox(height: 40),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(isMobile: false),
              const SizedBox(height: 40),
              _buildActionButtons(),
            ],
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: Center(child: _buildAvatar(isMobile: false)),
        ),
      ],
    );
  }

  Widget _buildAvatar({required bool isMobile}) {
    final avatarSize = isMobile ? 180.0 : 350.0;
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        final glowSize = 10.0 + (_glowAnimation.value * 15.0);
        final opacity = 0.2 + (_glowAnimation.value * 0.2);

        return Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue.withValues(alpha: 0.5), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withValues(alpha: opacity),
                blurRadius: glowSize * 2,
                spreadRadius: glowSize,
              ),
            ],
          ),
          child: const CircleAvatar(
            backgroundColor: AppConstants.secondaryDark,
            backgroundImage: AssetImage('assets/mypfp.jpg'),
          ).withScaleIn(),
        );
      },
    );
  }

  Widget _buildHeaderText({required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, je suis',
          style: TextStyle(
            color: Colors.blue.shade300,
            fontSize: isMobile ? 18 : 24,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ).withFadeIn(delay: const Duration(milliseconds: 100)),
        const SizedBox(height: 10),
        Text(
          AppConstants.heroName,
          style: isMobile ? AppTheme.titleLargeMobile() : AppTheme.titleLarge(size: 60),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).withFadeIn(delay: const Duration(milliseconds: 200)),
        const SizedBox(height: 15),
        Text(
          AppConstants.heroTitle,
          style: isMobile
              ? AppTheme.subtitleMobile()
              : AppTheme.subtitle(color: Colors.grey.shade300).copyWith(fontSize: 22),
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
        ).withSlideUp(distance: 20.0, delay: const Duration(milliseconds: 300)),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Icon(Icons.location_on, color: Colors.blue.shade300, size: isMobile ? 18 : 22),
            const SizedBox(width: 8),
            Text(
              AppConstants.location,
              style: isMobile
                  ? AppTheme.subtitleSmallMobile()
                  : AppTheme.subtitleSmall().copyWith(fontSize: 16),
            ),
          ],
        ).withFadeIn(delay: const Duration(milliseconds: 400)),
      ],
    );
  }

  Widget _buildActionButtons() {
    return AnimationUtils.staggeredFadeSlide(
      children: [
        const CVDownloadButton(),
        const SocialButton(icon: Icons.code, label: 'GitHub', url: AppConstants.githubUrl),
        const SocialButton(icon: Icons.work, label: 'LinkedIn', url: AppConstants.linkedinUrl),
        const SocialButton(icon: Icons.facebook, label: 'Facebook', url: AppConstants.facebookUrl),
        const SocialButton(icon: Icons.alternate_email, label: 'Twitter', url: AppConstants.twitterUrl),
      ],
      baseDelay: const Duration(milliseconds: 500),
      staggerDelay: const Duration(milliseconds: 100),
      builder: (child, animation) => child,
    );
  }
}
