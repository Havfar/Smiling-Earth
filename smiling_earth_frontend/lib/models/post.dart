import 'package:smiling_earth_frontend/models/Activity.dart';
import 'package:smiling_earth_frontend/models/user.dart';

class Post {
  final PostDto postDto;
  final UserProfileDto owner;

  Post(this.postDto, this.owner);
}

class PostDto {
  final int id;
  final UserProfileDto? user;
  final String content;
  final String timestamp;
  final int likesCount;
  final int commentsCount;
  final ActivityDto? activity;

  PostDto(
      {required this.likesCount,
      required this.commentsCount,
      required this.id,
      this.user,
      required this.content,
      required this.timestamp,
      this.activity});

  Map<String, dynamic> toJson() => {"content": this.content};

  factory PostDto.fromJson(Map<String, dynamic> json) => new PostDto(
      id: json['id'],
      user: UserProfileDto.fromJson(json['user']),
      content: json['content'],
      timestamp: json['timestamp'],
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      activity: json['activity'] != null
          ? ActivityDto.fromJson(json['activity'])
          : null);
}

class DetailedPostDto {
  final int id;
  final UserProfileDto user;
  final String content;
  final String timestamp;
  final List<LikeDto> likes;
  final List<CommentDto> comments;

  DetailedPostDto({
    required this.likes,
    required this.comments,
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
  });

  List<LikeDto> toLikesList(Map<String, dynamic> json) {
    List<LikeDto> likes = [];

    return likes;
  }

  PostDto toPostDto() {
    return PostDto(
      commentsCount: comments.length,
      content: content,
      id: id,
      likesCount: likes.length,
      timestamp: timestamp,
      user: user,
    );
  }

  factory DetailedPostDto.fromJson(Map<String, dynamic> json) {
    return new DetailedPostDto(
      id: json['id'],
      user: UserProfileDto.fromJson(json['user']),
      content: json['content'],
      timestamp: json['timestamp'],
      likes: json['likes'].length != 0
          ? json['likes']
              .map((like) => LikeDto.fromJson(like))
              .toList()
              .cast<LikeDto>()
          : [],
      comments: json['comments'].length != 0
          ? json['comments']
              .map((comment) => CommentDto.fromJson(comment))
              .toList()
              .cast<CommentDto>()
          : [],
    );
  }
}

class LikeDto {
  final int? id;
  final UserProfileDto? user;
  final PostDto? post;
  // final String timestamp;

  LikeDto({
    this.id,
    this.user,
    this.post,
    // required this.timestamp,
  });

  factory LikeDto.fromJson(Map<String, dynamic> json) => new LikeDto(
        id: json['id'],
        user: UserProfileDto.fromJson(json['user']),
        // post: PostDto.fromJson(json['post']),
        // timestamp: json['timestamp']
      );

  factory LikeDto.fromJsonBasic(Map<String, dynamic> json) => new LikeDto(
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {"post": this.post!.id.toString()};
}

class CommentDto {
  final int? id;
  final UserProfileDto? user;
  final PostDto? post;
  // final String timestamp;
  final String comment;

  CommentDto(
      {this.id,
      this.user,
      this.post,
      // required this.timestamp,
      required this.comment});

  factory CommentDto.fromJson(Map<String, dynamic> json) => new CommentDto(
      id: json['id'],
      user: UserProfileDto.fromJson(json['user']),
      // post: json['post'],
      // timestamp: json['timestamp'],
      comment: json['content']);

  Map<String, dynamic> toJson() =>
      {"post": this.post!.id.toString(), 'content': this.comment};
}