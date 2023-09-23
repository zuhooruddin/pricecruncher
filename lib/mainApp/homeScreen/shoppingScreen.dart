import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/add_shoppinglist.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/invite_screen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/shopping_list.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:price_cruncher_new/shared/custom_button.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_list.dart';
import '../../providers/shop_provider.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    final listProvider = Provider.of<ShoppingListProvider>(context);

    listProvider.fetchItemsLists();

    List<ShoppingList> shoppingLists = listProvider.shopList;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: CustomFloatingButton(
        onTap: () {
          Get.to(AddNewShoppingList());
        },
      ),
      appBar: CustomAppBar().buildAppBar(title: 'Shopping List'),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              onTap: () {
                Get.to(InviteList());
              },
              title: 'Invites',
            ),
            buildVerticalSpace(12),
            shoppingLists.length == 0
                ? Center(
                    child: Text('No Shopping lists added yet!'),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: shoppingLists.length,
                      itemBuilder: (context, index) {
                        ShoppingList list = shoppingLists[index];
                        return GestureDetector(
                          onTap: () => Get.to(ListDetails(
                            docId: list.docId,
                          )),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: getProportionateScreenWidth(04)),
                            padding: EdgeInsets.only(
                                left: 21, top: 15, bottom: 15, right: 10),
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list.listName,
                                        style: customHeadingStyle.copyWith(
                                            fontSize:
                                                getProportionateScreenWidth(18),
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        '${list.outstandingItems.length.toString()} item outstanding',
                                        style: customStyle.copyWith(
                                            fontSize:
                                                getProportionateScreenWidth(10),
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  flex: 6,
                                ),
                                Expanded(
                                  child: Container(
                                    width: getProportionateScreenWidth(57),
                                    height: getProportionateScreenWidth(46),
                                    decoration: BoxDecoration(
                                        color: lightGrey,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.3),
                                            width: 0.5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 1))
                                        ]),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          (list.totalItems.length +
                                                  list.outstandingItems.length)
                                              .toString(),
                                          style: customHeadingStyle.copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      14),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          'Total Items',
                                          style: customHeadingStyle.copyWith(
                                              fontSize:
                                                  getProportionateScreenWidth(
                                                      8),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                buildHorizontalSpace(6),
                                Expanded(
                                  child: Container(
                                    width: getProportionateScreenWidth(70),
                                    height: getProportionateScreenWidth(46),
                                    decoration: BoxDecoration(
                                      color: darker,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Color(0xfff2f2f2), width: 0.5),
                                    ),
                                    child: Center(
                                        child: Text(
                                      '\$${list.price.toString()}',
                                      style: customHeadingStyle.copyWith(
                                          fontSize:
                                              getProportionateScreenWidth(10),
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    )),
                                  ),
                                  flex: 3,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomFloatingButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: getProportionateScreenWidth(65)),
        width: getProportionateScreenWidth(65),
        height: getProportionateScreenWidth(65),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400]!,
                offset: Offset(0, 0),
                blurRadius: 14,
                spreadRadius: 3,
              ),
            ]),
        child: Center(
          child: Icon(
            Icons.add,
            size: getProportionateScreenWidth(34),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

// Expanded(
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Get.to(TestList());
//                     },
//                     child: Container(
//                       margin: EdgeInsets.symmetric(
//                           vertical: getProportionateScreenWidth(04)),
//                       padding: EdgeInsets.only(
//                           left: 21, top: 15, bottom: 15, right: 10),
//                       decoration: BoxDecoration(
//                         color: lightGrey,
//                         borderRadius: BorderRadius.circular(15),
//                         border: Border.all(color: Colors.grey, width: 0.5),
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Test',
//                                   style: customHeadingStyle.copyWith(
//                                       fontSize: getProportionateScreenWidth(18),
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 // buildVerticalSpace(3),
//                                 Text(
//                                   '10 item outstanding',
//                                   style: customStyle.copyWith(
//                                       fontSize: getProportionateScreenWidth(10),
//                                       fontWeight: FontWeight.w300),
//                                 ),
//                               ],
//                             ),
//                             flex: 3,
//                           ),
//                           Expanded(
//                             child: Container(
//                               width: getProportionateScreenWidth(57),
//                               height: getProportionateScreenWidth(46),
//                               decoration: BoxDecoration(
//                                   color: lightGrey,
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(
//                                       color: Colors.grey.withOpacity(0.3),
//                                       width: 0.5),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.grey,
//                                         offset: Offset(0, 1))
//                                   ]),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     '20',
//                                     style: customHeadingStyle.copyWith(
//                                         fontSize:
//                                             getProportionateScreenWidth(16),
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                   Text(
//                                     'Total Items',
//                                     style: customHeadingStyle.copyWith(
//                                         fontSize:
//                                             getProportionateScreenWidth(8),
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             flex: 1,
//                           ),
//                           buildHorizontalSpace(6),
//                           Expanded(
//                             child: Container(
//                               width: getProportionateScreenWidth(57),
//                               height: getProportionateScreenWidth(46),
//                               decoration: BoxDecoration(
//                                 color: darker,
//                                 borderRadius: BorderRadius.circular(5),
//                                 border: Border.all(
//                                     color: Color(0xfff2f2f2), width: 0.5),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 '\$350',
//                                 style: customHeadingStyle.copyWith(
//                                     fontSize: getProportionateScreenWidth(16),
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.white),
//                               )),
//                             ),
//                             flex: 1,
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
