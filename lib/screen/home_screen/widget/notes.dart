class Notes {
  final String id;
  final String userId;
  final String headline;
  final String description;
  bool isCompleted;

  Notes({
    required this.id,
    required this.userId,
    required this.headline,
    required this.description,
    this.isCompleted = false,
  });

  Notes copyWith({
    String? id,
    String? userId,
    String? headline,
    String? description,
    bool? isCompleted,
  }) {
    return Notes(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'headline': headline,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  factory Notes.fromFirestore(String id, Map<String, dynamic> data) {
    return Notes(
      id: id,
      userId: data['userId'],
      headline: data['headline'],
      description: data['description'],
      isCompleted: data['isCompleted'] ?? false,
    );
  }
}
