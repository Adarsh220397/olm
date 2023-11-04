import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/details/details_screen.dart';
import 'package:olm/src/utils/constants/icon_constants.dart';
import 'package:olm/src/utils/constants/string_constants.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({super.key});

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  int selectedFatPreference = -1;

  List<Address> fatList = [
    Address("Home", '1/3 first cross street, seethammal colony', false),
    Address("Mom", '4/3 fourth cross street, seethammal colony', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0F0),
      appBar: AppBar(
        title: const Text('Delivery Details'),
        centerTitle: true,
      ),
      body: SafeArea(child: deliveryBody()),
    );
  }

  Widget deliveryBody() {
    return Column(
      children: [
        Container(
          height: 170,
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.only(left: 20, right: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: Colors.white,
          ),
          child: Column(children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved Address',
                    style: TextStyle(
                        color: Color.fromARGB(255, 116, 39, 39),
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        '+ Add',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: fatList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 40,
                    child: Row(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  fatList[index].title,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  fatList[index].description,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                physics: const NeverScrollableScrollPhysics(),
              ),
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        offerCardUI(),
        cartContainer()
      ],
    );
  }

  Widget offerCardUI() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 40, width: 40, child: Image.asset(IconConstants.offer)),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Apply Coupon Code',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 18),
                ),
                const Text(
                  'Exciting offers for Goat and Lamb',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ],
            ),
          ]),
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
                    },
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white)))
              ],
            )
          ],
        ));
  }
}

class Address {
  final String title;
  final String description;
  bool isSelected;

  Address(this.title, this.description, this.isSelected);
}
