import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/Store/widgets.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';

class ComparePrice extends StatefulWidget {
  const ComparePrice({super.key});

  @override
  State<ComparePrice> createState() => _ComparePriceState();
}

class _ComparePriceState extends State<ComparePrice> {
  bool checkBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Quick Comparison',
          context: context,
          fromVip: false,
          fontSize: getProportionateScreenWidth(24)),
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // customTopRowWithBackButtonAndCrownImage('Quick Comparison'),
              customRowBulkPackaging((value) {
                setState(() {
                  checkBox = !checkBox;
                });
              }, checkBox, 'Bulk Packaging?'),
              sizedBox02,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customContainerQuickComparison('Item 1'),
                  customContainerQuickComparison('Item 2'),
                ],
              ),
              sizedBox02,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customContainerOfPriceInPriceComapreScreenWithTextField(
                      'Price', priceController),
                  customContainerOfPriceInPriceComapreScreenWithTextField(
                      'Price', priceController2),
                ],
              ),
              sizedBox02,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customContainerOfPriceInPriceComapreScreenWithTextField(
                      'Quantity', quantityController),
                  customContainerOfPriceInPriceComapreScreenWithTextField(
                      'Quantity', quantityController2),
                ],
              ),
              sizedBox02,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customContainerOfPriceInPriceComapreScreenWithTextField(
                      'Unit', unitController),
                  customContainerOfPriceInPriceComapreScreenWithTextField(
                      'Unit', unitController2),
                ],
              ),
              sizedBox05,
              customSubmitContainerWithLightBlack(() {}, 'Compare'),
              sizedBox02,
              customResetButtonFilterDialogHomeScreen('Clear', () {
                Get.back();
              }),
// No text styles in this selection
            ],
          ),
        ),
      ),
    );
  }

  late TextEditingController priceController;
  late TextEditingController priceController2;
  late TextEditingController quantityController;
  late TextEditingController quantityController2;
  late TextEditingController unitController;
  late TextEditingController unitController2;
  bool showPassword = true;
  var selected;

  @override
  void dispose() {
    priceController.dispose();
    priceController2.dispose();
    quantityController.dispose();
    quantityController2.dispose();
    unitController.dispose();
    unitController2.dispose();
    super.dispose();
  }

  @override
  void initState() {
    priceController = TextEditingController();
    priceController2 = TextEditingController();
    quantityController = TextEditingController();
    quantityController2 = TextEditingController();
    unitController = TextEditingController();
    unitController2 = TextEditingController();

    super.initState();
  }
}
