import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:ager_waffer/Base/common/navigtor.dart';
import 'package:ager_waffer/Base/common/shared.dart';
import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Chat/data/models/firebase/fire_database.dart';
import 'package:ager_waffer/Features/Chat/data/models/user_model.dart';
import 'package:ager_waffer/Features/Chat/presentation/pages/chat_screen.dart';
import 'package:ager_waffer/Features/Home/data/models/all_items_model.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/public_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gap/gap.dart';

class ContactOwnerContainer extends StatelessWidget {
  const ContactOwnerContainer({super.key, required this.product});

  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Shared.width * 0.04.w,
        vertical: Shared.height * 0.03.h,
      ),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: kPrimaryColor.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              customAnimatedPushNavigation(
                context,
                PublicViewScreen(product: product),
              );
            },
            child: CircleAvatar(
              radius: 24.r,
              backgroundImage:
                  product.ownerPictureUrl != null &&
                      product.ownerPictureUrl!.isNotEmpty
                  ? NetworkImage(product.ownerPictureUrl!)
                  : AssetImage('assets/images/virtual_user.jpg'),
            ),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.ownerName!,
                  style: font16BlackSemiBold.copyWith(fontSize: 14.sp),
                ),
                Row(
                  children: [
                    Text(
                      '4.5',
                      style: font20PrimaryMedium.copyWith(fontSize: 15.sp),
                    ),
                    Gap(1.w),
                    Icon(Icons.star, size: 17.sp, color: Colors.amber),
                  ],
                ),
              ],
            ),
          ),
          Gap(8.w),
          SizedBox(
            height: 34.h,
            child: OutlinedButton(
              onPressed: () async {
                final roomId = await FireData().createRoom(
                  product.ownerEmail!,
                );

                if (roomId != null) {
                  customAnimatedPushNavigation(
                    context,
                    ChatScreen(
                      roomId: roomId,
                      chatUser: ChatUser(
                        id: product.ownerId,
                        name: product.ownerName,
                        image: product.ownerPictureUrl,
                        about: "Hello I'm ${product.ownerName}",
                        email: product.ownerEmail,
                        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                        lastActivated: DateTime.now().millisecondsSinceEpoch.toString(),
                        pushToken: '',
                        online: false,
                        myUsers: [],
                      ),
                    ),
                  );
                } else {
                  print("EMAIL: ${product.ownerEmail}");
                  print("ID: ${product.ownerId}");
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("User not found")));
                }
              },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                backgroundColor: kBlueColor.withOpacity(0.12),
                side: const BorderSide(color: kLightBlueColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    kContactOwner.tr(),
                    style: font16BlackSemiBold.copyWith(
                      fontSize: 12.sp,
                      color: kBlueColor,
                    ),
                  ),
                  Gap(5.w),
                  Image.asset('assets/images/contact_icon.png'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
