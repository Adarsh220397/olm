import 'package:olm/src/utils/constants/icon_constants.dart';

import '../../../interfaces/categories.dart';

class RecipeMgr {
  //Singleton instance
  RecipeMgr._internal();

  static RecipeMgr instance = RecipeMgr._internal();

  Future<List<Category>> getRecipeList() async {
    List<Category> recipeList = [];

    recipeList = [
      Category(
          image: IconConstants.recipe1,
          title: 'Chicken Wings',
          description: '2:30 min'),
      Category(
          image: IconConstants.recipe1,
          title: 'Meat Loaf',
          description: '5:45 min'),
      Category(
          image: IconConstants.recipe1,
          title: 'Chicken Wings',
          description: '2:30 min'),
    ];
    return recipeList;
  }
}
