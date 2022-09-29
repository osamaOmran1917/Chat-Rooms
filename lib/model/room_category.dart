class RoomCategory {
  String id, name, imageName;

  RoomCategory({required this.id, required this.name, required this.imageName});

  static List<RoomCategory> getRoomCategories() {
    return [
      RoomCategory(id: 'music', name: 'Music', imageName: 'music.png'),
      RoomCategory(id: 'movies', name: 'Movies', imageName: 'movies.png'),
      RoomCategory(id: 'sports', name: 'Sports', imageName: 'sports.png'),
    ];
  }
}
