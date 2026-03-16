import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/info_row.dart';
import '../widgets/rating_bar.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final Destination destination;
  final double totalPrice;
  final DateTime checkIn;
  final DateTime checkOut;
  final int adults;
  final int children;
  final String roomType;
  final int nights;

  const BookingConfirmationScreen({
    super.key,
    required this.destination,
    required this.totalPrice,
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.children,
    required this.roomType,
    required this.nights,
  });

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  String get _guestSummary {
    final parts = <String>[];
    parts.add('$adults ${adults == 1 ? 'Adult' : 'Adults'}');
    if (children > 0) {
      parts.add('$children ${children == 1 ? 'Child' : 'Children'}');
    }
    return parts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final d = destination;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Hero image header ─────────────────────────────
            Stack(
              children: [
                SizedBox(
                  height: 280,
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
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x66000000), Color(0xBB000000)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 24,
                  left: 24,
                  right: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.name,
                        style: const TextStyle(
                          color: AppColors.surface,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
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
                                color: Color(0xDDFFFFFF), fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Confirmed badge ───────────────────────────────
            Transform.translate(
              offset: const Offset(0, -28),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: AppColors.surface, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Booking Confirmed!',
                      style: TextStyle(
                        color: AppColors.surface,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Content ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking reference
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Booking Reference',
                                style: AppTextStyles.label),
                            SizedBox(height: 4),
                            Text(
                              '#TRV-2025-4891',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                              Icons.confirmation_number_rounded,
                              color: AppColors.surface,
                              size: 22),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  RatingBar(rating: d.rating, reviewCount: d.reviewCount),

                  const SizedBox(height: 20),

                  // ── Trip Summary ──────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your Trip', style: AppTextStyles.heading3),
                        const SizedBox(height: 12),

                        // Check-in (user selected)
                        InfoRow(
                          icon: Icons.flight_land_rounded,
                          label: 'Check-in',
                          value: _formatDate(checkIn),
                        ),
                        const Divider(color: AppColors.divider, height: 16),

                        // Check-out (user selected)
                        InfoRow(
                          icon: Icons.flight_takeoff_rounded,
                          label: 'Check-out',
                          value: _formatDate(checkOut),
                        ),
                        const Divider(color: AppColors.divider, height: 16),

                        // Duration (computed)
                        InfoRow(
                          icon: Icons.access_time_rounded,
                          label: 'Duration',
                          value:
                              '$nights ${nights == 1 ? 'Night' : 'Nights'}',
                        ),
                        const Divider(color: AppColors.divider, height: 16),

                        // Guests (user selected)
                        InfoRow(
                          icon: Icons.people_rounded,
                          label: 'Guests',
                          value: _guestSummary,
                        ),
                        const Divider(color: AppColors.divider, height: 16),

                        // Room type (user selected)
                        InfoRow(
                          icon: Icons.hotel_rounded,
                          label: 'Room Type',
                          value: roomType,
                        ),
                        const Divider(color: AppColors.divider, height: 16),

                        // Weather (from destination)
                        InfoRow(
                          icon: Icons.wb_sunny_rounded,
                          label: 'Weather',
                          value: d.weather,
                          iconColor: AppColors.star,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Total paid banner ─────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primary, AppColors.primaryDark],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Total Paid',
                                style: TextStyle(
                                    color: Color(0xBBFFFFFF), fontSize: 13)),
                            const SizedBox(height: 2),
                            Text(
                              '$nights ${nights == 1 ? 'night' : 'nights'} · $_guestSummary',
                              style: const TextStyle(
                                  color: Color(0x88FFFFFF), fontSize: 11),
                            ),
                          ],
                        ),
                        Text(
                          '\$${totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppColors.surface,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                      icon: const Icon(Icons.home_rounded),
                      label: const Text('Back to Home'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => Navigator.of(context)
                          .popUntil((route) => route.isFirst),
                      icon: const Icon(Icons.explore_rounded,
                          color: AppColors.primary),
                      label: const Text('Explore More Destinations',
                          style: TextStyle(color: AppColors.primary)),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
