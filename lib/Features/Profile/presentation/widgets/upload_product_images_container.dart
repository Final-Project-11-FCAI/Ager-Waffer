import 'dart:io';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Profile/presentation/widgets/full_screen_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class UploadProductImagesContainer extends StatefulWidget {
  final Function(List<File>)? onImagesSelected;

  const UploadProductImagesContainer({super.key, this.onImagesSelected});

  @override
  State<UploadProductImagesContainer> createState() =>
      _UploadProductImagesContainerState();
}

class _UploadProductImagesContainerState
    extends State<UploadProductImagesContainer> {

  final ImagePicker _picker = ImagePicker();
  List<File> selectedImages = [];

  Future<void> pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images == null || images.isEmpty) return;

    List<File> newFiles = images.map((e) => File(e.path)).toList();

    List<File> updatedImages = [...selectedImages, ...newFiles];

    updatedImages = updatedImages.toSet().toList();

    if (updatedImages.length > 5) {
      updatedImages = updatedImages.take(5).toList();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الحد الأقصى 5 صور")),
      );
    }

    if (updatedImages.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يجب اختيار 3 صور على الأقل")),
      );
      return;
    }

    setState(() {
      selectedImages = updatedImages;
    });

    widget.onImagesSelected?.call(selectedImages);
  }

  void openImage(File image) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) => FullScreenImage(image: image),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(25),
      dashPattern: const [6, 8],
      strokeWidth: 1.4,
      color: kLightPrimaryColor,
      child: Container(
        width: double.infinity,
        height: selectedImages.isEmpty
            ? Shared.height * 0.3.h
            : null,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.r),
          color: kProductDataContainerColor,
        ),

        child: selectedImages.isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/camera_plus.png',
              width: 50.w,
              height: 50.h,
            ),
            Gap(10.h),
            Text(
              'ارفع صور المنتج',
              style: font16BlackSemiBold.copyWith(fontSize: 15),
            ),
            Gap(4.h),
            Text(
              'يمكنك رفع من 3 إلي 5 صور',
              style: font13kLightPrimaryColorMedium,
            ),
            Gap(10.h),
            SizedBox(
              width: Shared.width * 0.35.w,
              child: ElevatedButton(
                onPressed: pickImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                child: Text(
                  'تحميل الصور',
                  style: font13kLightPrimaryColorMedium.copyWith(
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        )

            : SizedBox(
          height: Shared.height * 0.16.h,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: selectedImages.length + 1,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < selectedImages.length) {
                setState(() {
                  if (newIndex > oldIndex) newIndex--;
                  final item = selectedImages.removeAt(oldIndex);
                  selectedImages.insert(newIndex, item);
                });
                widget.onImagesSelected?.call(selectedImages);
              }
            },
            itemBuilder: (context, index) {
              if (index < selectedImages.length) {
                final image = selectedImages[index];

                return Container(
                  key: ValueKey(image.path),
                  margin: EdgeInsets.all(6.w),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () => openImage(image),
                        child: Hero(
                          tag: image.path,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.file(
                              image,
                              width: Shared.width * 0.3.w,
                              height: Shared.height * 0.16.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedImages.removeAt(index);
                            });
                            widget.onImagesSelected
                                ?.call(selectedImages);
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: kMoreRedColor,
                            child: Icon(Icons.close,
                                size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Container(
                key: const ValueKey("add_button"),
                margin: EdgeInsets.all(6.w),
                child: GestureDetector(
                  onTap: pickImages,
                  child: Container(
                    width: Shared.width * 0.3.w,
                    height: Shared.height * 0.16.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: kPrimaryColor),
                    ),
                    child: Icon(Icons.add,
                        size: 30.sp, color: kPrimaryColor),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}