import 'entities.dart';

class Category {
  int ? id;
  String?  name;
  int?  parent;
  String? description;
  AnyImageEntity? image;
  int ?count;

  Category({
     this.id,
     this.name,
    this.parent,
     this.description,
     this.image,
     this.count,
  });
}
