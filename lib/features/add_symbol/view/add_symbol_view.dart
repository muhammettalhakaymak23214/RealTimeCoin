import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/services/cache/local_storage_service.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import 'package:realtime_coin/features/add_symbol/service/binance_service.dart';

class AddSymbolView extends StatefulWidget {
  const AddSymbolView({super.key});

  @override
  State<AddSymbolView> createState() => _AddSymbolViewState();
}

class _AddSymbolViewState extends State<AddSymbolView> {
  final BinanceService _service = BinanceService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _Constants.appBarBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        title: AppText(
          text: "Sembol Ekle",
          color: _Constants.titleTextColor,
          style: AppTextStyle.h2,
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search symbols (e.g. BTC, ETH)",
                prefixIcon: const Icon(Icons.search),
                filled: true,

                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide
                      .none, // Kenarlıkları kaldırıp modern görünüm sağla
                ),
              ),
              onChanged: (value) {
                // Arama algoritmanı buraya gelecek
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: _service.fetchSymbols(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else {
            final symbols = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: symbols.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: AppColors.cardBg,
                    child: ListTile(
                      title: AppText(
                        text: symbols[index],
                        color: AppColors.secondary,
                        style: AppTextStyle.titleM,
                        fontWeight: FontWeight.w900,
                      ),
                      trailing: InkWell(
                        onTap: () {
                          //////////
                          LocalStorageService.instance.saveSymbol(symbols[index]);
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1 , color: AppColors.secondary),
                            color: AppColors.error,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(Icons.add , color: AppColors.textPrimary,),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
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
  static const Color appBarBackgroundColor = AppColors.secondary;
}
