import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';

class SymbolCard extends StatelessWidget {
  final String symbol;
  final VoidCallback onRemove;

  const SymbolCard({super.key, required this.symbol, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: _Constants.cardBackgroundColor,
      child: ListTile(
        leading: SizedBox(
          width: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 12.5,
                width: 12.5,
                decoration: BoxDecoration(
                  color: _Constants.cardPointColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              const SizedBox(width: 17),
              Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: _Constants.cardContainerColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1.5,
                    color: _Constants.cardContainerColor,
                  ),
                ),
                child: Center(
                  child: AppText(
                    text: symbol,
                    color: _Constants.cardTextColor,
                    fontWeight: FontWeight.w900,
                    style: AppTextStyle.titleM,
                  ),
                ),
              ),
            ],
          ),
        ),
        trailing: GestureDetector(
          onTap: onRemove,
          child: Container(
            height: 25,
            width: 25,
            decoration: _Constants.boxDecoration,
            child: const Icon(Icons.remove, color: _Constants.cardRemoveIconColor, size: 20),
          ),
        ),
      ),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  // Colors
  static const Color cardBackgroundColor = AppColors.secondary;
  static const Color cardPointColor = AppColors.scaffoldBg;
  static const Color cardContainerColor = AppColors.primary;
  static const Color cardTextColor = AppColors.textPrimary;
  static const Color cardRemoveIconColor = AppColors.error;

  // Decoration
  static BoxDecoration boxDecoration = BoxDecoration(
    color: AppColors.textPrimary,
    border: Border.all(color: AppColors.textPrimary, width: 1.5),
    borderRadius: BorderRadius.circular(50),
  );


}
