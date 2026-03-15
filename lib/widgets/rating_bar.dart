import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double iconSize;

  const RatingBar({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.iconSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final filled = index < rating.floor();
          final half = !filled && index < rating;
          return Icon(
            half ? Icons.star_half : (filled ? Icons.star : Icons.star_border),
            color: AppColors.star,
            size: iconSize,
          );
        }),
        const SizedBox(width: 6),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: iconSize * 0.8,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        if (reviewCount > 0) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount reviews)',
            style: AppTextStyles.label,
          ),
        ],
      ],
    );
  }
}
