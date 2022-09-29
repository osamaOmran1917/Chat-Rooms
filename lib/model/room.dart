class Room {
  static const String collectionName = 'room';
  String? id, title, description, catId;

  Room({this.id, this.title, this.description, this.catId});

  Room.fromFireStore(Map<String, dynamic> data)
      : this(
            id: data['id'],
            title: data['title'],
            description: data['description'],
            catId: data['catId']);

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'catId': catId
    };
  }
}
