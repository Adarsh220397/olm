import 'package:flutter/material.dart';
import 'package:olm/interfaces/categories.dart';
import 'package:olm/interfaces/category_details.dart';
import 'package:olm/src/client_apis/categories/categories_mgr.dart';
import 'package:olm/src/presentation/screens/content/content_screen.dart';
import 'package:olm/src/utils/constants/color_constants.dart';
import 'package:olm/src/utils/constants/icon_constants.dart';
import 'package:olm/src/utils/constants/string_constants.dart';

class DetailsScreen extends StatefulWidget {
  final Category? category;
  final CategoryDetails? categoryDetails;
  const DetailsScreen({Key? key, this.category, this.categoryDetails})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool containsSelectedNumber = false;
  List<IData> dataList = [];
  List<Category> categoryList = [];

  List<CategoryDetails> categoryDetailsList = [];

  List<CategoryDetails> addedItems = [];

  // List<num> selectedFilters = [];

  // void handleFilterSelection(num filter) {
  //   setState(() {
  //     if (selectedFilters.contains(filter)) {
  //       selectedFilters.remove(filter);
  //     } else {
  //       selectedFilters.add(filter);
  //     }
  //   });
  // }

  num selectedFilter = 0;

  void handleFilterSelection(num filter) {
    final matchingData = dataList.firstWhere(
      (IData data) => data.id == filter,
      orElse: () => IData(id: 0, categoryDetails: []),
    );

    setState(() {
      selectedFilter = filter;

      categoryDetailsList = matchingData.categoryDetails;
    });
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
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    categoryList = await CategoriesMgr.instance.getCategoryList();
    dataList = await CategoriesMgr.instance.getCategoryDetails();

    final matchingData = dataList.firstWhere(
      (IData data) => data.id == widget.category!.id,
      orElse: () => IData(id: 0, categoryDetails: []),
    );

    setState(() {
      categoryDetailsList = matchingData.categoryDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detailsBody(),
    );
  }

  Widget detailsBody() {
    return Column(
      children: [customAppBar(), categoryListWidget(), detailList()],
    );
  }

  Widget categoryListWidget() {
    return Container(
      height: 46,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, i) {
            return Container(
              // width: 55,
              height: 30,
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),

              // decoration: const BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(15))),
              child: FilterChip(
                selectedColor: ColorConstants.appButtonColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: selectedFilter == categoryList[i].id
                          ? Colors.transparent
                          : Colors.grey,
                      width: 1),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                showCheckmark: false,

                label: Text(
                  categoryList[i].title,
                  style: TextStyle(
                    color: selectedFilter == categoryList[i].id
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
                selected: selectedFilter ==
                    categoryList[i]
                        .id, //selectedFilters.contains(categoryList[i].id),
                onSelected: (selected) {
                  handleFilterSelection(categoryList[i].id!);
                },
              ),
            );
          }),
    );
  }

  Widget customAppBar() {
    return Stack(children: [
      Container(
        height: 142,
        // foregroundDecoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.white,
        //       Colors.white.withOpacity(0.7),
        //       Colors.white.withOpacity(0.1),
        //       Colors.white.withOpacity(0.1),
        //       // Colors.white.withOpacity(0.7),
        //       // Colors.white,
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     stops: const [0, 0.5, 0.8, 1],
        //   ),
        // ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(IconConstants.detailsHeader),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Column(
        children: [
          Container(
            height: 90,
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_left_sharp,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Container(
                color: Colors.transparent,
                child: Text(
                  widget.category!.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              const Icon(Icons.filter_list),
            ],
          ),
        ],
      )
    ]);
  }

  Widget content(CategoryDetails categoryDetails) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoryDetails.title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Text(
            categoryDetails.description,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        "${StringConstants.rupeeTextButton} ${categoryDetails.orgPrice.toString()}",
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "${StringConstants.rupeeTextButton} ${categoryDetails.disPrice.toString()}",
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      )
                    ]),
                    Text(
                      categoryDetails.quantity,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(),
                categoryDetails.selectedNumber == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 30,
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                // Navigate to the DetailsScreen and get return data

                                final CategoryDetails result =
                                    //     await Navigator.pushReplacement(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (BuildContext context) =>
                                    //           ContentScreen(
                                    //             categoryDetails: categoryDetails,
                                    //           )),
                                    // );
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                  builder: (_) => ContentScreen(
                                    categoryDetails: categoryDetails,
                                  ),
                                ));

                                if (result != null) {
                                  setState(() {
                                    categoryDetails = result;
                                    addedItems.add(result);
                                  });
                                } else {
                                  print('No data received from DetailsScreen');
                                }
                              },
                              child: const Text(
                                'ADD +',
                                style: TextStyle(
                                    color: ColorConstants.appButtonColor),
                              )),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () => _decrementCounter(categoryDetails),
                          ),
                          Text(
                            '${categoryDetails.selectedNumber + 1}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () => _incrementCounter(categoryDetails),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Image.asset(IconConstants.deliveryImg),
              const Text(
                'Today delivery in 90 mins',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )
            ],
          ),
          Row(
            children: const [
              Text(
                '#freshmeat   #fattrimmed',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget cartContainer() {
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
              children: const [
                Text(
                  '1 item | Rs ${80 * 1}',
                  style: TextStyle(color: Colors.white),
                ),
                Text('Extra charges may apply',
                    style: TextStyle(color: Colors.grey)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      print('go to cart');
                      // Navigator.pop(context);

                      // Navigator.pop(context, newCategoryDetails);
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
                    child: Text('View Cart',
                        style: TextStyle(color: Colors.white))),
              ],
            )
          ],
        ));
  }

  Widget detailList() {
    containsSelectedNumber = categoryDetailsList
        .any((CategoryDetails item) => item.selectedNumber > 0);
    print(containsSelectedNumber);
    return SizedBox(
      height: 600,
      child: Stack(children: [
        ListView.builder(
          itemCount: categoryDetailsList.length,
          itemBuilder: (context, index) {
            final categoryDetails = categoryDetailsList[index];
            return Container(
                padding: const EdgeInsets.all(10),
                //   height: 145,
                width: 350,
                child: Row(
                  children: [
                    Stack(children: [
                      SizedBox(
                        height: 145,
                        width: 127,
                        child: Image.asset(categoryDetails.image,
                            fit: BoxFit.cover),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 105,
                          ),
                          Container(
                            height: 40,
                            width: 127,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.transparent, Colors.black],
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categoryDetails.offer,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(
                                      categoryDetails.offerLimit,
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      )
                    ]),
                    const SizedBox(
                      width: 10,
                    ),
                    content(categoryDetails)
                  ],
                ));
          },
        ),
        containsSelectedNumber
            ? Positioned(bottom: 0, left: 0, right: 0, child: cartContainer())
            : SizedBox(),
      ]),
    );
  }
}
