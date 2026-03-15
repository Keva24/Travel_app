class Destination {
  final String id;
  final String name;
  final String country;
  final String imageAsset;
  final String description;
  final double rating;
  final int reviewCount;
  final double pricePerNight;
  final String duration;
  final String weather;
  final String category;
  final bool isFeatured;

  const Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageAsset,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.pricePerNight,
    required this.duration,
    required this.weather,
    required this.category,
    this.isFeatured = false,
  });
}
