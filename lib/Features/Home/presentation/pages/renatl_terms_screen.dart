import 'package:flutter/material.dart';

class RenatlTermsScreen extends StatefulWidget {
  const RenatlTermsScreen({super.key});

  @override
  State<RenatlTermsScreen> createState() => _RenatlTermsScreenState();
}

class _RenatlTermsScreenState extends State<RenatlTermsScreen> {

  List<bool> termsChecked = [true, true, true, true, true];

  final List<String> terms = [
    "الالتزام بمدة الإيجار المحددة",
    "إعادة المنتج بنفس حالته وقت الاستلام",
    "يتحمل المستأجر تكلفة أي تلف ناتج عن سوء الاستخدام",
    "يتم استرداد مبلغ التأمين بعد فحص المنتج",
    "يُستخدم المنتج للغرض المتفق عليه فقط ولا يسمح بإعادة تأجيره",
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: SafeArea(
          child: Center(
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
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// زر اغلاق
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  /// العنوان
                  const Text(
                    "شروط الإيجار",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// الشروط
                  ...List.generate(
                    terms.length,
                    (index) => _buildTermItem(index),
                  ),

                  const SizedBox(height: 25),

                  /// زر موافق
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0B3C4C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "موافق",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermItem(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xffE9EDF0),
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
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff0B3C4C),
          ),
        ),
        activeColor: const Color(0xff4F7C8A),
        controlAffinity: ListTileControlAffinity.trailing,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}