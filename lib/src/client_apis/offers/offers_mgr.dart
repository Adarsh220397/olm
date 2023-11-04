import 'package:olm/src/utils/constants/icon_constants.dart';

import '../../../interfaces/categories.dart';

class OfferMgr {
  //Singleton instance
  OfferMgr._internal();

  static OfferMgr instance = OfferMgr._internal();

  Future<List<Category>> getOfferList() async {
    List<Category> offerList = [];

    offerList = [
      Category(
          image: IconConstants.offer,
          title: 'Flat 20% for Recipe pack',
          description: 'Exciting offers for goat and lamb'),
      Category(
          image: IconConstants.offer,
          title: 'Flat 30% for Recipe pack',
          description: 'Exciting offers for goat and chicken'),
    ];
    return offerList;
  }
}
