import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';

class TitleCardSection extends StatelessWidget {
  const TitleCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _Constants.cardBackgroundColor,
      child: ListTile(
        leading: AppText(
          text: "Sembol",
          color: _Constants.titleTextColor,
          style: AppTextStyle.titleM,
        ),
        trailing: Container(
          height: 50,
          width: 270,
          //  color: Colors.blue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 25,
                width: 120,
                child: Align(
                  child: AppText(
                    text: "İşlem Hacmi",
                    color: _Constants.titleTextColor,
                    style: AppTextStyle.titleM,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
                width: 65,
                child: Align(
                  child: AppText(
                    text: "Değişim",
                    color: _Constants.titleTextColor,
                    style: AppTextStyle.titleM,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
                width: 65,
                child: Align(
                  child: AppText(
                    text: "Fiyat",
                    color: _Constants.titleTextColor,
                    style: AppTextStyle.titleM,
                  ),
                ),
              ),
            ],
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
  static const Color titleTextColor = AppColors.primary;
  static const Color cardBackgroundColor = AppColors.secondary;
}
