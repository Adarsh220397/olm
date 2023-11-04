import 'package:flutter/material.dart';
import 'package:olm/interfaces/categories.dart';
import 'package:olm/src/utils/size_utils.dart';

import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/icon_constants.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late ThemeData themeData;

  Category? selectedAddress;

  TextEditingController searchController = TextEditingController();
  final ScrollController addressController = ScrollController();
  FocusNode searchFocusNode = FocusNode();
  List<Category> _searchResult = [];
  List<Category> addressList = [
    Category(
        image: IconConstants.loc1,
        title: 'Annanagar',
        description: 'New zone in town'),
    Category(
        image: IconConstants.loc2,
        title: 'Ambattur',
        description: 'New zone in town'),
    Category(
        image: IconConstants.loc3,
        title: 'Manali',
        description: 'New zone in town'),
    Category(
        image: IconConstants.loc4,
        title: 'Madhavaram',
        description: 'New zone in town'),
    Category(
        image: IconConstants.loc5,
        title: 'Royapuram',
        description: 'New zone in town'),
    Category(
        image: IconConstants.loc6,
        title: 'Tondiarpet',
        description: 'New zone in town'),
  ];

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Select Delivery Address'),
        ),
        body: SafeArea(child: addressScreenBody()));
  }

  Widget addressScreenBody() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            searchBarWidget(),
            addressListWidget()
          ],
        ));
  }

  Widget searchBarWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.search),
        title: TextFormField(
          focusNode: searchFocusNode,
          controller: searchController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: "Search for delivery location",
          ),
          onChanged: (value) => {_runFilter(value)},
        ),
      ),
    );
  }

  void _runFilter(String enteredKeyword) {
    setState(() {
      // if (selectedAddress != null) {
      //   _searchResult = [selectedAddress!];
      // } else {
      if (enteredKeyword.isEmpty) {
        _searchResult = addressList;
      } else {
        _searchResult = addressList
            .where((address) => address.title
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
      // }
    });
  }

  Widget addressListWidget() {
    List<Category> displayList =
        _searchResult.isEmpty ? addressList : _searchResult;

    return Expanded(
      child: ListView.builder(
        controller: addressController,
        itemCount: displayList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return ListTile(
            tileColor: displayList[i] == selectedAddress ? Colors.grey : null,
            leading: Image.asset(displayList[i].image),
            title: Text(
              displayList[i].title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayList[i].description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                selectedAddress = displayList[i];
                searchController.text = displayList[i].title;
                //  _searchResult.clear();
              });
            },
          );
        },
      ),
    );
  }
}
