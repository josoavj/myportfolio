import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/services/cv_download_service.dart';
import 'package:myportfolio/utils/app_theme.dart';

class CVDownloadButton extends StatefulWidget {
  final bool isSmall;
  final VoidCallback? onError;

  const CVDownloadButton({
    super.key,
    this.isSmall = false,
    this.onError,
  });

  @override
  State<CVDownloadButton> createState() => _CVDownloadButtonState();
}

class _CVDownloadButtonState extends State<CVDownloadButton> {
  bool _isLoading = false;

  Future<void> _downloadCV() async {
    if (!CVDownloadService.isCVAvailable(AppConstants.cvUrl)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CV non disponible pour le moment'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final success = await CVDownloadService.downloadCV(AppConstants.cvUrl);

    if (!mounted) return;

    setState(() => _isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'ouverture du CV'),
          duration: Duration(seconds: 2),
        ),
      );
      widget.onError?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCVAvailable = CVDownloadService.isCVAvailable(AppConstants.cvUrl);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _isLoading ? null : _downloadCV,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isSmall ? 12 : 16,
            vertical: widget.isSmall ? 8 : 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: isCVAvailable ? Colors.blue : Colors.grey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isLoading)
                SizedBox(
                  width: widget.isSmall ? 16 : 20,
                  height: widget.isSmall ? 16 : 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCVAvailable ? Colors.blue : Colors.grey,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.download,
                  color: isCVAvailable ? Colors.blue : Colors.grey,
                  size: widget.isSmall ? 16 : 20,
                ),
              const SizedBox(width: 8),
              Text(
                'CV',
                style: AppTheme.subtitle(
                  color: isCVAvailable ? Colors.blue : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
