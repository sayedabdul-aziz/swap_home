import 'package:swap_ui/core/constants/app_images.dart';

class ProductModel {
  final String id;
  final String title;
  final String image;
  final String description;
  final double price;
  final String category;
  final PublisherModel publisher;
  final DateTime publishedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
    required this.publisher,
    required this.publishedAt,
  });
}

class PublisherModel {
  String? id;
  String? name;
  String? image;
  double? rating;
  String? location;
  double? distanceKm;

  PublisherModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.location,
    required this.distanceKm,
  });
}

List<ProductModel> products = [
  ProductModel(
    id: '1',
    title: 'Xbox Series S 512 GB',
    image: AppImages.xbox,
    description:
        'A next-gen console with powerful performance and stunning graphics.',
    price: 10.0,
    category: 'Electronics',
    publisher: PublisherModel(
      id: '1',
      name: 'John Wick',
      image: AppImages.user,
      rating: 4.7,
      location: 'Zamalek',
      distanceKm: 23,
    ),
    publishedAt: DateTime.now(),
  ),
];
