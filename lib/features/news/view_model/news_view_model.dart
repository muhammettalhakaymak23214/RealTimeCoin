import 'package:mobx/mobx.dart';
import 'package:realtime_coin/core/services/news_service.dart';
import 'package:realtime_coin/features/news/model/news_model.dart';

class NewsViewModel {
  final NewsService _service = NewsService();

  final ObservableList<NewsModel> newsList = ObservableList<NewsModel>();
  final Observable<bool> isLoading = Observable(false);
  final Observable<String?> errorMessage = Observable(null);

  Future<void> fetchNews() async {
    if (isLoading.value) return;

    runInAction(() {
      isLoading.value = true;
      errorMessage.value = null;
    });

    try {
      final news = await _service.fetchNews();
      
      runInAction(() {
        newsList.clear();
       
        news.sort((a, b) => b.publishedOn.compareTo(a.publishedOn));
        newsList.addAll(news);
      });
    } catch (e) {
      runInAction(() {
        errorMessage.value = "Haberler yüklenirken bir sorun oluştu.";
      });
    } finally {
      runInAction(() {
        isLoading.value = false;
      });
    }
  }

  Future<void> refreshNews() async {
    await fetchNews();
  }
}