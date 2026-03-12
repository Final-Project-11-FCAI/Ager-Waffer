import 'package:ager_waffer/Base/common/theme.dart';
import 'package:ager_waffer/Features/Home/domain/entities/product_entity.dart';
import 'package:ager_waffer/Features/Home/presentation/pages/request_rscreen.dart';
import 'package:flutter/material.dart';

class RentalTermsPage extends StatefulWidget {
  const RentalTermsPage({super.key});

  @override
  State<RentalTermsPage> createState() => _RentalTermsPageState();
}

class _RentalTermsPageState extends State<RentalTermsPage> {
  List<bool> termsChecked = [true, true, true, true, true];

  final List<String> terms = [
    "الالتزام بمدة الإيجار المحددة",
    "إعادة المنتج بنفس حالته وقت الاستلام",
    "يتحمل المستأجر تكلفة أي تلف ناتج عن سوء الاستخدام",
    "يتم استرداد مبلغ التأمين بعد فحص المنتج",
    "يُستخدم المنتج للغرض المتفق عليه فقط ولا يسمح بإعادة تأجيره",
  ];
  late final ProductEntity product;
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
                  ),
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
                   Text(
                    "شروط الإيجار",
                    style: font14BlackBold.copyWith(
                      fontSize: 20
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
                      onPressed: () {
                        Navigator.pop(context ,
                        MaterialPageRoute(builder: (context) => const RequestScreen()),
                        );
                      },
                      child: const Text(
                        "موافق",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor
                        ),
                      ),
                    ),
                  ),
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
          style:  font20PrimaryMedium.copyWith(

            fontSize: 16

          ),
        ),
        activeColor: kPrimaryColor,
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
