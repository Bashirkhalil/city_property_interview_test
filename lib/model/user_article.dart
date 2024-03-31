// model.dart
class User {
  final int id;
  final String title;
  final String description;
  final String img_link;
  final String email;


  User({
    required this.id,
    required this.title,
    required this.description,
    required this.img_link,
    required this.email
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      img_link: json['img_link'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
