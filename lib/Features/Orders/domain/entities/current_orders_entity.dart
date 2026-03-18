class CurrentOrdersEntity {
  final String image;
  final String title;
  final String owner;
  final String time;
  final String price;
  final String remainder;

  CurrentOrdersEntity({
    required this.image,
    required this.title,
    required this.price,
    required this.time,
    required this.owner,
    required this.remainder,
  });
}