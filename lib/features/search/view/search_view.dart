import 'package:flutter/material.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _Constants.appBarBackgroundColor,
        centerTitle: true,
        title: Text("Ara" , style: TextStyle(color: Colors.amber),),
      ),
      body: Center(child: Text("Search View")),
    );
  }
}

@immutable
class _Constants {
  const _Constants._(); 
  
  static const Color appBarBackgroundColor = AppColors.secondary;

}
