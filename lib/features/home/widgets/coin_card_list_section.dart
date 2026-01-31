import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import '../view_model/home_view_model.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';

class CoinCardListSection extends StatelessWidget {
  final HomeViewModel viewModel;

  const CoinCardListSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final keys = viewModel.prices.keys.toList();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final symbol = keys[index];
              return _CoinCard(symbol: symbol, viewModel: viewModel);
            },
          ),
        );
      },
    );
  }
}

class _CoinCard extends StatelessWidget {
  final String symbol;
  final HomeViewModel viewModel;

  const _CoinCard({required this.symbol, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final timestamp = viewModel.updateTimes[symbol];
    final timeText = timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(
            timestamp,
          ).toString().substring(11, 19)
        : "--:--:--";

    final changeValue = viewModel.changes[symbol] ?? "0.000";
    final isNegative = changeValue.startsWith('-');
    final price = viewModel.prices[symbol] ?? "0.000000";
    final quoteVol = viewModel.quoteVolumes[symbol] ?? "0";

    return Card(
      color: _Constants.cardBackgroundColor,
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: symbol,
              style: AppTextStyle.labelL,
              color: _Constants.cardTextColor,
            ),
            AppText(
              text: timeText,
              style: AppTextStyle.labelM,
              color: _Constants.cardTextColor,
            ),
          ],
        ),
        trailing: SizedBox(
          height: 50,
          width: 270,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoContainer(
                width: 120,
                color: AppColors.primary,
                child: AppText(
                  text: "${double.parse(quoteVol).toStringAsFixed(0)} USDT",
                  style: AppTextStyle.labelL,
                  color: _Constants.cardContainerTextColor,
                ),
              ),
              _buildInfoContainer(
                width: 65,
                color: isNegative ? Colors.red : Colors.green,
                child: AppText(
                  text:
                      "%${changeValue.length > 5 ? changeValue.substring(0, 5) : changeValue.padRight(5, '0')}",
                  style: AppTextStyle.labelL,
                  color: _Constants.cardContainerTextColor,
                ),
              ),

              _buildInfoContainer(
                width: 65,
                color: isNegative
                    ? _Constants.cardNegativeContainerColor
                    : _Constants.cardPositiveContainerColor,
                child: AppText(
                  text: price.length > 8
                      ? price.substring(0, 8)
                      : price.padRight(8, '0'),
                  style: AppTextStyle.labelL,
                  color: _Constants.cardContainerTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoContainer({
    required double width,
    required Color color,
    required Widget child,
  }) {
    return Container(
      height: 25,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
        border: Border.all(
          width: 0.5,
          color: _Constants.borderColor,
        ),
      ),
      child: Center(child: child),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  // Colors
  static const Color cardNegativeContainerColor = AppColors.error;
  static const Color cardPositiveContainerColor = AppColors.success;
  static const Color cardTextColor = AppColors.primary;
  static const Color cardContainerTextColor = AppColors.textPrimary;
  static const Color cardBackgroundColor = AppColors.secondary;
  static const Color borderColor = AppColors.borderColor;
}
