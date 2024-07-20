import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/text_style.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final int amount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;

  const DeliveryIncrementDecrementButton({super.key, required this.amount, required this.incrementTap, required this.decrementTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: context.colors.secondary),
            onPressed: decrementTap,
          ),
          Text(
            amount.toString(),
            style: context.textStyles.textRegular.copyWith(
              fontSize: 17,
              color: context.colors.secondary,
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: context.colors.secondary),
            onPressed: incrementTap,
          ),
        ],
      ),
    );
  }
}
