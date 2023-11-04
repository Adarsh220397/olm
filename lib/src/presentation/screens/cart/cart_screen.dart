import 'package:flutter/material.dart';
import 'package:olm/src/presentation/screens/delivery/delivery_screen.dart';
import 'package:olm/src/utils/constants/icon_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: SafeArea(child: cartBody()),
    );
  }

  Widget cartBody() {
    return Column(
      children: [
        SizedBox(
          height: 376,
          child: ListView.builder(itemBuilder: (context, i) {
            return Container(
                padding: const EdgeInsets.all(10),
                height: 116,
                width: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(IconConstants.goat2),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Goat Ribbs'),
                        const Text('500gms'),
                        const Text('Rs 475'),
                        const Text('Customize'),
                      ],
                    ),
                    Container(
                      // margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey,
                      ),
                      height: 22,
                      width: 63,

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Align children at the start and end.
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
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
                          const Text(
                            '1',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),

                          const Icon(
                            Icons.remove,
                            color: Colors.white,
                            size: 20,
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
                  ],
                ));
          }),
        ),
        SizedBox(
          height: 40,
        ),
        offerCardUI(),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Would you like to \nspice up your meal',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Select Add On's",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 182,
          color: Colors.grey,
        ),
        cartContainer()
      ],
    );
  }

  Widget offerCardUI() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
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
                      print('Continue');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => DeliveryDetailScreen()));
                    },
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white))),
              ],
            )
          ],
        ));
  }
}
