import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';

class CoustomShowdialog {
  static void show({
    required BuildContext context,
    required Widget title,
    required Widget description,
    required String buttonText,
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// 🔹 Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xff0B3C4C),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 50),
                ),

                const SizedBox(height: 20),
                title,
                const SizedBox(height: 10),
                description,
                const SizedBox(height: 20),

                /// 🔹 Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0B3C4C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      if (onPressed != null) onPressed();
                    },
                    child: Text(
                      buttonText,
                      style: font14BlackBold.copyWith(
                        color: kWhiteColor,
                        fontSize: 20,
                      ),
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
