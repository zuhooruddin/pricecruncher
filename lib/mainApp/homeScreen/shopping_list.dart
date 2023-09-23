import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/addNewItem.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/inivite_collaborator.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/shoppingScreen.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/models/shopping_list.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/services/item_services.dart';
import 'package:price_cruncher_new/services/list_services.dart';
import 'package:price_cruncher_new/shared/custom_button.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

import '../../shared/custom_appBar.dart';
import '../../shared/dialog.dart';
import '../../utils/customContainers.dart';

class ListDetails extends StatefulWidget {
  final String docId;
  ListDetails({super.key, required this.docId});

  @override
  State<ListDetails> createState() => _ListDetailsState();
}

class _ListDetailsState extends State<ListDetails> {
  bool selected = false;

  void function(
    List<String> added,
  ) async {
    List<String> selectedItems = [];
    num price = 0;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter customSetState) {
              return AlertDialog(
                contentPadding:
                    EdgeInsets.only(bottom: getProportionateScreenWidth(21)),
                insetPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(getProportionateScreenWidth(20)),
                ),
                title: Center(
                  child: Text(
                    'List Of Existing Items',
                    style: customHeadingStyle.copyWith(
                      fontSize: getProportionateScreenWidth(20),
                    ),
                  ),
                ),
                content: Container(
                  margin: EdgeInsets.only(top: 12),
                  width: SizeConfig.screenWidth,
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(21)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: CustomButton(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return AddNewItemScreen();
                            }));
                          },
                          title: 'Add New Item',
                        )),
                        buildVerticalSpace(10),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(31)),
                            child: Divider(),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(15),
                                vertical: getProportionateScreenWidth(18)),
                            width: Get.width * 0.65,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(242, 242, 242, 1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: customTextField(search, null, 'Search'),
                          ),
                        ),
                        Container(
                          height: Get.height * 0.4,
                          child: StreamBuilder(
                              stream: ItemServices()
                                  .fetchAllItemsThroughStream(added),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text('.....'),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(snapshot.error.toString()),
                                  );
                                }
                                List<AddItem> itemsList =
                                    snapshot.data as List<AddItem>;

                                return itemsList.length == 0
                                    ? Container(
                                        height: Get.height * 0.4,
                                        color: Color.fromRGBO(235, 235, 235, 1),
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 31,
                                        ),
                                        child: Center(
                                            child: Text('No Items added yet!')),
                                      )
                                    : ListView.builder(
                                        itemCount: itemsList.length,
                                        itemBuilder: (context, index) {
                                          AddItem item = itemsList[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: ItemContainer(
                                              item: item,
                                              onTap: () {
                                                try {
                                                  customSetState(() {
                                                    if (selectedItems.contains(
                                                        item.itemId)) {
                                                      selectedItems
                                                          .remove(item.itemId);
                                                      price -=
                                                          num.parse(item.price);
                                                    } else {
                                                      selectedItems
                                                          .add(item.itemId);
                                                      price +=
                                                          num.parse(item.price);
                                                    }
                                                  });
                                                } catch (e) {
                                                  showToast('Error $e');
                                                }
                                              },
                                              tickColor: selectedItems
                                                      .contains(item.itemId)
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          );
                                        });
                              }),
                        ),

                        buildVerticalSpace(21),
                        selectedItems.length == 0
                            ? SizedBox()
                            : Center(
                                child: CustomButton(
                                height: 40,
                                onTap: () {
                                  try {
                                    LIstServices().addItemsToBuy(
                                      selectedItems,
                                      widget.docId,
                                      price,
                                    );
                                    Navigator.pop(context);
                                    showToast('Items added}');
                                  } catch (e) {
                                    showToast('Error $e');
                                  }
                                },
                                title: 'Add To List',
                              )),
                        // expansionTilesBarCodeScreen(),
                        // sizedBox02,
                        // expansionTilesBarCodeScreen(),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: LIstServices().fetchListData(widget.docId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: Text('.....'),
              ),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }

          var doc = snapshot.data;

          ShoppingList shoppingList = ShoppingList.fromMap(doc!);

          List<String> addedDocIds =
              shoppingList.totalItems + shoppingList.outstandingItems;
          return Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: CustomFloatingButton(
              onTap: () {
                function(addedDocIds);
              },
            ),
            appBar: CustomAppBar2().buildAppBar2(
                title: shoppingList.listName, context: context, fromVip: false),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15)),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: shoppingList.collaborator ==
                            AuthServicesNew().getEmail()
                        ? PinkBall()
                        : shoppingList.collaborator == ''
                            ? CustomButton(
                                width: getProportionateScreenWidth(110),
                                onTap: () {
                                  Get.to(InviteCollaborator(
                                    shoppingList: shoppingList,
                                  ));
                                },
                                title: 'Add Collaborator',
                              )
                            : GestureDetector(
                                child: PinkBall(),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ClassicConfirmationDialog(
                                        listId: shoppingList.docId,
                                      );
                                    },
                                  );
                                },
                              ),
                  ),
                  buildVerticalSpace(12),
                  CustomExpansionTileWidgetHomeScreen(
                    docId: widget.docId,
                    listOfIds: shoppingList.outstandingItems,
                    toBuy: true,
                  ),
                  buildVerticalSpace(12),
                  Text(
                    '(Remaining: ${shoppingList.outstandingItems.length.toString()} Items)',
                    style: customHeadingStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenWidth(14),
                        color: darkGrey),
                  ),
                  buildVerticalSpace(31),
                  CustomExpansionTileWidgetHomeScreen(
                    listOfIds: shoppingList.totalItems,
                    docId: widget.docId,
                    toBuy: false,
                  ),
                  buildVerticalSpace(12),
                  Text(
                    '(Bought: ${shoppingList.totalItems.length.toString()} Items)',
                    style: customHeadingStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenWidth(14),
                        color: darkGrey),
                  )
                ],
              ),
            ),
          );
        });
  }

  List selected1 = [];

  List selected2 = [];

  final search = TextEditingController();

  ExpansionTile expansionTilesBarCodeScreen() {
    return ExpansionTile(
      collapsedShape: roundedRectangleBorder,
      collapsedBackgroundColor: color2,
      iconColor: white,
      collapsedIconColor: white,
      backgroundColor: color2,
      shape: roundedRectangleBorder,
      title: const Text(
        'Apparel',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      ),
      children: [
        expansionTileWidget(
          'Ketchup',
          'April, 26, 2023',
        ),
      ],
    );
  }

  Container expansionTileWidget(
    String itemName,
    String date,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(235, 235, 235, 1),
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        )
      ]),
    );
  }
}

class PinkBall extends StatelessWidget {
  const PinkBall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(31),
      height: getProportionateScreenWidth(31),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFB7B7), Color(0xFFFF78E9)],
        ),
      ),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final AddItem item;
  final VoidCallback onTap;
  final Color tickColor;
  const ItemContainer(
      {Key? key,
      required this.item,
      required this.onTap,
      required this.tickColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        color: Color.fromRGBO(235, 235, 235, 1),
        // borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.itemName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                item.price == 'no price'
                    ? 'no price'
                    : '\$${item.price}/ ${item.price} x ${item.quantity} ${item.unit}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                item.price == 'no price'
                    ? 'history'
                    : '\$${(item.quantity / num.parse(item.price)).toStringAsFixed(3)} / ${item.unit.substring(0, item.unit.length - 1)}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: getProportionateScreenWidth(34),
              height: getProportionateScreenWidth(34),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Image.asset(
                'assets/icons/tick.png',
                width: getProportionateScreenWidth(23),
                height: getProportionateScreenWidth(23),
                color: tickColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomExpansionTileWidgetHomeScreen extends StatefulWidget {
  final List listOfIds;
  final bool toBuy;
  final String docId;
  const CustomExpansionTileWidgetHomeScreen(
      {Key? key,
      required this.listOfIds,
      required this.toBuy,
      required this.docId})
      : super(key: key);

  @override
  State<CustomExpansionTileWidgetHomeScreen> createState() =>
      _CustomExpansionTileWidgetHomeScreenState();
}

class _CustomExpansionTileWidgetHomeScreenState
    extends State<CustomExpansionTileWidgetHomeScreen> {
  List ids = [];
  double rate = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AddItem>>(
        stream: ItemServices().fetchUsersThroughIdsStream(widget.listOfIds),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('.....'),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          List<AddItem> itemsList = snapshot.data as List<AddItem>;

          num total = 0;

          for (int i = 0; i < itemsList.length; i++) {
            total += itemsList[i].price == 'no price'
                ? 0
                : double.parse(itemsList[i].price);
          }

          return ExpansionTile(
            initiallyExpanded: true,
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            collapsedBackgroundColor: color2,
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            backgroundColor: color2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: Text(
              widget.toBuy
                  ? 'To buy(\$${total.toString()})'
                  : 'Bought(\$${total.toString()})',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            children: [
              Container(
                child: itemsList.length == 0
                    ? Container(
                        color: Color.fromRGBO(235, 235, 235, 1),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 31,
                        ),
                        child: Center(child: Text('No Items added yet!')),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            itemCount: itemsList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              AddItem item = itemsList[index];
                              return ItemContainer(
                                tickColor: ids.contains(item.itemId)
                                    ? Colors.black
                                    : Colors.white,
                                item: item,
                                onTap: () {
                                  setState(() {
                                    if (ids.contains(item.itemId)) {
                                      ids.remove(item.itemId);
                                    } else {
                                      ids.add(item.itemId);
                                    }
                                    log(ids.toString());
                                  });
                                },
                              );
                            },
                          ),
                          ids.length == 0
                              ? SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(235, 235, 235, 1),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: getProportionateScreenWidth(1),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (widget.toBuy) {
                                          try {
                                            LIstServices().addItemToBought(
                                              ids,
                                              widget.docId,
                                            );
                                          } catch (e) {
                                            showToast('Error $e');
                                          }
                                        } else {
                                          try {
                                            LIstServices().addItemToBuyAgain(
                                              ids,
                                              widget.docId,
                                            );
                                          } catch (e) {
                                            showToast('Error $e');
                                          }
                                        }
                                      },
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.black,
                                        size: getProportionateScreenWidth(31),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
              )
            ],
          );
        });
  }
}
