class IData {
  num id;
  List<CategoryDetails> categoryDetails;

  IData({
    required this.id,
    required this.categoryDetails,
  });
}

class CategoryDetails {
  num? id;
  String image;
  String title;
  String description;
  num orgPrice;
  num disPrice;
  String quantity;
  String offer;
  String offerLimit;
  num selectedNumber;
  num? totalPrice;

  CategoryDetails({
    this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.orgPrice,
    required this.disPrice,
    required this.quantity,
    required this.offer,
    required this.offerLimit,
    required this.selectedNumber,
    this.totalPrice,
  });
}
