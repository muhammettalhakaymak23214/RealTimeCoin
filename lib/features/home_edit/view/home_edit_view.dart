import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/services/cache/local_storage_service.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import 'package:realtime_coin/features/add_symbol/view/add_symbol_view.dart';

class HomeEditView extends StatefulWidget {
  const HomeEditView({super.key});

  @override
  State<HomeEditView> createState() => _HomeEditViewState();
}

class _HomeEditViewState extends State<HomeEditView> {

  List<String> symbols = [];

  @override
  void initState() {
    super.initState();
  
    _loadSymbols();
  }

  void _loadSymbols() {
    setState(() {
      symbols = LocalStorageService.instance.getSelectedSymbols();
    });
  }

  void _removeSymbol(String symbol) async {
    await LocalStorageService.instance.deleteSymbol(symbol);
    _loadSymbols(); // Listeyi güncelle
  }

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddSymbolView(),
                  ),
                );
              },
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
                color: AppColors.textPrimary,
                style: AppTextStyle.titleL,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ListView.separated(
      
          itemCount: symbols.length,

          itemBuilder: (context, index) {
       
            final String currentSymbol = symbols[index];

            return Card(
              borderOnForeground: true,
              color: AppColors.secondary,
              child: ListTile(
                leading: Container(
                  width: 130,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 12.5,
                        width: 12.5,
                        decoration: BoxDecoration(
                          color: AppColors.scaffoldBg,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      const SizedBox(width: 17),
                      Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1.5,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        child: Center(
                          child: AppText(
                       
                            text: currentSymbol,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w900,
                            style: AppTextStyle.titleM,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: GestureDetector(
                  onTap: ()  {
                    _removeSymbol(currentSymbol);
                  },
                  child: Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.remove, color: AppColors.error, size: 20),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 4),
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
