import 'dart:io';

class AddItemEntity {
  final String name;
  final String description;
  final String categoryName;
  final String insurance;
  final String condition;
  final String rentUnit;
  final String city;
  final bool isAvailable;
  final String price;
  final List<File>? images;

  AddItemEntity({
    required this.name,
    required this.description,
    required this.categoryName,
    required this.insurance,
    required this.condition,
    required this.rentUnit,
    required this.city,
    required this.isAvailable,
    required this.price,
    required this.images,
  });
}
