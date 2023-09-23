import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/services/item_services.dart';
import 'package:provider/provider.dart';

import '../../models/categories.dart';
import '../../providers/shop_provider.dart';
import '../../utils/constants.dart';
import '../../utils/customContainers.dart';
import '../homeScreen/homeScreen.dart';

class CrunchPrice extends StatefulWidget {
  final AddItem item;
  const CrunchPrice({super.key, required this.item});

  @override
  State<CrunchPrice> createState() => _CrunchPriceState();
}

class _CrunchPriceState extends State<CrunchPrice> {
  bool isStarActive = false;
  bool showCustom = false;

  String? store;

  @override
  Widget build(BuildContext context) {
    final shops = Provider.of<ShopProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            color: crunchPriceBackGroundColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  customTopRowWithBackButton(() {
                    setState(() {
                      isStarActive = true;
                    });
                  }, () {
                    setState(() {
                      isStarActive = true;
                    });
                  }, isStarActive),
                  sizedBox02,
                  customItemContainerWithBestPrice(
                      widget.item.itemName,
                      '(${widget.item.category})',
                      'Best Price:',
                      '\$${widget.item.price} / ${widget.item.quantity} ${widget.item.unit}',
                      '(\$${(num.parse(widget.item.price) / widget.item.quantity).toStringAsFixed(3)} / ${widget.item.unit.substring(0, widget.item.unit.length - 1)})',
                      '${DateFormat('MMM, dd, yyyy').format(widget.item.dateTime)} at ${widget.item.storeName}'),
                  sizedBox02,
                  customRowBulkPackaging((value) {
                    setState(() {
                      checkBox = !checkBox;
                    });
                  }, checkBox, 'Bulk Packaging?'),
                  customContainerTopHeadingText('Enter the price'),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Color(0xFFB7C6D2),
                        ),
                        customTextField(
                          priceController,
                          TextInputType.number,
                          '20',
                          NumberInputFormatter(),
                        ),
                      ],
                    ),
                  ),
                  sizedBox02,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customContainerTopHeadingText('Enter quantity'),
                          customHalfContainerWithTextField(
                            quantityController,
                            NumberInputFormatter(),
                          )
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customContainerTopHeadingText('select unit'),
                          InkWell(
                            onTap: () {
                              customShowModalBottomSheetCrunchPrice(
                                context,
                              );
                            },
                            child: customContainerSelectedUnit(
                              selectedUnit,
                              selectedUnit,
                              true,
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  sizedBox02,
                  showCustom
                      ? Row(
                          children: [
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customContainerTopHeadingText('Enter Unit'),
                                customHalfContainerWithTextField2(
                                  customController,
                                )
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  sizedBox02,
                  customContainerTopHeadingText('Select store'),
                  Container(
                    width: Get.width,
                    height: Get.height * 0.07,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: DropdownButtonFormField<String>(
                        value: store,
                        hint: Text('Select Store'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isCollapsed: true,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            store = newValue!;
                          });
                        },
                        items: shops.shopList
                            .map<DropdownMenuItem<String>>((Shop shop) {
                          return DropdownMenuItem<String>(
                            value: shop.name,
                            child: Text(
                              shop.name,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  sizedBox02,
                  customContainerTopHeadingText('Enter brand (optional)'),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        customTextField(brandController, null, null),
                      ],
                    ),
                  ),
                  sizedBox02,
                  customRowBulkPackaging((value) {
                    setState(() {
                      checkBoxSalePrice = !checkBoxSalePrice;
                    });
                  }, checkBoxSalePrice, 'Sale Price'),
                  sizedBox02,
                  customContainerTopHeadingText('Date'),
                  InkWell(
                    onTap: () async {
                      datePicked = (await DatePicker.showSimpleDatePicker(
                        context,
                        dateFormat: "dd-MMMM-yyyy",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      ))!;
                      setState(() {});
                    },
                    child: customDateTimeContainer(datePicked),
                  ),
                  sizedBox05,
                  customSubmitContainer(() async {
                    Map<String, String> comparePricesResult = comparePrices(
                      double.parse(widget.item.price),
                      widget.item.quantity,
                      double.parse(priceController.text),
                      double.parse(quantityController.text),
                      widget.item.unit,
                      selectedUnit,
                      _getUnitType(selectedUnit),
                    );

// Call the function to show the dialog
                    _showResultDialog(comparePricesResult);
                    // await customShowGeneralDialogToShowIncreaseDecreaseInCrunchPrice(
                    //     context, () {
                    //   Get.back();
                    // }, () {
                    //   Get.back();
                    // }, () {
                    //   Get.back();
                    // });
                  }, 'Crunch Price'),
                  sizedBox02
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showResultDialog(Map<String, String> result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final double dialogWidth = MediaQuery.of(context).size.width * 0.9;
        final double dialogHeight = MediaQuery.of(context).size.height * 0.7;
        final double containerWidth = dialogWidth * 0.95;
        final double contentFontSize = MediaQuery.of(context).size.width * 0.04;

        return AlertDialog(
          content: Container(
            width: dialogWidth,
            height: dialogHeight / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: dialogHeight * 0.02,
                  ),
                  Container(
                    width: containerWidth,
                    height: dialogHeight * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: result['pricecolor'].toString() == '1'
                          ? Color(0xfff48787)
                          : Color(0xff98db98),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                result['newcompare'].toString(),
                                style: TextStyle(
                                  fontSize: contentFontSize * 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          result['result'].toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: contentFontSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: dialogHeight * 0.05,
                  ),
                  Container(
                    width: containerWidth,
                    height: dialogHeight * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    child: TextButton(
                      onPressed: () async {
                        await ItemServices().addItems(
                          context: context,
                          itemName: widget.item.itemName,
                          category: widget.item.category,
                          dateTime: datePicked,
                          itemDescription: widget.item.itemDescription,
                          barcode: widget.item.barcode,
                          quantity: double.parse(quantityController.text),
                          unit:
                              showCustom ? customController.text : selectedUnit,
                          price: priceController.text == '' ||
                                  priceController.text.isEmpty
                              ? 'no price'
                              : priceController.text,
                          brandName: brandController.text,
                          storeName: store,
                          bulkPackaging: checkBox,
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                        showToast('Items added successfully', color2);
                      },
                      child: Center(
                        child: Text(
                          "Save Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: contentFontSize * 1.2,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: dialogHeight * 0.015,
                  ),
                  Container(
                    width: containerWidth,
                    height: dialogHeight * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      child: Center(
                        child: Text(
                          "Close",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: contentFontSize * 1.2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: dialogHeight * 0.015,
                  ),
                  Container(
                    width: containerWidth,
                    height: dialogHeight * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Text(
                          "Edit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: contentFontSize * 1.2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getUnitType(String selectedUnit) {
    if (weightUnitsList.contains(selectedUnit)) {
      return "Weight";
    } else if (volumeUnitsList.contains(selectedUnit)) {
      return "Volume";
    } else {
      return "Other";
    }
  }

  Future<dynamic> customShowModalBottomSheetCrunchPrice(
    //here is the
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40))),
      builder: (context) {
        return Container(
          height: Get.height * 0.65,
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: Get.width * 0.4,
                  height: 10,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF3F3F3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                sizedBox02,
                customBoldText20W800Black('Select A Unit'),
                sizedBox02,
                customRowText18W400Start1(
                  'Custom',
                ),
                sizedBox02,
                customBlueRowContainer('Weight'),
                sizedBox02,
                for (String unit in weightUnitsList)
                  customRowText18W400Start(unit),
                customDivider(),
                sizedBox02,
                customBlueRowContainer('Volume/Capacity'),
                sizedBox02,
                for (String volumeUnit in volumeUnitsList)
                  customRowText18W400Start(volumeUnit),
                customDivider(),
                sizedBox02,
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector customRowText18W400Start(
    String text,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showCustom = false;
          selectedUnit = text;
          Navigator.pop(context);
        });
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sizedBox002Width,
            sizedBox002Width,
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF282828),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector customRowText18W400Start1(
    String text,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showCustom = true;
          selectedUnit = 'Custom';
          Navigator.pop(context);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sizedBox002Width,
          sizedBox002Width,
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF282828),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  DateTime datePicked = DateTime.now();
  String selectedUnit = 'Grams';
  TextEditingController priceController = TextEditingController(text: '');
  TextEditingController quantityController = TextEditingController(text: '');
  TextEditingController brandController = TextEditingController(text: '');
  TextEditingController searchStoreController = TextEditingController(text: '');
  TextEditingController phoneNumberController = TextEditingController(text: '');
  TextEditingController customController = TextEditingController(text: '');
  bool showPassword = true;
  bool showConfirmPassword = true;
  var selected;

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    brandController.dispose();
    searchStoreController.dispose();
    phoneNumberController.dispose();
    customController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    priceController = TextEditingController();
    phoneNumberController = TextEditingController();
    quantityController = TextEditingController();
    brandController = TextEditingController();
    searchStoreController = TextEditingController();
    _getUnitType(selectedUnit);

    print(
      _getUnitType(selectedUnit),
    );

    super.initState();
  }

  bool checkBox = false;
  bool checkBoxSalePrice = false;
}

Map<String, String> comparePrices(
  double oldUnitPrice,
  double oldQuantity,
  double newUnitPrice,
  double newQuantity,
  String oldUnitName,
  String newUnitName,
  String unitType,
) {
  print("old unit price $oldUnitPrice");
  print("oldQuantity  $oldQuantity");
  print("newUnitPrice $newUnitPrice");
  print("new quantity $newQuantity");
  print("old unit name $oldUnitName");
  print("new unit name $newUnitName");

  final Map<String, Map<String, double>> weightUnitConversionFactors = {
    "Grams": {
      "Kilograms": 0.001,
      "Milligrams": 1000,
      "Ounces": 0.035273962,
      "Pounds": 0.002204623
    },
    "Kilograms": {
      "Kilograms": 1,
      "Grams": 1000,
      "Milligrams": 1000000,
      "Ounces": 35.2739619,
      "Pounds": 2.20462262
    },
    "Milligrams": {
      "Grams": 0.001,
      "Kilograms": 0.000001,
      "Ounces": 0.000035274,
      "Pounds": 2.20462E-06
    },
    "Ounces": {
      "Grams": 28.3495231,
      "Kilograms": 0.028349523,
      "Milligrams": 28349.5231,
      "Pounds": 0.0625
    },
    "Pounds": {
      "Grams": 453.59237,
      "Kilograms": 0.453592,
      "Milligrams": 453592,
      "Ounces": 16
    },
  };

  final Map<String, Map<String, double>> volumeUnitConversionFactors = {
    "Gallon (US)": {
      "Gallon (US)": 1,
      "Liter": 3.78541178,
      "Milliliter": 3785.41178,
      "Fluid Ounce": 128,
    },
    "Liter": {
      "Gallon (US)": 0.264172052,
      "Gallon (UK)": 0.219969157,
      "Milliliter": 1000,
      "Fluid Ounce": 33.8140227,
    },
    "Milliliter": {
      "Gallon (US)": 0.000264172,
      "Liter": 0.001,
      "Fluid Ounce": 0.033814023,
    },
    "Fluid Ounce": {
      "Gallon (US)": 0.0078125,
      "Liter": 0.02957353,
      "Milliliter": 29.5735296,
    },
  };

  final Map<String, Map<String, double>> lengthUnitConversionFactors = {
    "Feet": {
      "Inch": 12,
      "Yard": 0.333333,
      "Meter": 0.3048,
      "Centimeter": 30.48,
      "Millimeter": 304.8,
      "Custom Unit": 1.0,
    },
    "Inch": {
      "Feet": 0.0833333,
      "Yard": 0.0277778,
      "Meter": 0.0254,
      "Centimeter": 2.54,
      "Millimeter": 25.4,
      "Custom Unit": 1.0,
    },
    "Yard": {
      "Feet": 3,
      "Inch": 36,
      "Meter": 0.9144,
      "Centimeter": 91.44,
      "Millimeter": 914.4,
      "Custom Unit": 1.0,
    },
    "Meter": {
      "Feet": 3.28084,
      "Inch": 39.3701,
      "Yard": 1.09361,
      "Centimeter": 100,
      "Millimeter": 1000,
      "Custom Unit": 1.0,
    },
    "Centimeter": {
      "Feet": 0.0328084,
      "Inch": 0.393701,
      "Yard": 0.0109361,
      "Meter": 0.01,
      "Millimeter": 10,
      "Custom Unit": 1.0,
    },
    "Millimeter": {
      "Feet": 0.00328084,
      "Inch": 0.0393701,
      "Yard": 0.00109361,
      "Meter": 0.001,
      "Centimeter": 0.1,
      "Custom Unit": 1.0,
    },
    "Custom Unit": {
      "Feet": 1.0,
      "Inch": 1.0,
      "Yard": 1.0,
      "Meter": 1.0,
      "Centimeter": 1.0,
      "Millimeter": 1.0,
    },
  };

  double convertedOldUnitPrice = oldUnitPrice;
  if (oldUnitName != newUnitName && unitType == "Weight") {
    double? conversionFactor =
        weightUnitConversionFactors[oldUnitName]![newUnitName];
    convertedOldUnitPrice /= conversionFactor!;
  } else if (oldUnitName != newUnitName && unitType == "Volume") {
    double? conversionFactor =
        volumeUnitConversionFactors[oldUnitName]![newUnitName];
    convertedOldUnitPrice /= conversionFactor!;
  } else if (oldUnitName != newUnitName && unitType == "Length") {
    double? conversionFactor =
        lengthUnitConversionFactors[oldUnitName]![newUnitName];
    convertedOldUnitPrice /= conversionFactor!;
  }

  print("object $convertedOldUnitPrice");

  if (newUnitName == oldUnitName) {
    String newcompare =
        '\$${(newUnitPrice / newQuantity).toStringAsFixed(3)} / ${newUnitName.substring(0, newUnitName.length - 1)}';
    double oldpriceDifference = (oldUnitPrice / oldQuantity) * 100;
    double newpricediffrence = (newUnitPrice / newQuantity) * 100;

    double newdiffrence = newpricediffrence - oldpriceDifference;

    double percentDifference = newdiffrence;
    String pricecolor;

    if (percentDifference < 0) {
      pricecolor = '0';
    } else if (percentDifference > 0) {
      pricecolor = '1';
    } else {
      pricecolor = '0';
    }

    String result;
    if (newUnitPrice < 0.005) {
      result = newcompare;
    } else if (percentDifference < 0) {
      result =
          "This price is ${percentDifference.abs().toStringAsFixed(2)}% cheaper per $newUnitName than the previous best price!";
    } else if (percentDifference > 0) {
      result =
          "This price is ${percentDifference.toStringAsFixed(2)}% more expensive per $newUnitName than the previous best price.";
    } else {
      result = "This price is equivalent to the previous best price";
    }

    return {
      'result': result,
      'newcompare': newcompare,
      'pricecolor': pricecolor,
    };
  } else {
    String pricecolor;
    double priceDifference = newUnitPrice - convertedOldUnitPrice;

    if (priceDifference < 0) {
      pricecolor = '0';
    } else if (priceDifference > 0) {
      pricecolor = '1';
    } else {
      pricecolor = '0';
    }

    double percentDifference =
        (priceDifference / convertedOldUnitPrice).abs() * 100;
    String newcompare =
        '\$${(convertedOldUnitPrice / newQuantity).toStringAsFixed(3)} / ${newUnitName.substring(0, newUnitName.length - 1)}';
    String result;
    if (newUnitPrice < 0.005) {
      result = newcompare;
    } else if (priceDifference < 0) {
      result =
          "This price is ${percentDifference.toStringAsFixed(2)}% cheaper per $newUnitName than the previous best price!";
    } else if (priceDifference > 0) {
      result =
          "This price is ${percentDifference.toStringAsFixed(2)}% more expensive per $newUnitName than the previous best price.";
    } else {
      result = "This price is equivalent to the previous best price";
    }
    return {
      'result': result,
      'newcompare': newcompare,
      'pricecolor': pricecolor,
    };
  }
}
