class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final double rating;
  final String description;
  final String category;
  final bool isFavorite;
  final List<String> images;
  final String brand;
  final String dimensions;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.rating,
    required this.description,
    this.category = '',
    this.isFavorite = false,
    this.images = const [],
    this.brand = '',
    this.dimensions = '',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      isFavorite: json['is_favorite'] ?? false,
      images: List<String>.from(json['images'] ?? []),
      brand: json['brand'] ?? '',
      dimensions: json['dimensions'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'rating': rating,
      'description': description,
      'category': category,
      'is_favorite': isFavorite,
      'images': images,
      'brand': brand,
      'dimensions': dimensions,
    };
  }
}
