class FinishedOrdersEntity {
  final String image;
  final String title;
  final String owner;
  final String time;
  final String price;

  FinishedOrdersEntity({
    required this.image,
    required this.title,
    required this.price,
    required this.time,
    required this.owner,
  });
}