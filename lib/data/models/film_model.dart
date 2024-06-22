import 'dart:convert';

import 'episode_model.dart';
import 'base_model.dart';

class FilmModel extends BaseModel {
  int? filmId;
  String? title;
  String? thumb;
  String? description;
  int? episodeCurrent;
  int? episodeTotal;
  int? isFollow;
  EpisodeModel? episode;
  FilmModel({
    this.filmId,
    this.title,
    this.thumb,
    this.description,
    this.episodeCurrent,
    this.episodeTotal,
    this.isFollow,
    this.episode,
  });

  FilmModel copyWith({
    String? title,
    String? thumb,
    String? description,
    int? episodeCurrent,
    int? episodeTotal,
    int? isFollow,
    EpisodeModel? episode,
  }) {
    return FilmModel(
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
      description: description ?? this.description,
      episodeCurrent: episodeCurrent ?? this.episodeCurrent,
      episodeTotal: episodeTotal ?? this.episodeTotal,
      isFollow: isFollow ?? this.isFollow,
      episode: episode ?? this.episode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filmId': filmId,
      'title': title,
      'thumb': thumb,
      'description': description,
      'episode_current': episodeCurrent,
      'episode_total': episodeTotal,
      'is_follow': isFollow,
      'episode': episode?.toMap(),
    };
  }

  factory FilmModel.fromMap(Map<String, dynamic> map) {
    return FilmModel(
      filmId: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      thumb: map['thumb'] != null ? map['thumb'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      episodeCurrent:
          map['episode_current'] != null ? map['episode_current'] as int : null,
      episodeTotal:
          map['episode_total'] != null ? map['episode_total'] as int : null,
      isFollow: map['is_follow'] != null ? map['is_follow'] as int : null,
      episode: map['episode'] != null
          ? EpisodeModel.fromMap(map['episode'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilmModel.fromJson(String source) =>
      FilmModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FilmModel(title: $title, thumb: $thumb, description: $description, episodeCurrent: $episodeCurrent, episodeTotal: $episodeTotal, isFollow: $isFollow, episode: $episode)';
  }

  @override
  bool operator ==(covariant FilmModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.thumb == thumb &&
        other.description == description &&
        other.episodeCurrent == episodeCurrent &&
        other.episodeTotal == episodeTotal &&
        other.isFollow == isFollow &&
        other.episode == episode;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        thumb.hashCode ^
        description.hashCode ^
        episodeCurrent.hashCode ^
        episodeTotal.hashCode ^
        isFollow.hashCode ^
        episode.hashCode;
  }
}
