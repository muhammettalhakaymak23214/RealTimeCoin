import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/network/websocket_manager.dart';
import 'package:realtime_coin/core/utils/date_utils.dart';
import 'package:realtime_coin/features/home/service/home_service.dart';
import 'package:realtime_coin/features/home/view_model/home_view_model.dart';

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
            Text(
              "Sayfam",
              style: TextStyle(
                color: Color.fromRGBO(247, 147, 26, 1),
                fontSize: 25,
              ),
            ),
            Text(
              DateUtilsHelper.today(context),
              style: const TextStyle(
                color: Color.fromRGBO(247, 147, 26, 1),
                fontSize: 15,
              ),
            ),
          ],
        ),
        leading: Icon(Icons.menu, color: Color.fromRGBO(247, 147, 26, 1)),

        actions: [
          Icon(Icons.edit, color: Color.fromRGBO(247, 147, 26, 1)),
          SizedBox(width: 16),
          Icon(Icons.cabin, color: Color.fromRGBO(247, 147, 26, 1)),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 8, end: 8 , top: 8),
            child: Card(
            color: AppColors.secondary ,
              child: ListTile(
                leading: Text("Sembol", style: TextStyle(fontSize: 16, color: Color.fromRGBO(247, 147, 26, 1))),
                trailing: Container(
                  height: 50,
                  width: 270,
                //  color: Colors.blue,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 25,
                        width: 120,
                        child: Align(
                          child: Text("İşlem Hacmi", style: TextStyle(fontSize: 16, color: Color.fromRGBO(247, 147, 26, 1))),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 65,
                        child: Align(
                          child: Text(
                            "Değişim",
                            style: TextStyle(fontSize: 16, color: Color.fromRGBO(247, 147, 26, 1)),
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 65,
                        child: Align(
                          child: Text("Fiyat", style: TextStyle(fontSize: 16 , color: Color.fromRGBO(247, 147, 26, 1))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
            child: const Divider(height: 1, color: Color.fromRGBO(247, 147, 26, 1)),
          ),
          Expanded(
            child: Observer(
              builder: (context) {
                final keys = viewModel.prices.keys.toList();
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8);
                    },
                    itemCount: keys.length,
                    itemBuilder: (context, index) {
                      final symbol = keys[index];
                      final timestamp = viewModel.updateTimes[symbol];
                      final timeText = timestamp != null
                          ? DateTime.fromMillisecondsSinceEpoch(
                              timestamp,
                            ).toString().substring(11, 19)
                          : "--:--:--";

                      final changeValue = viewModel.changes[symbol] ?? "0.000";
                      final isNegative = changeValue.startsWith('-');

                      return Card(
                        color: Color.fromARGB(255, 247, 147, 26),
                        child: ListTile(
                          leading: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                symbol,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 36, 22, 54),
                                  fontSize: 16,
                                ),
                              ),

                              Text(
                                timeText,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 36, 22, 54),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),

                          trailing: Container(
                            // color: Colors.red,
                            height: 50,
                            width: 270,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 25,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color.fromARGB(255, 36, 22, 54),
                                    border: BoxBorder.all(
                                      width: 0.5,
                                      color: Color.fromARGB(255, 36, 22, 54),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentGeometry.center,
                                    child: Text(
                                      "${double.parse(viewModel.quoteVolumes[symbol] ?? "0").toStringAsFixed(0)} USDT",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 25,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    // Dinamik renk burada: Negatifse kırmızı, pozitifse yeşil
                                    color: isNegative
                                        ? Colors.red
                                        : Colors.green,
                                    border: Border.all(
                                      // BoxBorder değil, Border olacak
                                      width: 0.5,
                                      color: const Color.fromARGB(
                                        255,
                                        36,
                                        22,
                                        54,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "%${changeValue.length > 5 ? changeValue.substring(0, 5) : changeValue.padRight(5, '0')}",
                                      style: const TextStyle(
                                        fontSize:
                                            14, // 16 sığmayabilir, 14 daha güvenli
                                        fontFamily: 'monospace',
                                        color: Colors
                                            .white, // Arka plan renkli olduğu için yazı beyaz olmalı
                                      ),
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 25,
                                  width:
                                      65, // 8 karakter + padding için genişliği biraz artırdım
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    // Değişim negatifse kırmızı, değilse yeşil
                                    color: isNegative
                                        ? Colors.red
                                        : Colors.green,
                                    border: Border.all(
                                      width: 0.5,
                                      color: const Color.fromARGB(
                                        255,
                                        36,
                                        22,
                                        54,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      viewModel.prices[symbol] != null
                                          ? viewModel.prices[symbol]!.length > 8
                                                ? viewModel.prices[symbol]!
                                                      .substring(0, 8)
                                                : viewModel.prices[symbol]!
                                                      .padRight(8, '0')
                                          : "0.000000",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'monospace',
                                        fontSize:
                                            12, // 8 karakterin sığması için fontu hafif küçülttüm
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
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

  static const Color appBarBackgroundColor = AppColors.secondary;
}
