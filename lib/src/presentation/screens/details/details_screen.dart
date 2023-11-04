import 'package:flutter/material.dart';
import 'package:olm/interfaces/categories.dart';
import 'package:olm/interfaces/category_details.dart';
import 'package:olm/src/client_apis/categories/categories_mgr.dart';
import 'package:olm/src/presentation/screens/cart/cart_screen.dart';
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

  int selectedItem = -1;

  int selectedFatPreference = -1;

  List<ListItem> items = [
    ListItem("Medium Curry Cut", 0.00, false),
    ListItem("Large Curry Cut", 0.00, false),
    ListItem("Large Biryani Cut", 0.00, false),
    ListItem("Medium Biryani Cut", 0.00, false),
  ];

  List<ListItem> fatList = [
    ListItem("Without fat", 20.00, false),
    ListItem("With fat", 10.00, false),
  ];

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
    return ListView(
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
            //  width: 200,
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
                // const SizedBox(),
                categoryDetails.selectedNumber == 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 112,
                            height: 27,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                  onTap: () async {
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
                                      print(
                                          'No data received from DetailsScreen');
                                    }
                                  },
                                  child: Container(
                                    width: 63,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                    ),
                                    child: const Text(
                                      'ADD +',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorConstants.appButtonColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(
                        width: 112,
                        height: 27,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            // margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ColorConstants.appButtonColor,
                            ),
                            height: 22,
                            width: 63,

                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Align children at the start and end.
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      _incrementCounter(categoryDetails),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.add,
                                //     color: Colors.white,
                                //     size: 11,
                                //   ),
                                //   onPressed: () =>
                                //       _incrementCounter(categoryDetails),
                                // ),
                                Text(
                                  '${categoryDetails.selectedNumber + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),

                                InkWell(
                                  onTap: () =>
                                      _decrementCounter(categoryDetails),
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.remove,
                                //     color: Colors.white,
                                //     size: 11,
                                //   ),
                                //   onPressed: () =>
                                //       _decrementCounter(categoryDetails),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      )
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

  Widget cartContainer(bool bGoToCart) {
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
                bGoToCart
                    ? TextButton(
                        onPressed: () {
                          print('go to cart');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                        },
                        child: const Text('Go To Cart',
                            style: TextStyle(color: Colors.white)))
                    : TextButton(
                        onPressed: () {
                          print('view cart');
                          _modalBottomSheetMenu();
                        },
                        child: const Text('View Cart',
                            style: TextStyle(color: Colors.white))),
              ],
            )
          ],
        ));
  }

  Widget detailList() {
    double screenHeight = MediaQuery.of(context).size.height;

    double adjustedHeight = screenHeight - 150;
    containsSelectedNumber = categoryDetailsList
        .any((CategoryDetails item) => item.selectedNumber > 0);
    print(containsSelectedNumber);
    return SizedBox(
      height: 600,
      child: Stack(
        children: [
          ListView.builder(
            itemCount: categoryDetailsList.length,
            itemBuilder: (context, index) {
              final categoryDetails = categoryDetailsList[index];
              return Container(
                padding: const EdgeInsets.all(10),
                width: 350,
                child: Row(
                  children: [
                    Stack(
                      children: [
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
                            const SizedBox(height: 105),
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
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      categoryDetails.offerLimit,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    content(categoryDetails),
                  ],
                ),
              );
            },
          ),
          if (containsSelectedNumber)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: cartContainer(false),
            ),
        ],
      ),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: 784,
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Make sure you select \nto complete shopping',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w800),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        color: Color(0xFFE8E8E8),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Select your choice of cut',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                'Required',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      height: 152,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Color(0xFFE8E8E8),
                      ),
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    activeColor: Colors.black,
                                    value: index,
                                    groupValue: selectedItem,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedItem = value!;
                                        for (var item in items) {
                                          item.isSelected = false;
                                        }
                                        items[value].isSelected = true;
                                      });
                                    },
                                  ),
                                  Text(
                                    items[index].title,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Text(
                                '${StringConstants.rupeeTextButton} ${items[index].cost.toString()}',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          );
                        },
                        // physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        color: Color(0xFFE8E8E8),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'How do you like your meat',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text(
                                  'Required',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                )
                              ]),
                        ],
                      ),
                    ),
                    Container(
                      height: 80,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        color: Color(0xFFE8E8E8),
                      ),
                      child: ListView.builder(
                        itemCount: fatList.length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Radio(
                                    activeColor: Colors.black,
                                    value: index,
                                    groupValue: selectedFatPreference,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedFatPreference = value!;
                                        for (var item in fatList) {
                                          item.isSelected = false;
                                        }
                                        fatList[value].isSelected = true;
                                      });
                                    },
                                  ),
                                  Text(
                                    fatList[index].title,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              Text(
                                '${StringConstants.rupeeTextButton} ${fatList[index].cost.toString()}',
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                            ],
                          );
                        },
                        physics: const NeverScrollableScrollPhysics(),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Would you like to \nspice up your meal',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w800),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "Select Add On's",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          height: 182,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
                Positioned(
                  bottom: 100,
                  left: 0,
                  right: 0,
                  child: cartContainer(true),
                ),
              ]),
            );
          });
        });
  }
}

class ListItem {
  final String title;
  final num cost;
  bool isSelected;

  ListItem(this.title, this.cost, this.isSelected);
}
