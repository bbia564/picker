class ColorEntity {
  int id;
  DateTime createdTime;
  String content;

  ColorEntity({
    required this.id,
    required this.createdTime,
    required this.content,
  });

  factory ColorEntity.fromJson(Map<String, dynamic> json) {
    return ColorEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'content': content,
    };
  }

}