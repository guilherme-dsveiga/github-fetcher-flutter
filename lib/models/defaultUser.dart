class User {
  User(
      {required this.profileUrl,
      required this.username,
      required this.followers,
      required this.followings,
      required this.createdAt});

  final String profileUrl, username, createdAt;
  final int followers, followings;

  factory User.fromJson(Map<String, dynamic> json) => User(
        profileUrl: json['avatar_url'],
        username: json['login'],
        followers: json['followers'],
        followings: json['following'],
        createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
        'avatar_url': profileUrl,
        'login': username,
        'followers': followers,
        'followings': followings,
        'created_at': createdAt,
      };
}