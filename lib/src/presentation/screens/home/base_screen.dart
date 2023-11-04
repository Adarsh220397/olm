import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:olm/src/client_apis/offers/offers_mgr.dart';
import 'package:olm/src/client_apis/recipes/recipes_mgr.dart';
import 'package:olm/src/presentation/screens/details/details_screen.dart';
import 'package:olm/src/presentation/screens/home/home_screen.dart';
import 'package:olm/src/presentation/screens/location/address_screen.dart';
import 'package:olm/src/presentation/widgets/button_widget.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/size_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../interfaces/categories.dart';
import '../../../client_apis/categories/categories_mgr.dart';
import '../../../utils/constants/font_constants.dart';
import '../../../utils/constants/icon_constants.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late ThemeData themeData;

  final ScrollController _categoryController = ScrollController();

  final CarouselController _controller = CarouselController();

  int _currentIndex = 1;

  List<Category> filterList = [];

  List<Category> offerList = [];

  List<Category> recipeList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    filterList = await CategoriesMgr.instance.getCategoryList();
    offerList = await OfferMgr.instance.getOfferList();
    recipeList = await RecipeMgr.instance.getRecipeList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(body: SafeArea(child: onBoardingBody()));
  }

  Widget firstPosterLogo() {
    return Positioned.fill(
      child: Container(
        padding: const EdgeInsets.only(bottom: 2),
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.7),
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.7),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0, 0.2, 0.4, 0.6, 0.7, 1.0],
          ),
        ),
        child: Image.asset(
          IconConstants.onboardingLogo,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget baseScreenWidgetPartOne() {
    return Stack(children: [
      firstPosterLogo(),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => AddressScreen()));
                  },
                  child: SizedBox(
                    height: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('Home',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w800)),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                            )
                          ],
                        ),
                        const Text(
                          '1/3 new street',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                const Icon(Icons.notifications)
              ],
            ),
          ),
          Column(
            children: [
              const Text(
                'Fresh Meat Always',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              const Text(
                'Get upto 30% off on only mutton',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 150,
                height: 36,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    primary: ColorConstants.appButtonColor,
                  ),
                  child: const Text('Explore Now'),
                  onPressed: () {
                    print('------on pressed');
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      )
    ]);
  }

  Widget categories() {
    return Expanded(
      child: ListView.builder(
          controller: _categoryController,
          itemCount: filterList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.borderColor,
                  ),
                ),
                child: categoryCardUI(filterList[i]));
          }),
    );
  }

  Widget categoryCardUI(Category category) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return DetailsScreen(
              category: category,
            );
          },
        ));
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            width: 150,
            height: 250,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                category.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    category.description,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recipeCardUI(Category category) {
    return InkWell(
      onTap: () {
        print('$category');
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            width: 310,
            height: 195,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                category.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    category.description,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dotIndication() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: offerList.asMap().entries.map((entry) {
        final isCurrentPage = _currentIndex == entry.key;
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 7.0,
            height: 7.0,
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isCurrentPage ? Colors.red : Colors.grey,
              // You can adjust the opacity as needed
              //opacity: isCurrentPage ? 0.9 : 0.4,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget offerCardUI(Category category) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(category.image),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
                Text(
                  category.description,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$_currentIndex/${offerList.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.appButtonColor,
                  ),
                ),
                dotIndication()
              ],
            )
          ]),
    );
  }

  Widget baseScreenWidgetPartTwo() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        categories(),
      ],
    );
  }

  Widget baseScreenWidgetPartThree() {
    return CarouselSlider(
      carouselController: _controller,
      items: offerList.map((Category item) {
        return offerCardUI(item);
      }).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index + 1;
          });
        },
      ),
    );
  }

  Widget baseScreenWidgetPartFour() {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              'Popular Recipes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
              controller: _categoryController,
              itemCount: recipeList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, i) {
                return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstants.borderColor,
                      ),
                    ),
                    child: recipeCardUI(recipeList[i]));
              }),
        )
      ],
    );
  }

  Widget onBoardingBody() {
    return Column(
      children: [
        Expanded(flex: 5, child: baseScreenWidgetPartOne()),
        Expanded(
          flex: 3,
          child: baseScreenWidgetPartTwo(),
        ),
        Expanded(
          flex: 1,
          child: baseScreenWidgetPartThree(),
        ),
        Expanded(flex: 2, child: baseScreenWidgetPartFour()),
      ],
    );
  }

  onClick() async {
    print('---on click---');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false);
  }
}
