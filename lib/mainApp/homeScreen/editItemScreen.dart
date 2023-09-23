import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

import '../../models/categories.dart';
import '../../shared/custom_appBar.dart';

class EditItemScreen extends StatefulWidget {
  final String itemId;
  final String itemCategory;
  const EditItemScreen(
      {super.key, required this.itemId, required this.itemCategory});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  bool isStarActive = false;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController customUnit;
  late TextEditingController barcodeController;
  bool showPassword = true;
  bool showConfirmPassword = true;
  var selected;
  bool showCustom = false;
  String selectedCategory = '';

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    customUnit.dispose();
    barcodeController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    nameController = TextEditingController();
    barcodeController = TextEditingController();
    descriptionController = TextEditingController();
    customUnit = TextEditingController();
    selectedCategory = widget.itemCategory;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Edit Item',
          context: context,
          fromVip: false,
          fontSize: getProportionateScreenWidth(24)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // customTopRowWithBackButtonAndCrownImage('Edit Item'),
              sizedBox03,
              customContainerEditItem('Edit Item', () {
                setState(() {
                  isStarActive = false;
                });
              }, () {
                setState(() {
                  isStarActive = true;
                });
              }, isStarActive),
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: Column(children: [
                  sizedBox02,
                  customRowWithHeadingAndTextFieldToEditItem(
                      'Name:', nameController),
                  sizedBox02,
                  customRowWithHeadingAndTextFieldToEditItem(
                      'Description', descriptionController),
                  sizedBox02,
                  // customRowWithHeadingAndTextFieldToEditItem(
                  //     'Category:', categoryController),
                  GestureDetector(
                    onTap: () {
                      customShowModalBottomSheetCategory(context);
                    },
                    child: Container(
                        width: Get.width * 0.72,
                        height: Get.height * 0.06,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(selectedCategory),
                            Icon(Icons.more_vert),
                          ],
                        )),
                  ),
                  sizedBox02,
                  customRowWithHeadingAndTextFieldToEditItem(
                      'Custom Unit:', customUnit),
                  sizedBox02,
                  customRowWithHeadingAndTextFieldToEditItem(
                      'Bar Code:', barcodeController),
                  sizedBox05,
                  customSubmitContainerSmall(() async {
                    // await ItemServices().updateItem(
                    //   nameController.text,
                    //   descriptionController.text,
                    //   selectedCategory,
                    //   customUnit.text,
                    //   widget.itemId,
                    // );
                    showToast('Items Updated', color2);
                    Get.back();
                  }, 'Save')
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> customShowModalBottomSheetCategory(
    BuildContext context,
  ) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedBox02,
                customBoldText20W800Black('Select A Category'),
                sizedBox02,
                for (String category in categoryList) // Display categories
                  customRowTextcategory(category),
                customDivider(),
                sizedBox02,
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector customRowTextcategory(
    String text,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showCustom = false;
          selectedCategory = text;
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
}
