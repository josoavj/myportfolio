import 'package:flutter/material.dart';
import 'package:myportfolio/constants/app_constants.dart';
import 'package:myportfolio/services/cv_download_service.dart';

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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('CV ouvert avec succès'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCVAvailable = CVDownloadService.isCVAvailable(AppConstants.cvUrl);

    if (_isLoading) {
      return ElevatedButton.icon(
        onPressed: null,
        icon: const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
        label: const Text('CV'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBackgroundColor: Colors.blue.shade700,
        ),
      );
    }

    return ElevatedButton.icon(
      onPressed: isCVAvailable ? _downloadCV : null,
      icon: Icon(Icons.download, size: 20),
      label: const Text('CV'),
      style: ElevatedButton.styleFrom(
        backgroundColor: isCVAvailable ? Colors.blue.shade700 : Colors.grey,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        disabledBackgroundColor: Colors.grey,
      ),
    );
  }
}
