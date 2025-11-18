import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/models/education.dart';

class EducationCard extends StatelessWidget {
  final Education education;
  final int index;

  const EducationCard({
    super.key,
    required this.education,
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
          border: Border.all(color: education.color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: education.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                education.icon,
                color: education.color,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          education.degree,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: education.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: education.color,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          education.status,
                          style: TextStyle(
                            fontSize: 12,
                            color: education.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    education.school,
                    style: TextStyle(
                      fontSize: 16,
                      color: education.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 5),
                      Text(
                        education.period,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Icon(Icons.location_on,
                          size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          education.location,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    education.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[300],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
