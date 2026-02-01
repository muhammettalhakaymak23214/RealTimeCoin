import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';

class AddSymbolCard extends StatelessWidget {
  final String symbol;
  final VoidCallback onAdd;

  const AddSymbolCard({
    super.key,
    required this.symbol,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _Constants.cardBackgroundColor,
      child: ListTile(
        title: AppText(
          text: symbol,
          color: _Constants.cardTextColor,
          style: AppTextStyle.titleM,
          fontWeight: FontWeight.w900,
        ),
        trailing: InkWell(
          onTap: onAdd,
          child: Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: _Constants.cardAddButtonColor),
              color: _Constants.cardAddButtonColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.textPrimary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  static const Color cardBackgroundColor = AppColors.secondary;
  static const Color cardTextColor = AppColors.primary;
  static const Color cardAddButtonColor = AppColors.success;
}