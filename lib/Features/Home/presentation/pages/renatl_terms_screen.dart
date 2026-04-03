import 'package:ager_waffer/Base/common/theme.dart';
import 'package:flutter/material.dart';

class RenatlTermsScreen extends StatefulWidget {
  const RenatlTermsScreen({super.key});

  @override
  State<RenatlTermsScreen> createState() => _RenatlTermsScreenState();
}

class _RenatlTermsScreenState extends State<RenatlTermsScreen> {
  List<bool> termsChecked = [false, false, false, false, false];

  final List<String> terms = [
    "الالتزام بمدة الإيجار المحددة",
    "إعادة المنتج بنفس حالته وقت الاستلام",
    "يتحمل المستأجر تكلفة أي تلف ناتج عن سوء الاستخدام",
    "يتم استرداد مبلغ التأمين بعد فحص المنتج",
    "يُستخدم المنتج للغرض المتفق عليه فقط ولا يسمح بإعادة تأجيره",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// العنوان
            const Text(
              "شروط الإيجار",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            /// الشروط
            ...List.generate(terms.length, (index) => _buildTermItem(index)),

            const SizedBox(height: 25),

            /// زر موافق
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "موافق",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 240, 240, 240),
        borderRadius: BorderRadius.circular(15),
      ),
      child: CheckboxListTile(
        value: termsChecked[index],
        onChanged: (value) {
          setState(() {
            termsChecked[index] = value!;
          });
        },
        title: Text(
          terms[index],
          style: const TextStyle(fontSize: 14, color: kPrimaryColor),
        ),
        activeColor: kPrimaryColor,
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
