import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/info_row.dart';
import '../widgets/rating_bar.dart';
import '../widgets/section_header.dart';
import 'booking_screen.dart';

class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({super.key, required this.destination});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isFavorite = false;
  final double _bottomBarHeight = 90;

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: _bottomBarHeight + 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header image with overlays
                Stack(
                  children: [
                    // Hero image
                    SizedBox(
                      height: 320,
                      width: double.infinity,
                      child: Image.asset(
                        d.imageAsset,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, e, st) => Container(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          child: const Center(
                            child: Icon(Icons.image_not_supported,
                                size: 60, color: AppColors.surface),
                          ),
                        ),
                      ),
                    ),

                    // Gradient overlay
                    Positioned.fill(
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x55000000),
                              Color(0x00000000),
                              Color(0x88000000),
                            ],
                            stops: [0.0, 0.4, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Back button + favorite
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _circleButton(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => Navigator.pop(context),
                          ),
                          _circleButton(
                            icon: _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            iconColor: _isFavorite
                                ? AppColors.accent
                                : AppColors.surface,
                            onTap: () =>
                                setState(() => _isFavorite = !_isFavorite),
                          ),
                        ],
                      ),
                    ),

                    // Destination name overlay on image
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.name,
                            style: const TextStyle(
                              color: AppColors.surface,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    blurRadius: 8, color: Color(0x88000000))
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  color: AppColors.surface, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                d.country,
                                style: const TextStyle(
                                  color: Color(0xDDFFFFFF),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Content section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Price + rating row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RatingBar(
                            rating: d.rating,
                            reviewCount: d.reviewCount,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha:0.12),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '\$${d.pricePerNight.toStringAsFixed(0)}/night',
                              style: AppTextStyles.priceSmall,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      const Divider(color: AppColors.divider, height: 1),
                      const SizedBox(height: 16),

                      // Trip info
                      InfoRow(
                        icon: Icons.access_time_rounded,
                        label: 'Duration',
                        value: d.duration,
                      ),
                      InfoRow(
                        icon: Icons.wb_sunny_rounded,
                        label: 'Weather',
                        value: d.weather,
                        iconColor: AppColors.star,
                      ),
                      InfoRow(
                        icon: Icons.category_rounded,
                        label: 'Category',
                        value: d.category,
                      ),

                      const SizedBox(height: 16),
                      const Divider(color: AppColors.divider, height: 1),
                      const SizedBox(height: 8),

                      // About section
                      const SectionHeader(title: 'About'),
                      const SizedBox(height: 4),
                      Text(d.description, style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Fixed bottom bar: price + Book Now
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: _bottomBarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha:0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Total Price',
                            style: AppTextStyles.label),
                        Text(
                          '\$${d.pricePerNight.toStringAsFixed(0)}/night',
                          style: AppTextStyles.price,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingScreen(destination: d),
                          ),
                        );
                      },
                      icon: const Icon(Icons.calendar_month_rounded, size: 18),
                      label: const Text('Book Now'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = AppColors.surface,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha:0.35),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
    );
  }
}
