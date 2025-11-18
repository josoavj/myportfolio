import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/models/experience.dart';

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final int index;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(
        milliseconds: AppConstants.cardAnimationDuration +
            (index * AppConstants.cardAnimationDelay),
      ),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: AppConstants.secondaryDark,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: experience.color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: experience.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    experience.icon,
                    color: experience.color,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experience.role,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.business,
                              size: 16, color: Colors.grey[500]),
                          const SizedBox(width: 5),
                          Text(
                            experience.company,
                            style: TextStyle(
                              fontSize: 16,
                              color: experience.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              experience.period,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Icon(Icons.location_on,
                              size: 14, color: Colors.grey[500]),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              experience.location,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[400],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              experience.description,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[300],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Réalisations clés :',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 10),
            ...experience.achievements.map((achievement) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 18,
                      color: experience.color,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        achievement,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
