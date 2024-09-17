import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/image_pick_alert.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/helper_methods/picker_image.dart';

class ImagePickerProfileEditableView extends StatelessWidget {
  const ImagePickerProfileEditableView({
    super.key,
    required this.imgFile,
    required this.picker,
  });
  final ValueNotifier<File?> imgFile;
  final ImagePicker picker;

  // late ImagePicker _picker;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: imgFile,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () => showDialog(
            context: context,
            builder: (context) => imagePickAlert(
              backgroundColor: Theme.of(context).colorScheme.outline,
              onGalleryPressed: () async {
                Navigator.pop(context);

                XFile? file =
                    await ObtainImg.obtainImage(picker, ImageSource.gallery);
                debugPrint('profileImage: ${file?.path}');
                imgFile.value = File(file!.path);
              },
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                // NetworkImageWidget(
                //   imageUrl: '',
                //   iconSize: 40,
                //   width: context.mqw * .24,
                //   height: context.mqh * .12,
                // ),
                imgFile.value != null
                    ? Container(
                        width: context.mqw * .24,
                        height: context.mqw * .24,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outline,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                            width: .22,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.file(
                            imgFile.value!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: context.mqw * .24,
                        height: context.mqh * .12,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.outline,
                          shape: BoxShape.circle,
                        ),
                        child: const CustomIconWidget(
                          icon: Icons.person_outline,
                          size: 40,
                        ),
                      ),
                Positioned(
                  bottom: context.mqh * 0,
                  right: context.mqh * .01,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    child: CustomIconWidget(
                      icon: CupertinoIcons.camera_circle,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
