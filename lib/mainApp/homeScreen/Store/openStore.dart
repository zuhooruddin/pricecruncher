import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';

import '../../../models/items_model.dart';
import '../../../services/item_services.dart';
import '../../../utils/size_confiq.dart';
import '../../crunchPriceScreens/crunchPriceEditItem.dart';

class OpenStoreScreen extends StatefulWidget {
  const OpenStoreScreen({required this.storeName, super.key});
  final String storeName;
  @override
  State<OpenStoreScreen> createState() => _OpenStoreScreenState();
}

class _OpenStoreScreenState extends State<OpenStoreScreen> {
  Map<String, List<AddItem>> groupItemsByCategory(List<AddItem> items) {
    Map<String, List<AddItem>> categoryItems = {};

    for (var item in items) {
      if (!categoryItems.containsKey(item.category)) {
        categoryItems[item.category] = [];
      }
      categoryItems[item.category]!.add(item);
    }
    return categoryItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customTopRowWithBackButtonAndCrownImage(widget.storeName),
                sizedBox05,
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream:
                      ItemServices().getItemsStreamForStore(widget.storeName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    final items = snapshot.data!.docs
                        .map((doc) => AddItem.fromMap(doc.data()))
                        .toList();
                    Map<String, List<AddItem>> categoryItems =
                        groupItemsByCategory(items);

                    if (items.length == 0) {
                      return Center(
                        child: Text('No items added yet'),
                      );
                    }

                    return Column(
                      children: [
                        for (var category in categoryItems.keys)
                          Column(
                            children: [
                              customExpansionTileWidgetHomeScreen(
                                title: category,
                                list: ListView.builder(
                                  itemCount: categoryItems[category]!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final item =
                                        categoryItems[category]![index];

                                    String formattedDate =
                                        DateFormat('MMM MM,yyyy')
                                            .format(item.dateTime);

                                    return GestureDetector(
                                      onLongPress: () async {
                                        await customShowGeneralDialogHomeScreenWhenPressedOnFloatingActionButton(
                                            context, item);
                                      },
                                      onTap: () {
                                        Get.to(CrunchPrice(
                                          item: item,
                                        ));
                                      },
                                      child: customExpansionTileChildrenWidget(
                                        item.itemName,
                                        formattedDate,
                                        item.storeName,
                                        item.price == 'no price'
                                            ? 'no price'
                                            : '\$ ${item.price} / ${item.quantity} x ${item.unit}',
                                        item.price == 'no price'
                                            ? 'history'
                                            : '\$${(num.parse(item.price) / item.quantity).toStringAsFixed(3)} / ${item.unit.substring(0, item.unit.length - 1)}',
                                      ),
                                    );
                                  },
                                ),
                              ),
                              sizedBox02,
                            ],
                          ),
                        buildVerticalSpace(51),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
