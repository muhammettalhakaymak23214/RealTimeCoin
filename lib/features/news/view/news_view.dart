import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:realtime_coin/core/constants/app_colors.dart';
import 'package:realtime_coin/core/widgets/app_text.dart';
import 'package:realtime_coin/features/news/view_model/news_view_model.dart';
import 'package:realtime_coin/features/news/model/news_model.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final NewsViewModel _viewModel = NewsViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const AppText(
          text: "Kripto Haberleri",
          color: AppColors.primary,
          style: AppTextStyle.h2,
        ),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          if (_viewModel.isLoading.value && _viewModel.newsList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (_viewModel.errorMessage.value != null && _viewModel.newsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(text: _viewModel.errorMessage.value!, color: Colors.white),
                  TextButton(onPressed: _viewModel.fetchNews, child: const Text("Tekrar Dene")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _viewModel.refreshNews,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _viewModel.newsList.length,
              itemBuilder: (context, index) {
                return _NewsCard(news: _viewModel.newsList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class _NewsCard extends StatefulWidget {
  final NewsModel news;
  const _NewsCard({required this.news});

  @override
  State<_NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<_NewsCard> {
  bool _isExpanded = false;

  Future<void> _openNews() async {
    if (widget.news.url.isEmpty) return;
    final Uri url = Uri.parse(widget.news.url);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Haber linki açılamadı.")),
        );
      }
    }
  }

  void _shareNews() {
    Share.share("${widget.news.title}\n\nDetaylar: ${widget.news.url}");
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: _openNews,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2.0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  widget.news.imageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: AppColors.scaffoldBg,
                    child: const Icon(Icons.broken_image, color: AppColors.primary),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: widget.news.title,
                    color: AppColors.primary,
                    style: AppTextStyle.titleM,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    text: _isExpanded 
                        ? widget.news.body 
                        : (widget.news.body.length > 100 
                            ? "${widget.news.body.substring(0, 100)}..." 
                            : widget.news.body),
                    color: AppColors.textPrimary,
                    style: AppTextStyle.bodyS,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => setState(() => _isExpanded = !_isExpanded),
                        icon: Icon(
                          _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: Colors.yellow,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _shareNews,
                            icon: const Icon(Icons.share, color: Colors.yellow, size: 20),
                          ),
                          AppText(
                            text: widget.news.sourceName,
                            color: AppColors.primary,
                            style: AppTextStyle.bodyS,
                            fontWeight: FontWeight.w900,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}