class CategoryGiftList {
  CategoryGiftList({
    required this.categoryList,
  });
  List<CategoryGift> categoryList;
}

class CategoryGift {
  CategoryGift(
      {required this.uuid,
      required this.denom,
      required this.description,
      required this.status,
      required this.avatar});
  String uuid;
  String denom;
  String description;
  bool status;
  String avatar;
}

class ListCardGift {
  ListCardGift({required this.cardGiftList});
  List<CardGift> cardGiftList;
}

class CardGift{
  CardGift({
    required this.cardReference,
    required this.uuid,
  });
  String? cardReference;
  String? uuid;
} 