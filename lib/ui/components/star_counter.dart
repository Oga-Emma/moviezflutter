import 'package:flutter/material.dart';

class StarCounter extends StatelessWidget {
  const StarCounter({required this.count, Key? key}) : super(key: key);
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
          5,
          (index) => Icon(
                index <= count ? Icons.star : Icons.star_border_outlined,
                color: Colors.grey,
                size: 16,
              )),
    );
  }
}
