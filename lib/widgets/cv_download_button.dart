import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/services/cv_download_service.dart';
import 'package:myportfolio/utils/app_theme.dart';

class CVDownloadButton extends StatefulWidget {
  final VoidCallback? onError;

  const CVDownloadButton({
    super.key,
    this.onError,
  });

  @override
  State<CVDownloadButton> createState() => _CVDownloadButtonState();
}

class _CVDownloadButtonState extends State<CVDownloadButton> {
  bool _isLoading = false;
  bool _isHovered = false;

  Future<void> _downloadCV() async {
    if (!CVDownloadService.isCVAvailable(AppConstants.cvUrl)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CV non disponible pour le moment'),
          backgroundColor: Colors.orange,
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
          backgroundColor: Colors.red,
        ),
      );
      widget.onError?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCVAvailable = CVDownloadService.isCVAvailable(AppConstants.cvUrl);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: AppTheme.glassDecoration(
          color: _isHovered ? Colors.blue : Colors.blueGrey,
          opacity: _isHovered ? 0.2 : 0.1,
          borderRadius: 30,
        ),
        child: ElevatedButton.icon(
          onPressed: isCVAvailable && !_isLoading ? _downloadCV : null,
          icon: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(
                  Icons.download_rounded,
                  size: 20,
                  color: _isHovered ? Colors.blue.shade300 : Colors.white,
                ),
          label: Text(
            'Mon CV',
            style: AppTheme.labelSmall(
              color: _isHovered ? Colors.blue.shade300 : Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
