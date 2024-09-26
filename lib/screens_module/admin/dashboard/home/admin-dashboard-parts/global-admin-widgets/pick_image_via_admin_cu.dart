import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/image_pick_alert.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/helper_methods/picker_image.dart';

class PickImageViaAdminViewCU extends StatefulWidget {
  const PickImageViaAdminViewCU({
    super.key,
    required this.imgFile,
  });

  final ValueNotifier<File?> imgFile;
  @override
  State<PickImageViaAdminViewCU> createState() =>
      _PickImageViaAdminViewCUState();
}

class _PickImageViaAdminViewCUState extends State<PickImageViaAdminViewCU> {
  late ImagePicker _imagePicker;

  @override
  void initState() {
    _imagePicker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    widget.imgFile.dispose();
    super.dispose();
  }

  bool isImageLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showImagePickAlert(context, _imagePicker, widget.imgFile),
      child: ValueListenableBuilder(
        valueListenable: widget.imgFile,
        builder: (BuildContext context, value, Widget? child) =>
            _ImagePickerContainer(image: value?.path ?? ''),
      ),
    );
  }

  void _showImagePickAlert(
    BuildContext context,
    ImagePicker imagePicker,
    ValueNotifier<File?> imgFile,
  ) {
    showDialog(
      context: context,
      builder: (context) => imagePickAlert(
        backgroundColor: Theme.of(context).colorScheme.outline,
        onGalleryPressed: () async {
          await _handleGalleryPress(imagePicker, imgFile);
          if (context.mounted) {
            NavigationUtils.popNavigation(context);
          }
        },
        onCameraPressed: () async {
          await _handleCameraPress(imagePicker, imgFile);
          if (context.mounted) {
            NavigationUtils.popNavigation(context);
          }
        },
      ),
    );
  }

  Future<void> _handleGalleryPress(
    ImagePicker imagePicker,
    ValueNotifier<File?> imgFile,
  ) async {
    setState(() {
      isImageLoading = true;
    });
    XFile? file = await ObtainImg.obtainImage(imagePicker, ImageSource.gallery);
    if (file == null) return;

    imgFile.value = File(file.path);
    setState(() {
      isImageLoading = false;
    });
    debugPrint('Gallery Image Path: ${file.path}');
    debugPrint('Gallery Image Path (valueNotifier): ${imgFile.value?.path}');
  }

  Future<void> _handleCameraPress(
    ImagePicker imagePicker,
    ValueNotifier<File?> imgFile,
  ) async {
    setState(() {
      isImageLoading = true;
    });
    XFile? file = await ObtainImg.obtainImage(imagePicker, ImageSource.camera);
    if (file == null) return;
    imgFile.value = File(file.path);
    setState(() {
      isImageLoading = false;
    });
    debugPrint('Camera Image Path: ${file.path}');
  }
}

class _ImagePickerContainer extends StatelessWidget {
  const _ImagePickerContainer({this.image});
  final String? image;

  @override
  Widget build(BuildContext context) {
    debugPrint('image->notify: $image');
    double imageSize = context.mqw * .46;

    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: (image?.isEmpty ?? true) || image == null
          ? const CustomIconWidget(
              icon: Icons.add_photo_alternate_outlined,
              size: 40,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image(
                image: FileImage(
                  File(image!),
                ),
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
