import 'package:smiling_earth_frontend/models/user.dart';

class Post {
  final PostDto postDto;
  final UserProfileDto owner;

  Post(this.postDto, this.owner);
}

class PostDto {
  final int id;
  final UserProfileDto user;
  final String content;
  final String timestamp;
  final int likes_count;
  final int comments_count;

  PostDto({
    required this.likes_count,
    required this.comments_count,
    required this.id,
    required this.user,
    required this.content,
    required this.timestamp,
  });

  // Map<String, dynamic> toJson() => {"id": this.id, 'user': this.user.id,};

  factory PostDto.fromJson(Map<String, dynamic> json) => new PostDto(
      id: json['id'],
      user: UserProfileDto.fromJson(json['user']),
      content: json['content'],
      timestamp: json['timestamp'],
      likes_count: json['likes_count'],
      comments_count: json['comments_count']);
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
      comments_count: comments.length,
      content: content,
      id: id,
      likes_count: likes.length,
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
