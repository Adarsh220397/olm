import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:olm/interfaces/categories.dart';
import 'package:olm/interfaces/category_details.dart';
import 'package:olm/src/client_apis/offers/offers_mgr.dart';
import 'package:olm/src/presentation/screens/details/details_screen.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/constants/icon_constants.dart';

class ContentScreen extends StatefulWidget {
  final CategoryDetails? categoryDetails;
  final Category? category;
  const ContentScreen({Key? key, this.categoryDetails, this.category})
      : super(key: key);
  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late ThemeData themeData;
  Color textColor = Colors.white;

  final CarouselController _controller = CarouselController();

  List<Category> offerList = [];

  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    offerList = await OfferMgr.instance.getOfferList();

    setState(() {});
  }

  void _incrementCounter(CategoryDetails category) {
    setState(() {
      category.selectedNumber++;
    });
  }

  void _decrementCounter(CategoryDetails category) {
    if (category.selectedNumber > 0) {
      setState(() {
        category.selectedNumber--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(
            IconConstants.muttonImg,
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.categoryDetails!.title,
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(widget.categoryDetails!.description,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        )),
                    Row(
                      children: [
                        Text(
                          widget.categoryDetails!.quantity,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            'Rs ${widget.categoryDetails!.orgPrice.toString()}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            'Rs ${widget.categoryDetails!.disPrice.toString()}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: ColorConstants.appButtonColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 20,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: textColor,
                                    size: 14,
                                  ),
                                  onPressed: () => _incrementCounter(
                                      widget.categoryDetails!),
                                ),
                              ),
                              SizedBox(
                                width: 6,
                                child: Text(
                                  '${widget.categoryDetails!.selectedNumber + 1}',
                                  style:
                                      TextStyle(fontSize: 14, color: textColor),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: textColor,
                                    size: 14,
                                  ),
                                  onPressed: () => _decrementCounter(
                                      widget.categoryDetails!),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Image.asset(IconConstants.deliveryImg),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Today delivery in 90 mins',
                              style: TextStyle(color: textColor),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              baseScreenWidgetPartThree(),
              const SizedBox(
                height: 30,
              ),
              cartContainer(widget.categoryDetails!)
            ],
          )
        ]),
      ),
    );
  }

  Widget baseScreenWidgetPartThree() {
    return CarouselSlider(
      carouselController: _controller,
      items: offerList.map((Category item) {
        return offerCardUI(item);
      }).toList(),
      options: CarouselOptions(
        height: 147,
        viewportFraction: 0.8,
        enableInfiniteScroll: false,
        autoPlay: false,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
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

  Widget offerCardUI(Category category) {
    return SizedBox(
      height: 147,
      width: 300,
      child: Stack(children: [
        Image.asset(IconConstants.clipImg),
        Container(
          padding: const EdgeInsets.all(1.0),
          height: 147,
          width: 300,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: 250,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Flat 20%',
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextSpan(
                              text: '\nfor Recipe Pack',
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        category.description,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: Column(
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
                  ),
                )
              ]),
        ),
      ]),
    );
  }

  Widget dotIndication() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: offerList.asMap().entries.map((entry) {
          final isCurrentPage = _currentIndex == entry.key;
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 7.0,
              height: 7.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCurrentPage ? Colors.red : Colors.grey,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget cartContainer(CategoryDetails category) {
    return Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        width: 350,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${category.selectedNumber + 1} item | Rs ${80 * (category.selectedNumber + 1)}',
                  style: TextStyle(color: textColor),
                ),
                const Text('Extra charges may apply',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      CategoryDetails newCategoryDetails = CategoryDetails(
                          description: category.description,
                          disPrice: category.disPrice,
                          image: category.image,
                          offer: category.offer,
                          offerLimit: category.offerLimit,
                          orgPrice: category.orgPrice,
                          quantity: category.quantity,
                          selectedNumber: category.selectedNumber + 1,
                          title: category.title,
                          totalPrice: 80 * (category.selectedNumber + 1),
                          id: category.id ?? 0);
                      print('go to cart');
                      // Navigator.pop(context);
                      print('newCategoryDetails: $newCategoryDetails');

                      Navigator.pop(context, newCategoryDetails);
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (BuildContext context) => DetailsScreen(
                      //             categoryDetails: newCategoryDetails,
                      //             // selectedHouse: widget.selectedHouse,
                      //           )),
                      // );
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DetailsScreen(
                      //               categoryDetails: newCategoryDetails,
                      //             )),
                      //     (Route<dynamic> route) => false);
                    },
                    child: Text('Add', style: TextStyle(color: textColor))),
              ],
            )
          ],
        ));
  }
}
