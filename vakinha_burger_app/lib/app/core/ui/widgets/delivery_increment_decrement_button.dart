import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/text_style.dart';

class DeliveryIncrementDecrementButton extends StatelessWidget {
  final bool _compact;
  final int amount;
  final VoidCallback incrementTap;
  final VoidCallback decrementTap;

  const DeliveryIncrementDecrementButton({
    super.key,
    required this.amount,
    required this.incrementTap,
    required this.decrementTap,
  }) : _compact = false;

  const DeliveryIncrementDecrementButton.compact({
    super.key,
    required this.amount,
    required this.incrementTap,
    required this.decrementTap,
  }) : _compact = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _compact ? const EdgeInsets.all(3) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: context.colors.secondary,
              size: _compact ? 15 : 25,
            ),
            onPressed: decrementTap,
          ),
          Padding(
            padding: _compact ? const EdgeInsets.symmetric(horizontal: 10) : const EdgeInsets.all(0),
            child: Text(
              amount.toString(),
              style: context.textStyles.textRegular.copyWith(
                fontSize: _compact ? 18 : 25,
                color: context.colors.secondary,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: context.colors.secondary,
              size: _compact ? 15 : 25,
            ),
            onPressed: incrementTap,
          ),
        ],
      ),
    );
  }
}
