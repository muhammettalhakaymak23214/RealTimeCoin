class NewsModel {
  final String title;
  final String body;
  final String url;
  final String imageUrl;
  final String sourceName;
  final int publishedOn;

  NewsModel({
    required this.title,
    required this.body,
    required this.url,
    required this.imageUrl,
    required this.sourceName,
    required this.publishedOn,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
   
    final sourceData = json['SOURCE_DATA'] as Map<String, dynamic>?;
    final String extractedSource =
        sourceData?['NAME']?.toString() ??
        sourceData?['name']?.toString() ??
        'Coin Desk';

    final String extractedImage =
        json['IMAGE_URL']?.toString() ?? json['imageurl']?.toString() ?? '';

    return NewsModel(
      title:
          json['TITLE']?.toString() ?? json['title']?.toString() ?? 'Başlıksız',
      body:
          json['BODY']?.toString() ??
          json['body']?.toString() ??
          'İçerik bulunamadı.',
      url: json['URL']?.toString() ?? json['url']?.toString() ?? '',
      imageUrl: extractedImage,
      sourceName: extractedSource,
      publishedOn: json['PUBLISHED_ON'] as int? ?? 0,
    );
  }
}
