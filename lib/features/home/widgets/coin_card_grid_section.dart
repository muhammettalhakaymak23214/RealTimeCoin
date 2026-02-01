import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import '../view_model/home_view_model.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';

class CoinCardGridSection extends StatelessWidget {
  final HomeViewModel viewModel;

  const CoinCardGridSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final keys = viewModel.prices.keys.toList();

        return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,          // Yan yana 2 kart
            crossAxisSpacing: 8,        // Yatay boşluk
            mainAxisSpacing: 8,         // Dikey boşluk
            childAspectRatio: 0.9,      // Kartın genişlik/yükseklik oranı
          ),
          itemCount: keys.length,
          itemBuilder: (context, index) {
            final symbol = keys[index];
            return _CoinGridCard(symbol: symbol, viewModel: viewModel);
          },
        );
      },
    );
  }
}

class _CoinGridCard extends StatelessWidget {
  final String symbol;
  final HomeViewModel viewModel;

  const _CoinGridCard({required this.symbol, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final timestamp = viewModel.updateTimes[symbol];
    final timeText = timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp).toString().substring(11, 19)
        : "--:--:--";

    final changeValue = viewModel.changes[symbol] ?? "0.000";
    final isNegative = changeValue.startsWith('-');
    final price = viewModel.prices[symbol] ?? "0.000000";
    final quoteVol = viewModel.quoteVolumes[symbol] ?? "0";

    return Card(
      margin: EdgeInsets.zero,
      color: _Constants.cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sembol ve Zaman
            Column(
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
            
            const Divider(color: _Constants.borderColor, thickness: 0.5),

            // Fiyat Kutusu
            _buildInfoContainer(
              width: double.infinity,
              color: isNegative 
                  ? _Constants.cardNegativeContainerColor 
                  : _Constants.cardPositiveContainerColor,
              child: AppText(
                text: price.length > 8 ? price.substring(0, 8) : price.padRight(8, '0'),
                style: AppTextStyle.labelL,
                color: _Constants.cardContainerTextColor,
              ),
            ),

            // Değişim Yüzdesi ve Hacim (Alt alta)
            Row(
              children: [
                Expanded(
                  child: _buildInfoContainer(
                    width: double.infinity,
                    color: isNegative ? Colors.red : Colors.green,
                    child: AppText(
                      text: "%${changeValue.length > 5 ? changeValue.substring(0, 5) : changeValue.padRight(5, '0')}",
                      style: AppTextStyle.labelS, // Grid olduğu için biraz daha küçük font
                      color: _Constants.cardContainerTextColor,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: _buildInfoContainer(
                    width: double.infinity,
                    color: AppColors.primary,
                    child: AppText(
                      text: "${(double.parse(quoteVol) / 1000).toStringAsFixed(1)}K",
                      style: AppTextStyle.labelS,
                      color: _Constants.cardContainerTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
      height: 30, // Grid'de biraz daha yüksek durması daha iyi okunurluk sağlar
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
        border: Border.all(width: 0.5, color: _Constants.borderColor),
      ),
      child: Center(child: child),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  static const Color cardNegativeContainerColor = AppColors.error;
  static const Color cardPositiveContainerColor = AppColors.success;
  static const Color cardTextColor = AppColors.primary;
  static const Color cardContainerTextColor = AppColors.textPrimary;
  static const Color cardBackgroundColor = AppColors.secondary;
  static const Color borderColor = AppColors.borderColor;
}