class Category {
  final String id;
  final String name;
  final String color;
  final String icon;

  Category({this.id = '', this.name = '', this.color = '', this.icon = ''});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          id == other.id &&
          name == other.name &&
          color == other.color &&
          icon == other.icon;

  @override
  int get hashCode => Object.hash(id, name, color, icon);
}
