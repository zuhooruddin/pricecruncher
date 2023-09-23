import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/addNewItem.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/add_shoppinglist.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/priceHistory.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/vip_screen.dart';
import 'package:price_cruncher_new/models/categories.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/models/shopping_list.dart';
import 'package:price_cruncher_new/providers/shop_provider.dart';
import 'package:price_cruncher_new/services/database_services.dart';
import 'package:price_cruncher_new/services/item_services.dart';
import 'package:price_cruncher_new/services/list_services.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';

Container customTextFieldAuthentication(
  TextEditingController controller,
  String hintText,
  TextInputType? inputType,
  dynamic validation,
) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightBorderColorTextField)),
    child: TextFormField(
      controller: controller,
      keyboardType: inputType ?? TextInputType.name,
      style: const TextStyle(fontSize: 16),
      validator: validation,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    ),
  );
}

SizedBox customTextField(
  TextEditingController controller,
  TextInputType? inputType,
  String? hintText, [
  TextInputFormatter? textInputFormatter,
  Function(String)? onChange,
]) {
  return SizedBox(
    width: Get.width * 0.6,
    child: TextFormField(
      controller: controller,
      onChanged: onChange,
      keyboardType: inputType ?? TextInputType.name,
      inputFormatters: textInputFormatter != null
          ? [textInputFormatter]
          : null, // Use null if it's not provided
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText ?? '',
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(
          color: hintTextColor,
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Row customRowWithMinMaxText() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        'Minimum',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
      Text(
        'Maximum',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}

SizedBox customTextFieldSmall(TextEditingController controller,
    TextInputType? inputType, String? hintText) {
  return SizedBox(
    width: Get.width * 0.4,
    child: TextFormField(
      controller: controller,
      keyboardType: inputType ?? TextInputType.name,
      style: const TextStyle(fontSize: 14),
      onChanged: (value) {
        if (value.isNotEmpty) {
          controller.value = controller.value.copyWith(
            text: value[0].toUpperCase() + value.substring(1),
            selection: TextSelection.collapsed(offset: value.length),
          );
        }
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 12),
          hintText: hintText ?? '',
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
              color: hintTextColor, fontWeight: FontWeight.w300, fontSize: 16)),
    ),
  );
}

Expanded customTextFieldMoreSmalll(TextEditingController controller,
    TextInputType? inputType, String? hintText) {
  return Expanded(
    child: TextFormField(
      controller: controller,
      keyboardType: inputType ?? TextInputType.name,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 12),
          hintText: hintText ?? '',
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
              color: hintTextColor, fontWeight: FontWeight.w300, fontSize: 16)),
    ),
  );
}

Container customHalfContainerWithTextField(
    TextEditingController controller, TextInputFormatter textInputFormatter) {
  return Container(
    width: Get.width * 0.4,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: customTextField(
        controller, TextInputType.number, 'Quantity', textInputFormatter),
  );
}

Container customHalfContainerWithTextField2(TextEditingController controller) {
  return Container(
    width: Get.width * 0.46,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: customTextField(controller, null, 'Select'),
  );
}

Container customBlueRowContainer(String text) {
  return Container(
    width: Get.width,
    height: Get.height * 0.06,
    decoration: const BoxDecoration(color: Color(0xFF62A3D7)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        sizedBox002Width,
        sizedBox002Width,
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Row customRowText16W400Start(String text) {
  return Row(
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
  );
}

Future<Object?> customShowGeneralDialogToShowIncreaseDecreaseInCrunchPrice(
    BuildContext context,
    Function()? onTap1,
    Function()? onTap2,
    Function()? onTap3) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'Alert',
    barrierDismissible: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          height: Get.height * 0.5,
          width: Get.width * 0.9,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(25)),
          child: Column(
            children: [
              customTextContainerOfGeneralDialogToShowIncreaseAndDecrease(
                  'increase',
                  '\$ 0.40 / bags',
                  'This price is ',
                  '20% cheaper',
                  ' per unit than the previous best price'),
              sizedBox03,
              customSubmitContainer(onTap1, 'Save Price'),
              sizedBox02,
              customSubmitContainerWithBorderAndWhiteBackground(
                  onTap2, 'Close'),
              sizedBox02,
              customSubmitContainerWithBorderAndWhiteBackground(onTap3, 'Edit')
            ],
          ),
        ),
      );
    },
  );
}

InkWell customResetButtonFilterDialogHomeScreen(
    String text, Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width * 0.5,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}

Container customCategorySectionInFilterDialogHomeScreen(
  StateSetter setState,
) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: const Color(0xFFF3F0F0),
    ),
    child: Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          sizedBox002Width,
          sizedBox002Width,
          const Text(
            'Category',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      const Divider(
        thickness: 0.75,
        color: Color(0xFFEBDFDF),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  sizedBox002Width,
                  sizedBox002Width,
                  Text(
                    categoryList[index],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    color: white,
                    height: 25,
                    width: 25,
                    child: Checkbox(
                      value: true,
                      checkColor: switchAuth,
                      activeColor: white,
                      side: BorderSide(color: white),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  sizedBox002Width,
                  sizedBox002Width,
                ],
              ),
              Divider(
                thickness: 0.25,
                color: Color(0xFFEBDFDF),
              )
            ],
          );
        },
      )
    ]),
  );
}

Future<Object?> customShowGeneralDialogForAddingItemsToShoppingList(
    BuildContext context, AddItem addItem) {
  final shoppingLists =
      Provider.of<ShoppingListProvider>(context, listen: false);
  List<ShoppingList> lists = shoppingLists.shopList;
  return showGeneralDialog(
    barrierLabel: 'Alert',
    barrierDismissible: true,
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Container(
          height: Get.height * 0.7,
          width: Get.width * 0.8,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Add to Shopping List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              sizedBox02,
              InkWell(
                onTap: () async {
                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return AddNewShoppingList();
                  }));
                  result ? await shoppingLists.fetchItemsLists() : null;
                },
                child: Container(
                  width: Get.width * 0.5,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: ShapeDecoration(
                    color: const Color(0xFF272727),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Create new list',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              sizedBox02,
              const Divider(
                color: Color(0xFFDDDDDD),
              ),
              lists.length == 0
                  ? Center(
                      child: Text('No shopping list added yet!'),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: lists.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          ShoppingList shoppingList = lists[index];

                          List listOfItems = shoppingList.totalItems +
                              shoppingList.outstandingItems;
                          return GestureDetector(
                            onTap: () async {
                              if (listOfItems.contains(addItem.itemId)) {
                                showToast('Already added');
                              } else {
                                try {
                                  await LIstServices().addItemToBuy(
                                    addItem.itemId,
                                    shoppingList.docId,
                                    addItem.price == 'no price'
                                        ? 0
                                        : num.parse(addItem.price),
                                  );
                                  Navigator.pop(context);
                                  await shoppingLists.fetchItemsLists();
                                  showToast(
                                      'Item added to list : ${shoppingList.listName}');
                                } catch (e) {
                                  showToast('Error ${e.toString()}');
                                }
                              }
                            },
                            child: Container(
                              width: Get.width,
                              margin: EdgeInsets.only(top: 8),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 8),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 0.50,
                                      color: const Color(0xFFEBEBEB))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    shoppingList.listName,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF272727),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      '\$${shoppingList.price.toString()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
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
    },
  );
}

Row customMinMaxRowWithTextFields(
  TextEditingController controller1,
  TextEditingController controller2,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      const Spacer(),
      customTextFieldMinMaxInFilterWidgetHomeScreen(controller1),
      sizedBox002Width,
      Text(
        '-',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      sizedBox002Width,
      customTextFieldMinMaxInFilterWidgetHomeScreen(controller2),
      const Spacer(),
    ],
  );
}

Container customTextFieldMinMaxInFilterWidgetHomeScreen(
    TextEditingController controller2) {
  return Container(
    width: Get.width * 0.25,
    height: Get.height * 0.05,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration:
        BoxDecoration(color: white, borderRadius: BorderRadius.circular(20)),
    child: SizedBox(
      width: Get.width * 0.4,
      child: TextFormField(
        controller: controller2,
        keyboardType: TextInputType.name,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 12),
          hintText: '',
          enabledBorder: InputBorder.none,
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintStyle: TextStyle(
              color: hintTextColor, fontWeight: FontWeight.w300, fontSize: 16),
        ),
      ),
    ),
  );
}

Container customTextContainerInsideFloactingActionButtonHomeScreen(
    {required String text, String? itemId}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    width: Get.width,
    decoration: BoxDecoration(
      color: const Color(0xFFF9F9F9),
      border: Border.all(width: 0.50, color: const Color(0xFFE6E6E6)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

Widget customExpansionTileWidgetHomeScreen(
    {required String title, required Widget list}) {
  return ExpansionTile(
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
    initiallyExpanded: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
    ),
    children: [list],
  );
}

Future<Object?>
    customShowGeneralDialogHomeScreenWhenPressedOnFloatingActionButton(
        BuildContext context, AddItem item) async {
  final userProvider =
      await Provider.of<UserDataProvider>(context, listen: false);
  return showGeneralDialog(
    barrierLabel: 'Alert',
    barrierDismissible: true,
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Container(
          height: Get.height * 0.6,
          width: Get.width * 0.8,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                sizedBox03,
                InkWell(
                  onTap: () async {
                    await customShowGeneralDialogForAddingItemsToShoppingList(
                        context, item);
                  },
                  child:
                      customTextContainerInsideFloactingActionButtonHomeScreen(
                          text: 'Add to shopping list'),
                ),
                sizedBox01,
                InkWell(
                  onTap: () {
                    Get.to(AddNewItemScreen(
                      item: item,
                    ));
                  },
                  child:
                      customTextContainerInsideFloactingActionButtonHomeScreen(
                          text: 'Edit'),
                ),
                sizedBox01,
                InkWell(
                  onTap: () {
                    Get.to(const AddNewItemScreen());
                  },
                  child:
                      customTextContainerInsideFloactingActionButtonHomeScreen(
                          text: 'Add Item'),
                ),
                sizedBox01,
                InkWell(
                  onTap: () {
                    Get.to(PriceHistoryScreen());
                  },
                  child:
                      customTextContainerInsideFloactingActionButtonHomeScreen(
                          text: 'Price History'),
                ),
                sizedBox01,
                InkWell(
                  onTap: () {
                    ItemServices().deleteItem(item.itemId);
                    Navigator.of(context).pop();
                  },
                  child:
                      customTextContainerInsideFloactingActionButtonHomeScreen(
                          text: 'Delete', itemId: item.itemId),
                ),
                sizedBox01,
                InkWell(
                  onTap: () async {
                    if (userProvider.user!.favorites!.contains(item.itemId)) {
                      DatabaseServices()
                          .addAndRemoveFromFavorites(item.itemId, false);
                      Navigator.pop(context);
                      showToast('removed from favorites');
                    } else {
                      DatabaseServices()
                          .addAndRemoveFromFavorites(item.itemId, true);
                      Navigator.pop(context);
                      showToast('Added to favorites');
                    }
                    await userProvider.fetchUser();
                  },
                  child:
                      customTextContainerInsideFloactingActionButtonHomeScreen(
                          text: userProvider.user!.favorites!
                                  .contains(item.itemId)
                              ? 'Remove from favorites'
                              : 'Mark Favourite'),
                ),
                sizedBox01,
              ],
            ),
          ),
        ),
      );
    },
  );
}

// Future<dynamic> customShowModalBottomSheetCrunchPrice(BuildContext context) {
//   return showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     backgroundColor: white,
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40), topRight: Radius.circular(40))),
//     builder: (context) {
//       return Container(
//         height: Get.height * 0.78,
//         padding: const EdgeInsets.symmetric(vertical: 12),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               sizedBox02,
//               customBoldText20W800Black('Select A Unit'),
//               sizedBox02,
//               customBlueRowContainer('Weight'),
//               sizedBox02,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox01,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox01,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox01,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox02,
//               customBlueRowContainer('Volume/Capacity'),
//               sizedBox02,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox01,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox01,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox01,
//               customRowText16W400Start('Grams'),
//               customDivider(),
//               sizedBox02,
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

Container customContainerSelectedUnit(
    String? selectedUnit, String text, bool show) {
  return Container(
    width: Get.width * 0.45,
    padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          selectedUnit ?? text,
          style: const TextStyle(
            color: Color(0xFF040404),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        show
            ? const Icon(
                Icons.arrow_drop_down_rounded,
                size: 30,
                color: Color(0xFF3E3E3E),
              )
            : const SizedBox.shrink()
      ],
    ),
  );
}

Divider customDivider() {
  return const Divider(thickness: 0.5, color: Color(0xFFE3E3E3));
}

Text customBoldText20W800Black(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: black,
      fontSize: 18,
      fontWeight: FontWeight.w800,
    ),
  );
}

Container customTextFieldAuthenticationForPassword(
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    String hintText,
    TextInputType? inputType,
    bool showPassword,
    dynamic validation,
    Function()? onPressed) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightBorderColorTextField)),
    child: TextFormField(
      controller: passwordController,
      obscureText: showPassword,
      keyboardType: inputType ?? TextInputType.name,
      validator: validation,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(left: 6),
          icon: Icon(
            showPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
          onPressed: onPressed,
        ),
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(
            color: hintTextColor, fontWeight: FontWeight.w300, fontSize: 16),
      ),
    ),
  );
}

Container customTextFieldForPasswordSignin(
    TextEditingController passwordController,
    String hintText,
    TextInputType? inputType,
    bool showPassword,
    dynamic validation,
    Function()? onPressed) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lightBorderColorTextField)),
    child: TextFormField(
      controller: passwordController,
      obscureText: showPassword,
      validator: validation,
      keyboardType: inputType ?? TextInputType.name,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: IconButton(
          padding: const EdgeInsets.only(left: 6),
          icon: Icon(
            showPassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Color.fromRGBO(224, 224, 224, 1),
          ),
          onPressed: onPressed,
        ),
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: TextStyle(
            color: hintTextColor, fontWeight: FontWeight.w300, fontSize: 16),
      ),
    ),
  );
}

Container customItemContainerWithBestPrice(
  String text1,
  String text2,
  String text3,
  String text4,
  String text5,
  String text6,
) {
  return Container(
    width: Get.width * 0.75,
    height: Get.height * 0.28,
    padding: const EdgeInsets.all(12),
    decoration:
        BoxDecoration(color: black, borderRadius: BorderRadius.circular(12)),
    child: Column(
      children: [
        Text(
          text1,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFEFEFEF),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        sizedBox005,
        Text(
          text2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFB9B9B9),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        sizedBox03,
        Text(
          text3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFEFEFEF),
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
        sizedBox005,
        Text(
          text4,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFEFEFEF),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        sizedBox01,
        Text(
          text5,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFEFEFEF),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          text6,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFEFEFEF),
            fontSize: 10,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    ),
  );
}

Row customTopRowWithBackButton(
    Function()? onTap1, Function()? onTap2, bool isStarActive) {
  return Row(
    children: [
      InkWell(
        onTap: () {
          Get.back();
        },
        child: Image.asset(
          'assets/icons/back.png',
          width: getProportionateScreenWidth(12),
          height: getProportionateScreenWidth(12),
        ),
      ),
      const SizedBox(width: 20),
      Text('Price Cruncher',
          style: TextStyle(
            color: black,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          )),
      const Spacer(),
      isStarActive
          ? InkWell(
              onTap: onTap1,
              child: Image.asset('assets/images/staractive.png',
                  height: 30, width: 30),
            )
          : InkWell(
              onTap: onTap2,
              child: Image.asset('assets/images/starInactive.png',
                  height: 30, width: 30),
            )
    ],
  );
}

InkWell customSubmitContainer(Function()? onTap, String text) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width * 0.52,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration:
          BoxDecoration(color: black, borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: white, fontWeight: FontWeight.w800, fontSize: 15),
        ),
      ),
    ),
  );
}

InkWell customSubmitContainerWithLightBlack(Function()? onTap, String text) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width * 0.7,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: white, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    ),
  );
}

Row customRowWithHeadingAndTextFieldToEditItem(
    String text, TextEditingController controller) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      sizedBox002Width,
      sizedBox002Width,
      Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      const Spacer(),
      Container(
        width: Get.width * 0.46,
        height: Get.height * 0.06,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration:
            BoxDecoration(color: white, borderRadius: BorderRadius.circular(8)),
        child: text == 'Bar Code:'
            ? Row(
                children: [
                  customTextFieldMoreSmalll(controller, null, ''),
                  sizedBox001Width,
                  Image.asset(
                    'assets/images/barcode 1.png',
                    height: 20,
                  )
                ],
              )
            : customTextFieldSmall(controller, null, ''),
      ),
      sizedBox002Width,
      sizedBox002Width,
    ],
  );
}

Container customContainerEditItem(
    String text, Function()? onTap1, Function()? onTap2, bool isStarActive) {
  return Container(
    width: Get.width,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: const BoxDecoration(
        color: color2,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        )),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      isStarActive
          ? InkWell(
              onTap: onTap1,
              child: Image.asset('assets/images/staractive.png',
                  height: 30, width: 30),
            )
          : InkWell(
              onTap: onTap2,
              child: Image.asset('assets/images/starInactive.png',
                  height: 30, width: 30),
            )
    ]),
  );
}

InkWell customSubmitContainerSmall(Function()? onTap, String text) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width * 0.45,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration:
          BoxDecoration(color: black, borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: white, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
    ),
  );
}

Container customTextContainerOfGeneralDialogToShowIncreaseAndDecrease(
  String imagePath,
  String text1,
  String text2,
  String text3,
  String text4,
) {
  return Container(
    width: Get.width * 0.7,
    child: Stack(
      children: [
        Image.asset(
          'assets/images/${imagePath}.png',
        ),
        Column(
          children: [
            sizedBox02,
            Text(
              text1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            sizedBox03,
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: text2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: text3,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: text4,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ],
    ),
  );
}

InkWell customSubmitContainerWithBorderAndWhiteBackground(
    Function()? onTap, String text) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width * 0.53,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: black, width: 0.5),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
    ),
  );
}

InkWell customSubmitButtonAuthentication(String text, Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration:
          BoxDecoration(color: black, borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: white, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    ),
  );
}

Container customGoogleFbAppleContainer(String text, String imageName) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
        color: backgroundColorGoogleFacebookAppleContainer,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 0.5,
          color: borderColorGoogleFacebookAppleContainer,
        )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/${imageName}.png',
          height: 20,
        ),
        sizedBox002Width,
        Text(
          text,
          style: TextStyle(
              color: textColorGoogleFacebookAppleContainer,
              fontSize: 16,
              fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}

InkWell switchAuthSignInSignUp(Function()? onTap, String text) {
  return InkWell(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text == 'Sign In'
              ? 'Already have an account?  '
              : 'Dont have an account? ',
          style: TextStyle(
              color: switchAuth, fontWeight: FontWeight.w300, fontSize: 14),
        ),
        Text(
          text,
          style: TextStyle(
              color: switchAuth2, fontWeight: FontWeight.w400, fontSize: 14),
        )
      ],
    ),
  );
}

Row customBackButtonOnTopRight() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          Get.back();
        },
        child: CircleAvatar(
          backgroundColor: checkBoxBackGroundColor,
          radius: 20,
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      )
    ],
  );
}

Row customMainHeadingText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

Row customSubHeadingText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Color.fromRGBO(92, 92, 92, 1)),
        ),
      ),
    ],
  );
}

Center customLogoInCenter() {
  return Center(
    child: Image.asset(
      'assets/logo.png',
      width: Get.width * 0.4,
      height: Get.height * 0.19,
    ),
  );
}

Center customImagePickerContainer(File? image, Function()? onTap) {
  return Center(
    child: Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: image != null
              ? FileImage(image) as ImageProvider<Object>
              : AssetImage('assets/images/circleAvatarBackgrounImage.png'),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: onTap,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 4, // soften the shadow
                    spreadRadius: 0, //extend the shadow
                    offset: Offset(
                      0.0, //X
                      4.0, //Y
                    ),
                  )
                ]),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: white,
                  child: const Icon(
                    Icons.edit,
                    color: Color.fromRGBO(41, 45, 50, 1),
                  ),
                ),
              ),
            ))
      ],
    ),
  );
}

Row customHomeScreenTopSearchBarAndFilter(
    Function()? onTap, TextEditingController controller,
    [Function(String)? onChange]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        width: Get.width * 0.65,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(242, 242, 242, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: customTextField(controller, null, 'Search', null, onChange),
      ),
      InkWell(
        onTap: onTap,
        child: Image.asset(
          'assets/images/filter.png',
          height: 25,
          width: 25,
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.to(VipScreen());
        },
        child: Image.asset(
          'assets/images/crown.png',
          height: 35,
          width: 35,
        ),
      ),
    ],
  );
}

Row customTopRowWithBackButtonAndCrownImage(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          Get.back();
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 20,
          child: Icon(
            Icons.arrow_back,
            color: black,
          ),
        ),
      ),
      const SizedBox(width: 20),
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      ),
      Spacer(),
      Image.asset(
        'assets/images/crown.png',
        height: 40,
        width: 40,
      ),
    ],
  );
}

InkWell customFloatingActionButtonHomeScreenOpenAlertDialog(Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 28,
            offset: Offset(0, 2),
            spreadRadius: 2,
          )
        ],
      ),
      child: CircleAvatar(
        backgroundColor: white,
        radius: 35,
        child: Icon(
          Icons.add,
          color: black,
          size: 30,
        ),
      ),
    ),
  );
}

Widget customExpansionTileChildrenWidget(
  String itemName,
  String date,
  String storeName,
  String priceAndUnits,
  String pricePerUnit,
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
                  fontSize: 16,
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
          Column(
            children: [
              Text(
                storeName,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              sizedBox01,
              Text(
                priceAndUnits,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),
              sizedBox01,
              Text(
                pricePerUnit,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      )
    ]),
  );
}

Row customCheckBoxContainer(void Function(bool?)? onChanged, bool checkBox) {
  return Row(
    children: [
      Container(
        color: checkBoxBackGroundColor,
        height: 25,
        width: 25,
        child: Checkbox(
          value: checkBox,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          checkColor: switchAuth,
          activeColor: checkBoxBackGroundColor,
          side: BorderSide(color: checkBoxBackGroundColor),
          onChanged: onChanged,
        ),
      ),
      sizedBox002Width,
      const Expanded(
        child: Text(
          'By signing up, you\'re agree to our Terms & Conditions and Privacy Policy',
          style:
              TextStyle(fontSize: 12, color: Color.fromRGBO(152, 152, 152, 1)),
        ),
      ),
    ],
  );
}

Row customContainerTopHeadingText(String text) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          color: crunchPriceTextColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      )
    ],
  );
}

Container customDateTimeContainer(DateTime? datePicked) {
  return Container(
    width: Get.width,
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Text(
          datePicked != null
              ? DateFormat('dd MMMM yyyy').format(datePicked)
              : 'Today (Default)',
          style: const TextStyle(
            color: Color(0xFF040404),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

Row customRowBulkPackaging(
    Function(bool?)? onChanged, bool checkBox, String text) {
  return Row(
    children: [
      const Spacer(),
      Container(
        color: checkBoxBackGroundColor,
        height: 20,
        width: 20,
        child: Checkbox(
          value: checkBox,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          checkColor: switchAuth,
          activeColor: checkBoxBackGroundColor,
          side: BorderSide(color: checkBoxBackGroundColor),
          onChanged: onChanged,
        ),
      ),
      sizedBox002Width,
      Text(
        text,
        style: TextStyle(
          color: black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      )
    ],
  );
}

Container ProfileScreenContainer(String text) {
  return Container(
    height: 55,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: textFieldBorderColor),
    ),
    child: Padding(
      padding: EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            color: darkGrey,
          ),
        ),
      ),
    ),
  );
}
