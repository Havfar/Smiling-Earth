import 'package:smiling_earth_frontend/models/avatar.dart';

class UserProfileDto {
  final String firstName;
  final String lastName;
  final int userId;
  final Avatar avatar;

  UserProfileDto(
      {required this.firstName,
      required this.lastName,
      required this.userId,
      required this.avatar});

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return new UserProfileDto(
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        avatar: Avatar.fromJson(json['avatar']));
  }

  String getName() {
    return firstName + " " + lastName;
  }
}

class MyProfileDetailedDto {
  final int? userId;
  final String firstName;
  final String lastName;
  final int followerCount;
  final int followingCount;
  final String bio;
  final Avatar avatar;

  MyProfileDetailedDto(
      {this.userId,
      required this.firstName,
      required this.lastName,
      required this.followerCount,
      required this.followingCount,
      required this.bio,
      required this.avatar});

  factory MyProfileDetailedDto.fromJson(Map<String, dynamic> json) {
    return new MyProfileDetailedDto(
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        followerCount: json['followers_count'],
        followingCount: json['followingCount'],
        bio: json['bio'],
        avatar: Avatar.fromJson(json['avatar']));
  }

  String getName() {
    return firstName + " " + lastName;
  }
}

class UserProfileDetailedDto {
  final int? userId;
  final String firstName;
  final String lastName;
  final int? followerCount;
  final int? followingCount;
  final String bio;
  final Avatar avatar;

  UserProfileDetailedDto(
      {this.userId,
      this.followerCount,
      this.followingCount,
      required this.firstName,
      required this.lastName,
      required this.bio,
      required this.avatar});

  factory UserProfileDetailedDto.fromJson(Map<String, dynamic> json) {
    return new UserProfileDetailedDto(
        avatar: Avatar.fromJson(json['avatar']),
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        followerCount: json['followers_count'],
        followingCount: json['following_count'],
        bio: json['bio']);
  }

  String getName() {
    return firstName + " " + lastName;
  }
}

class User {
  int id;
  String username;
  String token;

  User({required this.id, required this.username, required this.token});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() =>
      {"id": this.id, "username": this.username, "token": this.token};

  // static Future<User> fromJson(Map elementAt) {}
}

class FollowerDto {
  final bool isFollowing;
  final UserProfileDto user;

  FollowerDto({required this.isFollowing, required this.user});
}
