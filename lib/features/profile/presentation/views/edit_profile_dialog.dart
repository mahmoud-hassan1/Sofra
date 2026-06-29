import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sofra/core/utils/colors.dart';
import 'package:sofra/core/utils/fonts.dart';
import 'package:sofra/features/profile/data/models/profile_user_model.dart';
import 'package:sofra/features/profile/presentation/controllers/cubit/profile_cubit.dart';
import 'package:sofra/features/profile/presentation/views/widgets/profile_avatar.dart';

/// Dialog-style card matching the mockup:
///   - Pink header row: "EDIT PROFILE" + ✕ close button
///   - White body: centered avatar with "CHANGE AVATAR" tap, name field, bio field
///   - Pink footer: full-width "SAVE CHANGES" button (primary red)
class EditProfileDialog extends StatefulWidget {
  final ProfileUserModel user;
  const EditProfileDialog({super.key, required this.user});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _bioCtrl;
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(
      text: widget.user.displayName ?? widget.user.fullName,
    );
    _bioCtrl = TextEditingController(text: widget.user.bio ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final source = await _showSourcePicker();
    if (source == null) return;

    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 800,
    );
    if (picked != null && mounted) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  /// Shows a bottom sheet with Camera / Gallery options.
  /// Returns the chosen [ImageSource] or null if dismissed.
  Future<ImageSource?> _showSourcePicker() {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neutralColor, width: 2.5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(5, 5),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: const BoxDecoration(
                color: AppColors.lightBrownAppBarBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
              ),
              child: Center(
                child: Text(
                  'CHOOSE SOURCE',
                  style: AppFonts.label.copyWith(
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            // Camera option
            _SourceTile(
              icon: Icons.camera_alt_outlined,
              label: 'Take a Photo',
              onTap: () => Navigator.of(ctx).pop(ImageSource.camera),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            // Gallery option
            _SourceTile(
              icon: Icons.photo_library_outlined,
              label: 'Choose from Gallery',
              onTap: () => Navigator.of(ctx).pop(ImageSource.gallery),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _save(BuildContext ctx) {
    if (!_formKey.currentState!.validate()) return;

    final cubit = ctx.read<ProfileCubit>();

    if (_pickedImage != null) {
      cubit.updateAvatar(_pickedImage!.path);
    }

    final newName = _nameCtrl.text.trim();
    final newBio = _bioCtrl.text.trim();
    final originalName = widget.user.displayName ?? widget.user.fullName;
    final originalBio = widget.user.bio ?? '';

    if (newName != originalName || newBio != originalBio) {
      cubit.updateProfile(
        displayName: newName.isNotEmpty ? newName : null,
        bio: newBio.isNotEmpty ? newBio : null,
      );
    }

    Navigator.of(ctx).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neutralColor, width: 2.5),
          boxShadow: const [
            BoxShadow(
              color: AppColors.neutralColor,
              offset: Offset(6, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Pink header ─────────────────────────────────────────────
              _DialogHeader(onClose: () => Navigator.of(context).pop()),

              // ── White body ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Centered avatar
                    _AvatarSection(
                      pickedImage: _pickedImage,
                      avatarUrl: widget.user.avatarUrl,
                      onTap: _pickImage,
                    ),
                    const SizedBox(height: 24),

                    // Display name field
                    _FieldLabel(label: 'DISPLAY NAME'),
                    const SizedBox(height: 6),
                    _ProfileTextField(
                      controller: _nameCtrl,
                      hintText: 'Your name',
                      maxLines: 1,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Name is required';
                        }
                        if (v.trim().length < 2) return 'At least 2 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Bio field
                    _FieldLabel(label: 'BIO'),
                    const SizedBox(height: 6),
                    _ProfileTextField(
                      controller: _bioCtrl,
                      hintText: 'Taco enthusiast & spicy food hunter.',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),

              // ── Pink footer with save button ────────────────────────────
              _DialogFooter(onSave: () => _save(context)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pink header: "EDIT PROFILE" + ✕
// ---------------------------------------------------------------------------
class _DialogHeader extends StatelessWidget {
  final VoidCallback onClose;
  const _DialogHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.lightBrownAppBarBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'EDIT PROFILE',
            style: AppFonts.header.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: AppColors.neutralColor,
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.neutralColor, width: 1.5),
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Centered avatar + "CHANGE AVATAR" label
// ---------------------------------------------------------------------------
class _AvatarSection extends StatelessWidget {
  final File? pickedImage;
  final String? avatarUrl;
  final VoidCallback onTap;

  const _AvatarSection({
    required this.pickedImage,
    required this.avatarUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Avatar image (picked → network → asset fallback)
          if (pickedImage != null)
            _PickedAvatar(file: pickedImage!)
          else
            ProfileAvatar(avatarUrl: avatarUrl, size: 80),
          const SizedBox(height: 10),
          Text(
            'CHANGE AVATAR',
            style: AppFonts.label.copyWith(
              fontSize: 11,
              letterSpacing: 1.2,
              color: AppColors.seconderyFontColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _PickedAvatar extends StatelessWidget {
  final File file;
  const _PickedAvatar({required this.file});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.neutralColor, width: 2.5),
        boxShadow: const [
          BoxShadow(
            color: AppColors.neutralColor,
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.file(file, width: 80, height: 80, fit: BoxFit.cover),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Field label
// ---------------------------------------------------------------------------
class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppFonts.label.copyWith(fontSize: 12, letterSpacing: 0.8),
    );
  }
}

// ---------------------------------------------------------------------------
// Text input field (matches the clean style in the mockup)
// ---------------------------------------------------------------------------
class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String? Function(String?)? validator;

  const _ProfileTextField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      style: AppFonts.bodyMedium.copyWith(
        fontSize: 15,
        color: AppColors.primaryFontColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFonts.bodyMedium.copyWith(
          color: AppColors.seconderyFontColor,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.neutralColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.neutralColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.errorColor, width: 2),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pink footer with full-width red "SAVE CHANGES" button
// ---------------------------------------------------------------------------
class _DialogFooter extends StatelessWidget {
  final VoidCallback onSave;
  const _DialogFooter({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.lightBrownAppBarBackground,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(13)),
      ),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (ctx, state) {
          final isLoading = state is ProfileLoading;
          return GestureDetector(
            onTap: isLoading ? null : onSave,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: isLoading
                    ? AppColors.primaryColor.shade300
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'SAVE CHANGES',
                        style: AppFonts.header.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Reusable tile for the source picker bottom sheet
// ---------------------------------------------------------------------------
class _SourceTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SourceTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.neutralColor, width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.neutralColor,
                    offset: Offset(3, 3),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Icon(icon, size: 22, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: AppFonts.bodyMedium.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
