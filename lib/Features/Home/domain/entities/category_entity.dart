class CategoryEntity {
  final String title;
  final String image;
  final Function() onTap;

  CategoryEntity({
    required this.title,
    required this.image,
    required this.onTap,
  });
}
