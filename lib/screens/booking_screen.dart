import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import 'booking_confirmation_screen.dart';

class BookingScreen extends StatefulWidget {
  final Destination destination;

  const BookingScreen({super.key, required this.destination});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _adults = 1;
  int _children = 0;
  String _roomType = 'Standard Room';

  static const List<String> _roomTypes = [
    'Standard Room',
    'Deluxe Room',
    'Junior Suite',
    'Grand Suite',
    'Private Villa',
  ];

  int get _nights {
    if (_checkIn == null || _checkOut == null) return 0;
    return _checkOut!.difference(_checkIn!).inDays;
  }

  double get _basePrice => widget.destination.pricePerNight * (_nights > 0 ? _nights : 1);
  double get _taxes => _basePrice * 0.12;
  double get _total => _basePrice + _taxes;

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  Future<void> _pickCheckIn() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkIn ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.surface,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _checkIn = picked;
        // If checkout is before or same as new check-in, reset it
        if (_checkOut != null && !_checkOut!.isAfter(picked)) {
          _checkOut = null;
        }
      });
    }
  }

  Future<void> _pickCheckOut() async {
    if (_checkIn == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a check-in date first.'),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }
    final minCheckout = _checkIn!.add(const Duration(days: 1));
    final picked = await showDatePicker(
      context: context,
      initialDate: _checkOut ?? minCheckout,
      firstDate: minCheckout,
      lastDate: _checkIn!.add(const Duration(days: 90)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.surface,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _checkOut = picked);
    }
  }

  bool get _canConfirm =>
      _checkIn != null && _checkOut != null && _nights > 0;

  void _confirmBooking() {
    if (!_canConfirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select check-in and check-out dates.'),
          backgroundColor: AppColors.accent,
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookingConfirmationScreen(
          destination: widget.destination,
          totalPrice: _total,
          checkIn: _checkIn!,
          checkOut: _checkOut!,
          adults: _adults,
          children: _children,
          roomType: _roomType,
          nights: _nights,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Booking Summary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Destination card ──────────────────────────────
            Card(
              elevation: 4,
              shadowColor: AppColors.cardShadow,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(
                          d.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, e, st) => Container(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            child: const Icon(Icons.image_not_supported,
                                color: AppColors.surface),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(d.name, style: AppTextStyles.heading3),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 14, color: AppColors.textSecondary),
                              const SizedBox(width: 4),
                              Text(d.country,
                                  style: AppTextStyles.bodyMedium),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '\$${d.pricePerNight.toStringAsFixed(0)}/night',
                            style: AppTextStyles.priceSmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Dates ─────────────────────────────────────────
            SectionHeader(title: 'Select Dates'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _DatePickerTile(
                    label: 'Check-in',
                    icon: Icons.flight_land_rounded,
                    value: _checkIn != null ? _formatDate(_checkIn!) : null,
                    hint: 'Select date',
                    onTap: _pickCheckIn,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DatePickerTile(
                    label: 'Check-out',
                    icon: Icons.flight_takeoff_rounded,
                    value: _checkOut != null ? _formatDate(_checkOut!) : null,
                    hint: 'Select date',
                    onTap: _pickCheckOut,
                  ),
                ),
              ],
            ),

            // Nights badge (shown only when both dates selected)
            if (_checkIn != null && _checkOut != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      '$_nights ${_nights == 1 ? 'night' : 'nights'}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 24),

            // ── Guests ────────────────────────────────────────
            SectionHeader(title: 'Guests'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _GuestCounter(
                    label: 'Adults',
                    sublabel: 'Age 13+',
                    icon: Icons.person_rounded,
                    count: _adults,
                    min: 1,
                    max: 10,
                    onDecrement: () => setState(() => _adults--),
                    onIncrement: () => setState(() => _adults++),
                  ),
                  const Divider(color: AppColors.divider, height: 16),
                  _GuestCounter(
                    label: 'Children',
                    sublabel: 'Ages 2–12',
                    icon: Icons.child_care_rounded,
                    count: _children,
                    min: 0,
                    max: 5,
                    onDecrement: () => setState(() => _children--),
                    onIncrement: () => setState(() => _children++),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Room Type ─────────────────────────────────────
            SectionHeader(title: 'Room Type'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _roomTypes.map((type) {
                final selected = _roomType == type;
                return GestureDetector(
                  onTap: () => setState(() => _roomType = type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.primary
                          : AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : AppColors.divider,
                        width: 1.5,
                      ),
                      boxShadow: selected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.hotel_rounded,
                          size: 15,
                          color: selected
                              ? AppColors.surface
                              : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          type,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? AppColors.surface
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ── Price Breakdown ───────────────────────────────
            SectionHeader(title: 'Price Breakdown'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _priceRow(
                    _nights > 0
                        ? '\$${d.pricePerNight.toStringAsFixed(0)} × $_nights ${_nights == 1 ? 'night' : 'nights'}'
                        : '\$${d.pricePerNight.toStringAsFixed(0)}/night',
                    _nights > 0
                        ? '\$${_basePrice.toStringAsFixed(0)}'
                        : '—',
                  ),
                  const SizedBox(height: 10),
                  _priceRow(
                    'Taxes & Fees (12%)',
                    _nights > 0 ? '\$${_taxes.toStringAsFixed(0)}' : '—',
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.divider),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          )),
                      Text(
                        _nights > 0
                            ? '\$${_total.toStringAsFixed(0)}'
                            : '—',
                        style: AppTextStyles.price,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ── Confirm Button ────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _confirmBooking,
                icon: const Icon(Icons.check_circle_outline_rounded),
                label: const Text('Confirm Booking'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor:
                      _canConfirm ? AppColors.accent : AppColors.divider,
                  foregroundColor: _canConfirm
                      ? AppColors.surface
                      : AppColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: 8),
            Center(
              child: Text(
                'Free cancellation up to 24 hours before check-in',
                style: AppTextStyles.label
                    .copyWith(color: Colors.green.shade600),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.bodyMedium),
        Text(value,
            style: AppTextStyles.bodyLarge
                .copyWith(fontWeight: FontWeight.w600, fontSize: 14)),
      ],
    );
  }
}

// ── Date Picker Tile ─────────────────────────────────────────────────────────
class _DatePickerTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? value;
  final String hint;
  final VoidCallback onTap;

  const _DatePickerTile({
    required this.label,
    required this.icon,
    required this.value,
    required this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: hasValue ? AppColors.primary : AppColors.divider,
            width: hasValue ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon,
                    size: 14,
                    color:
                        hasValue ? AppColors.primary : AppColors.textSecondary),
                const SizedBox(width: 5),
                Text(label, style: AppTextStyles.label),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              value ?? hint,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: hasValue ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Guest Counter ─────────────────────────────────────────────────────────────
class _GuestCounter extends StatelessWidget {
  final String label;
  final String sublabel;
  final IconData icon;
  final int count;
  final int min;
  final int max;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const _GuestCounter({
    required this.label,
    required this.sublabel,
    required this.icon,
    required this.count,
    required this.min,
    required this.max,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    )),
                Text(sublabel, style: AppTextStyles.label),
              ],
            ),
          ),
          // Decrement button
          _CounterButton(
            icon: Icons.remove_rounded,
            enabled: count > min,
            onTap: onDecrement,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              '$count',
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // Increment button
          _CounterButton(
            icon: Icons.add_rounded,
            enabled: count < max,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _CounterButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.divider,
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? AppColors.primary : AppColors.divider,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? AppColors.primary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
