import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/services/shop_services.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../providers/shop_provider.dart';

class AddNewShop extends StatefulWidget {
  AddNewShop({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewShop> createState() => _AddNewShopState();
}

class _AddNewShopState extends State<AddNewShop> {
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

  bool scroll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Add Shop',
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
                        "Add Shop",
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
                        'Shop Name',
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
                  sizedBox05,
                  customSubmitContainerSmall(
                    () async {
                      if (nameController.text.isNotEmpty) {
                        setState(() {
                          scroll = true;
                        });

                        final provider = await Provider.of<ShopProvider>(
                            context,
                            listen: false);



                        final shopNamesSet = provider.shopList
                            .map((shopModel) => shopModel.name)
                            .toSet();

                        if (!shopNamesSet.contains(nameController.text)) {
                          showLoader(context);
                          // Create the shop only if the name is not in the set
                          ShopServices().createShop(nameController.text);
                          await provider.fetchShopsFromLocation();
                          // setState(() {
                          //   scroll = false;
                          // });
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showToast('Shop Added', color2);
                        }else{
                          showToast('Already added');
                        }

                      } else {
                        showToast('Enter shop name', Colors.red);
                      }
                    },
                    'Add Shop',
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
