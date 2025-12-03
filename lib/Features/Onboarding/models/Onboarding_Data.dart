class OnboardingDate {
  final String image;
  final String title;
  final String subTitle;


  OnboardingDate({required this.image, required this.title, required this.subTitle,});
}

List<OnboardingDate> onboardingDate = [
  OnboardingDate(
    image: 'assets/images/onboarding_image1.png',
    title: 'مرحبًا بك في ',
    subTitle: 'اكتشف واستأجر كل ما تحتاجه من مجتمع موثوق به',
  ),
  OnboardingDate(
    image: 'assets/images/onboarding_image2.png',
    title: 'كل اللي تحتاجه في مكان واحد',
    subTitle: 'بدّل الشراء بالتأجير..واختار المنتج اللي يناسبك',
  ),
  OnboardingDate(
    image: 'assets/images/onboarding_image3.png',
    title: 'تجربة آمنة وموثوقة',
    subTitle: 'نوفر لك بيئة موثوق بها لضمان تعاملات سلسة وآمنة في كل مرة',
  ),


];
