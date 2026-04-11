import 'package:ager_waffer/Base/common/local_const.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OnboardingDate {
  final String image;
  final String title;
  final String subTitle;


  OnboardingDate({required this.image, required this.title, required this.subTitle,});
}

List<OnboardingDate> onboardingDate = [
  OnboardingDate(
    image: 'assets/images/onboarding_image1.png',
    title: kOnboardingTitle1.tr(),
    subTitle: kOnboardingSubTitle1.tr(),
  ),
  OnboardingDate(
    image: 'assets/images/onboarding_image2.png',
    title: kOnboardingTitle2.tr(),
    subTitle: kOnboardingSubTitle2.tr(),
  ),
  OnboardingDate(
    image: 'assets/images/onboarding_image3.png',
    title: kOnboardingTitle3.tr(),
    subTitle: kOnboardingSubTitle3.tr(),
  ),


];
