class GameModel {
  final String id;
  final String title;
  final String iconUrl;
  final String logoUrl;
  final String backgroundUrl;
  final String shortDescription;
  final String developer;
  final String publisher;
  final String releaseDate;
  final List<dynamic> gameModes;
  final List<dynamic> genres;
  final List<dynamic> keywords;
  final List<dynamic> screenshots;
  final List<dynamic> videos;

  GameModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json["product"]["title"],
        iconUrl = json["product"]["productDetail"]["iconUrl"],
        logoUrl = json["product"]["productDetail"]["details"]["logoUrl"],
        backgroundUrl =
            json["product"]["productDetail"]["details"]["backgroundUrl2"],
        shortDescription =
            json["product"]["productDetail"]["details"]["shortDescription"],
        developer = json["product"]["productDetail"]["details"]["developer"],
        publisher = json["product"]["productDetail"]["details"]["publisher"],
        releaseDate =
            json["product"]["productDetail"]["details"]["releaseDate"],
        gameModes = json["product"]["productDetail"]["details"]["gameModes"],
        genres = json["product"]["productDetail"]["details"]["genres"],
        keywords = json["product"]["productDetail"]["details"]["keywords"],
        screenshots =
            json["product"]["productDetail"]["details"]["screenshots"],
        videos = json["product"]["productDetail"]["details"]["videos"];
}
