import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../i18n/l10n.dart';

class OpenLocalhostButton extends StatelessWidget {
  const OpenLocalhostButton({
    super.key,
    required this.isExtended,
  });

  final bool isExtended;

  Future<void> openLocalhost() async {
    final url = Uri.parse('http://localhost:1313');
    if (await canLaunchUrl(url) || Platform.isLinux) {
      await launchUrl(url);
    }
  }

  Widget openLocalhostButton() {
    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          child: Padding(
            padding: isExtended
                ? const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0)
                : const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: isExtended
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.open_in_new,
                  size: 32.0,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                if (isExtended)
                  Row(
                    children: [
                      const SizedBox(width: 16.0),
                      SizedBox(
                        width: constraints.maxWidth - 80,
                        child: Text(
                          Localization.appLocalizations().openHugoServer,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          onTap: () async => await openLocalhost(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => openLocalhostButton();
}
