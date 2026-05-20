class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final String imageUrl;
  final String thumbnail;
  final double rating;
  final int stock;
  final String brand;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.thumbnail,
    required this.rating,
    required this.stock,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      imageUrl: json['thumbnail'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] ?? 0,
      brand: json['brand'] ?? '-',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'image_url': imageUrl,
      'thumbnail': thumbnail,
      'rating': rating,
      'stock': stock,
      'brand': brand,
    };
  }
}
