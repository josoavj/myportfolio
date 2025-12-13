import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/utils/app_theme.dart';
import 'package:myportfolio/utils/animation_utils.dart';
import 'package:myportfolio/widgets/social_button.dart';
import 'package:myportfolio/widgets/cv_download_button.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 600;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppConstants.primaryDark,
            const Color(0xFF161B22),
            Colors.blue.shade900.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(isSmall ? 15.0 : 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: isSmall ? 120 : 150,
                height: isSmall ? 120 : 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: AppConstants.secondaryDark,
                  backgroundImage: NetworkImage(
                    'https://media.licdn.com/dms/image/v2/D4D35AQGEQi8W_whRJQ/profile-framedphoto-shrink_200_200/profile-framedphoto-shrink_200_200/0/1700827537879?e=1764262800&v=beta&t=xjdRdpj1LoC0p3tTJItdB6oVUrCeWzJrOJFdB1dyYi0',
                  ),
                ).withScaleIn(),
              ),
              const SizedBox(height: 30),
              Text(
                AppConstants.heroName,
                style: isSmall
                    ? AppTheme.titleLargeMobile()
                    : AppTheme.titleLarge(),
                textAlign: TextAlign.center,
              ).withFadeIn(delay: const Duration(milliseconds: 200)),
              const SizedBox(height: 10),
              Text(
                AppConstants.heroTitle,
                style:
                    isSmall ? AppTheme.subtitleMobile() : AppTheme.subtitle(),
                textAlign: TextAlign.center,
              ).withSlideUp(
                  distance: 20.0, delay: const Duration(milliseconds: 300)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on,
                      color: Colors.grey[400], size: isSmall ? 16 : 20),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      AppConstants.location,
                      style: isSmall
                          ? AppTheme.subtitleSmallMobile()
                          : AppTheme.subtitleSmall(),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ).withFadeIn(delay: const Duration(milliseconds: 400)),
              const SizedBox(height: 40),
              AnimationUtils.staggeredFadeSlide(
                children: [
                  const CVDownloadButton(),
                  SocialButton(
                    icon: Icons.code,
                    label: 'GitHub',
                    url: AppConstants.githubUrl,
                  ),
                  SocialButton(
                    icon: Icons.work,
                    label: 'LinkedIn',
                    url: AppConstants.linkedinUrl,
                  ),
                  SocialButton(
                    icon: Icons.facebook,
                    label: 'Facebook',
                    url: AppConstants.facebookUrl,
                  ),
                  SocialButton(
                    icon: Icons.alternate_email,
                    label: 'Twitter',
                    url: AppConstants.twitterUrl,
                  ),
                ],
                baseDelay: const Duration(milliseconds: 500),
                staggerDelay: const Duration(milliseconds: 100),
                builder: (child, animation) => child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
