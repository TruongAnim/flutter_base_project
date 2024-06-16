import 'dart:convert';

import 'package:collection/collection.dart';

import 'base_model.dart';
import 'user_model.dart';

class PostModel extends BaseModel {
  UserModel? user;
  List<String>? comments;
  List<String>? upVotes;
  List<String>? favourites;
  List<String>? tags;
  String? title;
  String? type;
  String? mediaLink;
  double? mediaAspectRatio;
  String? createdAt;
  PostModel({
    super.id,
    this.user,
    this.comments,
    this.upVotes,
    this.favourites,
    this.tags,
    this.title,
    this.type,
    this.mediaLink,
    this.mediaAspectRatio,
    this.createdAt,
  });

  PostModel copyWith({
    String? id,
    UserModel? user,
    List<String>? comments,
    List<String>? upVotes,
    List<String>? favourites,
    List<String>? tags,
    String? title,
    String? type,
    String? mediaLink,
    double? mediaAspectRatio,
    String? createdAt,
  }) {
    return PostModel(
      id: id ?? this.id,
      user: user ?? this.user,
      comments: comments ?? this.comments,
      upVotes: upVotes ?? this.upVotes,
      favourites: favourites ?? this.favourites,
      tags: tags ?? this.tags,
      title: title ?? this.title,
      type: type ?? this.type,
      mediaLink: mediaLink ?? this.mediaLink,
      mediaAspectRatio: mediaAspectRatio ?? this.mediaAspectRatio,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user?.toMap(),
      'comments': comments,
      'upVotes': upVotes,
      'favourites': favourites,
      'tags': tags,
      'title': title,
      'type': type,
      'mediaLink': mediaLink,
      'mediaAspectRatio': mediaAspectRatio,
      'createdAt': createdAt,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['_id'] != null ? map['_id'] as String : null,
      user: map['userId'] is String
          ? UserModel(id: map['userId'])
          : UserModel.fromMap(map['userId'] as Map<String, dynamic>),
      comments: map['comments'] != null
          ? List<String>.from(map['comments'] as List<dynamic>)
          : null,
      upVotes: map['upVotes'] != null
          ? List<String>.from(map['upVotes'] as List<dynamic>)
          : null,
      favourites: map['favourites'] != null
          ? List<String>.from(map['favourites'] as List<dynamic>)
          : null,
      tags: map['tags'] != null
          ? List<String>.from(map['tags'] as List<dynamic>)
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      mediaLink: map['mediaLink'] != null ? map['mediaLink'] as String : null,
      mediaAspectRatio: map['mediaAspectRatio'] != null
          ? map['mediaAspectRatio'] as double
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) =>
      PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostModel(id: $id, user: $user, comments: $comments, upVotes: $upVotes, favourites: $favourites, tags: $tags, title: $title, type: $type, mediaLink: $mediaLink, mediaAspectRatio: $mediaAspectRatio, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.user == user &&
        listEquals(other.comments, comments) &&
        listEquals(other.upVotes, upVotes) &&
        listEquals(other.favourites, favourites) &&
        listEquals(other.tags, tags) &&
        other.title == title &&
        other.type == type &&
        other.mediaLink == mediaLink &&
        other.mediaAspectRatio == mediaAspectRatio &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        user.hashCode ^
        comments.hashCode ^
        upVotes.hashCode ^
        favourites.hashCode ^
        tags.hashCode ^
        title.hashCode ^
        type.hashCode ^
        mediaLink.hashCode ^
        mediaAspectRatio.hashCode ^
        createdAt.hashCode;
  }
}
