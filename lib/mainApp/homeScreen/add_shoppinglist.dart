import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/services/list_services.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

class AddNewShoppingList extends StatefulWidget {
  AddNewShoppingList({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewShoppingList> createState() => _AddNewShoppingListState();
}

class _AddNewShoppingListState extends State<AddNewShoppingList> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Add Shopping list',
          context: context,
          fromVip: false,
          fontSize: getProportionateScreenWidth(24)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              sizedBox03,
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: const BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add Shopping List",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ]),
              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'List Name',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.6,
                        height: Get.height * 0.06,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8)),
                        child: customTextFieldSmall(
                            nameController, TextInputType.text, ''),
                      ),
                    ],
                  ),
                  sizedBox02,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Description',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.6,
                        height: Get.height * 0.06,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8)),
                        child: SizedBox(
                          width: Get.width * 0.4,
                          child: TextFormField(
                            controller: descriptionController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(bottom: 10),
                                hintText: 'Optional',
                                enabledBorder: InputBorder.none,
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: hintTextColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizedBox05,
                  customSubmitContainerSmall(() async {
                    if (nameController.text.isNotEmpty) {
                      LIstServices().addListToFirebase(
                          nameController.text, descriptionController.text);
                      showToast('Shopping List Added', color2);
                      Navigator.pop(context, true);
                    } else {
                      showToast('Enter list name', Colors.red);
                    }
                  }, 'Add List')
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
