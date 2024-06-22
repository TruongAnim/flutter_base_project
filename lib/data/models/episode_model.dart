import 'dart:convert';

import 'base_model.dart';

class EpisodeModel extends BaseModel {
  int? episodeId;
  int? episode;
  String? title;
  String? link;
  int? isVip;
  int? price;
  int? filmId;
  int? isLike;
  EpisodeModel({
    this.episodeId,
    this.episode,
    this.title,
    this.link,
    this.isVip,
    this.price,
    this.filmId,
    this.isLike,
  });

  EpisodeModel copyWith({
    int? episode,
    String? title,
    String? link,
    int? isVip,
    int? price,
    int? filmId,
    int? isLike,
  }) {
    return EpisodeModel(
      episode: episode ?? this.episode,
      title: title ?? this.title,
      link: link ?? this.link,
      isVip: isVip ?? this.isVip,
      price: price ?? this.price,
      filmId: filmId ?? this.filmId,
      isLike: isLike ?? this.isLike,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'episode_id': episodeId,
      'episode': episode,
      'title': title,
      'link': link,
      'is_vip': isVip,
      'price': price,
      'film_id': filmId,
      'is_like': isLike,
    };
  }

  factory EpisodeModel.fromMap(Map<String, dynamic> map) {
    return EpisodeModel(
      episodeId: map['episode_id'] != null ? map['episode_id'] as int : null,
      episode: map['episode'] != null ? map['episode'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      isVip: map['is_vip'] != null ? map['is_vip'] as int : null,
      price: map['price'] != null ? map['price'] as int : null,
      filmId: map['film_id'] != null ? map['film_id'] as int : null,
      isLike: map['is_like'] != null ? map['is_like'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeModel.fromJson(String source) =>
      EpisodeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EpisodeModel(episode: $episode, title: $title, link: $link, isVip: $isVip, price: $price, filmId: $filmId, isLike: $isLike)';
  }

  @override
  bool operator ==(covariant EpisodeModel other) {
    if (identical(this, other)) return true;

    return other.episode == episode &&
        other.title == title &&
        other.link == link &&
        other.isVip == isVip &&
        other.price == price &&
        other.filmId == filmId &&
        other.isLike == isLike;
  }

  @override
  int get hashCode {
    return episode.hashCode ^
        title.hashCode ^
        link.hashCode ^
        isVip.hashCode ^
        price.hashCode ^
        filmId.hashCode ^
        isLike.hashCode;
  }
}
