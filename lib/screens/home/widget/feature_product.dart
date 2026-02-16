import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProductAutoSlider extends StatefulWidget {
  final List products;

  const ProductAutoSlider({Key? key, required this.products}) : super(key: key);

  @override
  State<ProductAutoSlider> createState() => _ProductAutoSliderState();
}

class _ProductAutoSliderState extends State<ProductAutoSlider> {
  late PageController _controller;
  Timer? _timer;
  int _current = 0;

  final List<String> _images = [
    'assets/images/sofasix.png',
    'assets/images/sofaseven.png',
    'assets/images/sofaeight.png',
    'assets/images/sofanine.png',
    'assets/images/sofa.png',
  ];

  void startAutoSlide() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      final count = widget.products.isEmpty
          ? _images.length
          : widget.products.length;

      if (_controller.hasClients) {
        _current = (_current + 1) % count;
        _controller.animateToPage(
          _current,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
    startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.products.isEmpty
        ? _images.length
        : widget.products.length;

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _controller,
            itemCount: count,
            onPageChanged: (index) {
              setState(() => _current = index);
              startAutoSlide(); // restart timer after swipe
            },
            itemBuilder: (context, index) {
              final img = _images[index % _images.length];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(img, fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 8),

        /// Indicator dots
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (i) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: i == _current ? 10 : 8,
              height: i == _current ? 10 : 8,
              decoration: BoxDecoration(
                color: i == _current
                    ? AppColors.primaryColor
                    : AppColors.greyColor.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
