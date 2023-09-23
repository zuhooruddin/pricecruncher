import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/providers/shop_provider.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/Store/openStore.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:provider/provider.dart';

import '../add_shop.dart';
import '../shoppingScreen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    final shops = Provider.of<ShopProvider>(context);

    List<Shop> shopsList = shops.shopList;
    return Scaffold(
      appBar: CustomAppBar().buildAppBar(title: 'Stores'),
      backgroundColor: white,
      floatingActionButton: CustomFloatingButton(
        onTap: () {
          Get.to(AddNewShop());
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              shopsList.length == 0
                  ? Center(
                      child: Text('No Stores added yet!'),
                    )
                  : ListView.builder(
                      itemCount: shopsList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String shopName = shopsList[index].name;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(OpenStoreScreen(storeName: shopName));
                              },
                              child: Container(
                                width: Get.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 18),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 0.50,
                                      color: const Color(0xFFEAEAEA),
                                    )),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    sizedBox002Width,
                                    Text(
                                      shopName,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            sizedBox015
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
