import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';

class HomeEditView extends StatefulWidget {
  const HomeEditView({super.key});

  @override
  State<HomeEditView> createState() => _HomeEditViewState();
}

class _HomeEditViewState extends State<HomeEditView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _Constants.appBarBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        title: AppText(
          text: "Sayfamı Düzenle",
          color: _Constants.titleTextColor,
          style: AppTextStyle.h2,
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: Container(
          height: 80,
          color: AppColors.secondary,

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.primary,
                side: BorderSide(color: AppColors.scaffoldBg, width: 0.5),
                minimumSize: Size(double.infinity, double.infinity),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: AppText(
                text: "Sembol Ekle",
                color: AppColors.secondary,
                style: AppTextStyle.titleM,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              color: AppColors.cardBg,
              child: ListTile(
                leading: AppText(
                  text: "AGBCGH",
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w900,
                  style: AppTextStyle.titleM,
                ),
                trailing: Icon(Icons.remove),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 4 );
          },
          itemCount: 10,
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
  static const Color textColor = AppColors.textPrimary;
  static const Color dividerColor = AppColors.primary;
  static const Color appBarBackgroundColor = AppColors.secondary;
}
