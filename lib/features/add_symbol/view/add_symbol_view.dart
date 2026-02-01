import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart'; 
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/services/cache/local_storage_service.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import 'package:realtime_coin/features/add_symbol/view_model/add_symbol_view_model.dart'; 
import 'package:realtime_coin/features/add_symbol/widgets/add_symbol_card.dart';

class AddSymbolView extends StatefulWidget {
  const AddSymbolView({super.key});

  @override
  State<AddSymbolView> createState() => _AddSymbolViewState();
}

class _AddSymbolViewState extends State<AddSymbolView> {
  late final AddSymbolViewModel _viewModel; 

  @override
  void initState() {
    super.initState();
    _viewModel = AddSymbolViewModel();
    _viewModel.fetchAllSymbols();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _Constants.appBarBackgroundColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: _Constants.appBarIconsColor),
        title: AppText(
          text: "Sembol Ekle",
          color: _Constants.appBarTextColor,
          style: AppTextStyle.h2,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              style: const TextStyle(color: AppColors.textPrimary),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: "Sembol ara (ör: BTC, ETH)",
                hintStyle: TextStyle(
                  color: AppColors.textPrimary.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                filled: true,
                fillColor: AppColors.scaffoldBg,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _viewModel.filterSymbols, 
            ),
          ),
        ),
      ),
      body: Observer( 
        builder: (_) {
          if (_viewModel.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: _viewModel.filteredSymbols.length,
              itemBuilder: (context, index) {
                final String currentSymbol = _viewModel.filteredSymbols[index];
                return AddSymbolCard(
                  symbol: currentSymbol,
                  onAdd: () {
                    LocalStorageService.instance.saveSymbol(currentSymbol);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();
  static const Color appBarTextColor = AppColors.primary;
  static const Color appBarIconsColor = AppColors.primary;
  static const Color appBarBackgroundColor = AppColors.secondary;
}