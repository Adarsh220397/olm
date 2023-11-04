import 'package:olm/interfaces/category_details.dart';
import 'package:olm/src/utils/constants/icon_constants.dart';

import '../../../interfaces/categories.dart';

class CategoriesMgr {
  //Singleton instance
  CategoriesMgr._internal();

  static CategoriesMgr instance = CategoriesMgr._internal();

  Future<List<Category>> getCategoryList() async {
    List<Category> categoryList = [];

    categoryList = [
      Category(
          id: 1,
          image: IconConstants.goat,
          title: 'Goat',
          description: 'Fresh meat at your house'),
      Category(
          id: 2,
          image: IconConstants.meat,
          title: 'Lamb',
          description: 'Fresh meat at your house'),
      Category(
          id: 3,
          image: IconConstants.goat,
          title: 'Chicken',
          description: 'Fresh meat at your house'),
      Category(
          id: 4,
          image: IconConstants.goat,
          title: 'Delicacies',
          description: 'Fresh meat at your house'),
      Category(
          id: 5,
          image: IconConstants.goat,
          title: 'Combo',
          description: 'Fresh meat at your house'),
    ];

    return categoryList;
  }

  Future<List<IData>> getCategoryDetails() async {
    List<IData> dataList = [
      IData(id: 1, categoryDetails: [
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 475,
            image: IconConstants.goat1,
            offer: '40% OFF',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Goat Meat With Bone',
            id: 1),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 475,
            image: IconConstants.goat2,
            offer: 'Rs 80 OFF',
            offerLimit: 'For 1Kg',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Goat Ribbs',
            id: 2),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 475,
            image: IconConstants.goat3,
            offer: 'Buy 1 Get 1',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Goat Meat With Bone',
            id: 3),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 475,
            image: IconConstants.goat4,
            offer: '40% OFF',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Goat Meat With Bone',
            id: 4),
      ]),
      IData(id: 2, categoryDetails: [
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 350,
            image: IconConstants.goat1,
            offer: '40% OFF',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Lamb Meat With Bone',
            id: 1),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 415,
            image: IconConstants.goat2,
            offer: 'Rs 80 OFF',
            offerLimit: 'For 1Kg',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Lamb Ribbs',
            id: 2),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 322,
            image: IconConstants.goat3,
            offer: 'Buy 1 Get 1',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Lamb Meat With Bone',
            id: 3),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 550,
            image: IconConstants.goat4,
            offer: '10% OFF',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Lamb Meat With Bone',
            id: 4),
      ]),
      IData(id: 3, categoryDetails: [
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 450,
            image: IconConstants.goat1,
            offer: '40% OFF',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Chicken Meat With Bone',
            id: 1),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 415,
            image: IconConstants.goat2,
            offer: 'Rs 80 OFF',
            offerLimit: 'For 1Kg',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Chicken Meat',
            id: 2),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 410,
            image: IconConstants.goat3,
            offer: 'Buy 1 Get 1',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Chicken Meat With Bone',
            id: 3),
        CategoryDetails(
            description: 'Fresh meat at your door step',
            disPrice: 450,
            image: IconConstants.goat4,
            offer: '10% OFF',
            offerLimit: 'UPTO 80',
            orgPrice: 675,
            quantity: '500gms',
            selectedNumber: 0,
            title: 'Chicken Meat With Bone',
            id: 4),
      ]),
    ];

    return dataList;
  }
}
