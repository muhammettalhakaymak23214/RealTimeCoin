import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/services/navigation/navigation_service.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import 'package:realtime_coin/features/add_symbol/view/add_symbol_view.dart';
import 'package:realtime_coin/features/home_edit/view_model/home_edit_view_model.dart';
import 'package:realtime_coin/features/home_edit/widgets/symbol_card.dart';

class HomeEditView extends StatefulWidget {
  const HomeEditView({super.key});

  @override
  State<HomeEditView> createState() => _HomeEditViewState();
}

class _HomeEditViewState extends State<HomeEditView> {
  late final HomeEditViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeEditViewModel();
    _viewModel.loadSymbols();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      bottomNavigationBar: _bottomNavigatorBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Observer(
          builder: (_) => ListView.separated(
            itemCount: _viewModel.symbols.length,
            itemBuilder: (context, index) {
              final String currentSymbol = _viewModel.symbols[index];
              return SymbolCard(
                symbol: currentSymbol,
                onRemove: () => _viewModel.removeSymbol(currentSymbol),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 4),
          ),
        ),
      ),
    );
  }

  Padding _bottomNavigatorBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Container(
        height: 80,
        color: _Constants.bottomNavigatorBarBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () async {
              await NavigationService.instance.navigateToPage(
                page: const AddSymbolView(),
              );
              _viewModel.loadSymbols();
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: _Constants.bottomNavigatorBarButtonColor,
              side: const BorderSide(
                color: _Constants.bottomNavigatorBarButtonColor,
                width: 0.5,
              ),
              minimumSize: const Size(double.infinity, double.infinity),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: AppText(
              text: "Sembol Ekle",
              color: _Constants.bottomNavigatorBarTextColor,
              style: AppTextStyle.titleL,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: _Constants.appBarBackgroundColor,
      centerTitle: true,
      iconTheme: const IconThemeData(color: _Constants.appBarIconsColor),
      title: AppText(
        text: "Sayfamı Düzenle",
        color: _Constants.appBarTitleTextColor,
        style: AppTextStyle.h2,
      ),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  // Color
  static const Color appBarTitleTextColor = AppColors.primary;
  static const Color appBarIconsColor = AppColors.primary;
  static const Color appBarBackgroundColor = AppColors.secondary;
  static const Color bottomNavigatorBarTextColor = AppColors.textPrimary;
  static const Color bottomNavigatorBarBackgroundColor = AppColors.secondary;
  static const Color bottomNavigatorBarButtonColor = AppColors.primary;
}
