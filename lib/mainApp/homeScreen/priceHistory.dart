import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/utils/constants.dart';

import '../../shared/custom_appBar.dart';
import '../../utils/size_confiq.dart';

class PriceHistoryScreen extends StatefulWidget {
  const PriceHistoryScreen({
    super.key,
  });

  @override
  State<PriceHistoryScreen> createState() => _PriceHistoryScreenState();
}

class _PriceHistoryScreenState extends State<PriceHistoryScreen> {
  bool isStarActive = false;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController customUnit;
  late TextEditingController barcodeController;
  bool showPassword = true;
  bool showConfirmPassword = true;
  var selected;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    customUnit.dispose();
    barcodeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    nameController = TextEditingController();
    barcodeController = TextEditingController();
    descriptionController = TextEditingController();
    categoryController = TextEditingController();
    customUnit = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Price History',
          context: context,
          fromVip: false,
          fontSize: getProportionateScreenWidth(24)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // customTopRowWithBackButtonAndCrownImage('Price History'),
              sizedBox03,
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: Get.width,
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                width: 0.50, color: const Color(0xFFEBEBEB))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            sizedBox002Width,
                            Column(
                              children: [
                                const Text(
                                  '\$5.00 / 10.00 bag(s)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF3E3E3E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                sizedBox01,
                                const Text(
                                  '\$0.50 / bag(s)',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF3E3E3E),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                const Text(
                                  'Walmart',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                sizedBox01,
                                const Text(
                                  'Date: 29 May, 23',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                            sizedBox002Width,
                          ],
                        ),
                      ),
                      sizedBox02
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
