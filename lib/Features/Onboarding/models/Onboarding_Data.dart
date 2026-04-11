import 'package:ager_waffer/Base/common/local_const.dart';

class OnboardingDate {
  final String image;
  final String title;
  final String subTitle;


  OnboardingDate({required this.image, required this.title, required this.subTitle,});
}

List<OnboardingDate> onboardingDate = [
  OnboardingDate(
    image: 'assets/images/onboarding_image1.png',
    title: kOnboardingTitle1,
    subTitle: kOnboardingSubTitle1,
  ),
  OnboardingDate(
    image: 'assets/images/onboarding_image2.png',
    title: kOnboardingTitle2,
    subTitle: kOnboardingSubTitle2,
  ),
  OnboardingDate(
    image: 'assets/images/onboarding_image3.png',
    title: kOnboardingTitle3,
    subTitle: kOnboardingSubTitle3,
  ),


];
