import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/add%20recipe/widgets/decorated_container.dart';

class Addphoto extends StatefulWidget {
  const Addphoto({super.key});

  @override
  _AddphotoState createState() => _AddphotoState();
}

class _AddphotoState extends State<Addphoto> {
  File? _selectedImage;
  Future<void> _pickAndValidateImage() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedImage = File(result.files.single.path!);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected.'),
          backgroundColor: AppColors.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: _pickAndValidateImage,
        child: _selectedImage == null
            ? DecoratedContainer(
                padding: const EdgeInsets.all(16.0),
                width: 354,
                height: 224,
                backgroundColor: AppColors.backGroundColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: DottedBorder(
                    options: RoundedRectDottedBorderOptions(
                      color: AppColors.neutralColor,
                      strokeWidth: 2.5,
                      dashPattern: const [6, 4],
                      radius: Radius.circular(12.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.brownAppBarBackground,
                            radius: 32.0,
                            child: const Icon(
                              Icons.add_a_photo_outlined,
                              size: 27.5,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            "Upload Recipe Image",
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.neutralColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            "Make it look tasty! (JPEG/PNG)",
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.seconderyFontColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
      ),
    );
  }
}
