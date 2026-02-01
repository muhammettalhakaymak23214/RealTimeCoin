import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/network/binance_websocket_manager.dart';
import 'package:realtime_coin/core/utils/date_utils.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import 'package:realtime_coin/features/home/service/home_service.dart';
import 'package:realtime_coin/features/home/view_model/home_view_model.dart';
import 'package:realtime_coin/features/home/widgets/coin_card_grid_section.dart';
import 'package:realtime_coin/features/home/widgets/coin_card_list_section.dart';
import 'package:realtime_coin/features/home/widgets/title_card_section.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(HomeService(WebSocketManager()));
    viewModel.startStreaming();
  }

  @override
  void dispose() {
    viewModel.stopStreaming();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _Constants.appBarBackgroundColor,
        centerTitle: true,
        actionsPadding: EdgeInsetsDirectional.only(end: 16),
        title: Column(
          children: [
            AppText(
              text: "Sayfam",
              color: _Constants.titleTextColor,
              style: AppTextStyle.h2,
            ),
            AppText(
              text: DateUtilsHelper.today(context),
              color: _Constants.titleTextColor,
              style: AppTextStyle.titleS,
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu, color: _Constants.iconColor),
        ),
        actions: [
          IconButton(
            onPressed: () => viewModel.navigateToEditAndRefresh(),
            style: IconButton.styleFrom(
              overlayColor: Colors.orange.withValues(alpha: 0.2),
            ),
            icon: const Icon(Icons.edit, color: _Constants.iconColor),
          ),
          Observer(
            builder: (context) {
              return IconButton(
                onPressed: () => viewModel.toggleView(),
                icon: Icon(
                  viewModel.isGridView ? Icons.view_list : Icons.grid_view,
                  color: _Constants.iconColor,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 8, top: 8),
            child: TitleCardSection(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Divider(height: 1.5, color: _Constants.dividerColor),
          ),
          Expanded(
            child: Observer(
              builder: (_) {
                return viewModel.isGridView
                    ? CoinCardGridSection(viewModel: viewModel)
                    : CoinCardListSection(viewModel: viewModel);
              },
            ),
          ),
        ],
      ),
    );
  }
}

@immutable
class _Constants {
  const _Constants._();

  // Colors
  static const Color iconColor = AppColors.primary;
  static const Color titleTextColor = AppColors.primary;
  static const Color dividerColor = AppColors.secondary;
  static const Color appBarBackgroundColor = AppColors.secondary;
}
