import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../i18n/l10n.dart';
import '../../../pages/editing_page.dart';
import '../../../utils/preferences.dart';
import '../../../utils/unsaved_check.dart';
import '../../snackbar.dart';

class ParentFolderButton extends StatelessWidget {
  const ParentFolderButton({
    super.key,
    required this.setStateCallback,
    required this.editingPageKey,
    required this.isExtended,
  });

  final Function setStateCallback;
  final GlobalKey<EditingPageState> editingPageKey;
  final bool isExtended;

  Widget _parentFolderButton() {
    var savePath = Preferences.getCurrentPath();
    if (savePath.endsWith(Platform.pathSeparator)) {
      savePath = savePath.substring(0, savePath.length - 1);
    }
    var savePathSplit = savePath.split(Platform.pathSeparator).last;

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
                  Icons.drive_folder_upload_rounded,
                  size: 32.0,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                isExtended
                    ? Row(
                        children: [
                          const SizedBox(width: 16.0),
                          SizedBox(
                            width: constraints.maxWidth - 80,
                            child: Text(
                              softWrap: false,
                              maxLines: 1,
                              '${Platform.pathSeparator}${savePath.split(Platform.pathSeparator).last.replaceAll('', '\u{200B}')}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                overflow: TextOverflow
                                    .ellipsis, //https://github.com/flutter/flutter/issues/18761 "Text overflow with ellipsis is weird and ugly by design"
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          onTap: () {
            if (savePathSplit.contains('content')) {
              showSnackbar(
                text: Localization.appLocalizations().alreadyAtHighestLevel,
                seconds: 2,
              );
              return;
            }
            checkUnsavedBeforeFunction(
              editingPageKey: editingPageKey,
              function: () {
                Preferences.setCurrentPath(savePath.substring(
                  0,
                  savePath.length - savePathSplit.length - 1,
                ));
                setStateCallback();
              },
            );
          }, //this.index = index),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _parentFolderButton();
  }
}
