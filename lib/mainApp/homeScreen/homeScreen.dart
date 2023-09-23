import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:price_cruncher_new/mainApp/crunchPriceScreens/crunchPriceEditItem.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/addNewItem.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/shoppingScreen.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/vip_screen.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/services/auth_services.dart';
import 'package:price_cruncher_new/services/item_services.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../models/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchQueryController;
  late TextEditingController fullNameController;
  late TextEditingController minFilterController;
  late TextEditingController maxFilterController;
  List<bool> checkBoxBoolsForFilterSection = List.generate(8, (index) => false);
  bool showPassword = true;

  @override
  void dispose() {
    _searchQueryController.dispose();
    fullNameController.dispose();
    minFilterController.dispose();
    maxFilterController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _searchQueryController = TextEditingController(text: '');
    minFilterController = TextEditingController();
    fullNameController = TextEditingController();
    maxFilterController = TextEditingController();
    fetchUserData();
    super.initState();
  }

  Future fetchUserData() async {
    await AuthServices.of(context).fetchUserData();
  }

  Map<String, List<AddItem>> groupItemsByCategory(List<AddItem> items) {
    Map<String, List<AddItem>> categoryItems = {};

    // Group items by category
    for (var item in items) {
      if (!categoryItems.containsKey(item.category)) {
        categoryItems[item.category] = [];
      }
      categoryItems[item.category]!.add(item);
    }

    // Sort categories alphabetically
    List<String> sortedCategories = categoryItems.keys.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    // Create a new map with sorted categories
    Map<String, List<AddItem>> sortedCategoryItems = {};
    for (var category in sortedCategories) {
      sortedCategoryItems[category] = categoryItems[category]!;
    }

    return sortedCategoryItems;
  }

  String _searchQuery = '';

  bool filter = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      appBar: CustomAppBar4().buildAppBar(title: 'Item List'),
      backgroundColor: white,
      floatingActionButton: CustomFloatingButton(
        onTap: () {
          Get.to(
            AddNewItemScreen(),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: Get.width * 0.65,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      // controller: _searchQueryController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                        log(_searchQuery);
                      },
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Search here...',
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
                  ),
                  InkWell(
                    onTap: () async {
                      await customShowGeneralDialogFilterSectionHomeScreen();
                    },
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
              ),
              sizedBox05,
              StreamBuilder<List<AddItem>>(
                stream: filter
                    ? ItemServices().getItemsStreamModelsFiltered(
                        selectedCategories,
                        minFilterController.text,
                        maxFilterController.text,
                        provider.user!.favorites!,
                      )
                    : ItemServices().getItemsStreamModels(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  List<AddItem> items = snapshot.data as List<AddItem>;

                  if (_searchQuery != '' && _searchQuery.isNotEmpty) {
                    items = items
                        .where((user) =>
                            user.itemName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()) ||
                            user.itemName
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                        .toList();
                  }

                  Map<String, List<AddItem>> categoryItems =
                      groupItemsByCategory(items);

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
                                  final item = categoryItems[category]![index];

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
                                      item.price == 'no price '
                                          ? item.price
                                          : '\$ ${item.price} / ${item.quantity} x ${item.unit}',
                                      item.price == 'no price'
                                          ? 'history'
                                          : '\$${(double.parse(item.price) / item.quantity).toStringAsFixed(3)} / ${item.unit.substring(0, item.unit.length - 1)}',
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
    );
  }

  List selectedCategories = [];
  Future<Object?> customShowGeneralDialogFilterSectionHomeScreen() {
    return showGeneralDialog(
      barrierLabel: 'Alert',
      barrierDismissible: true,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, customSetState) => Dialog(
            insetPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Container(
              height: Get.height * 0.8,
              width: Get.width,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Filters',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(28),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    sizedBox02,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF3F0F0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              sizedBox002Width,
                              sizedBox002Width,
                              const Text(
                                'Price',
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
                          sizedBox01,
                          customMinMaxRowWithTextFields(
                              minFilterController, maxFilterController),
                          sizedBox01,
                          customRowWithMinMaxText()
                        ],
                      ),
                    ),
                    sizedBox02,
                    Container(
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
                                        value: selectedCategories
                                                .contains(categoryList[index])
                                            ? true
                                            : false,
                                        checkColor: switchAuth,
                                        activeColor: white,
                                        side: BorderSide(color: white),
                                        onChanged: (value) {
                                          customSetState(() {
                                            if (selectedCategories.contains(
                                                categoryList[index])) {
                                              selectedCategories.remove(
                                                  selectedCategories[index]);
                                            } else {
                                              selectedCategories
                                                  .add(categoryList[index]);
                                            }
                                            print(selectedCategories.length);
                                          });
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
                    ),
                    sizedBox01,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF3F0F0),
                      ),
                      child: Row(
                        children: [
                          sizedBox002Width,
                          sizedBox002Width,
                          const Text(
                            'Favorite',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            color: white,
                            height: 25,
                            width: 25,
                            child: Checkbox(
                              value: favorites,
                              checkColor: switchAuth,
                              activeColor: white,
                              side: BorderSide(color: white),
                              onChanged: (value) {
                                customSetState(() {
                                  favorites = !favorites;
                                });
                              },
                            ),
                          ),
                          sizedBox002Width,
                          sizedBox002Width,
                        ],
                      ),
                    ),
                    sizedBox05,
                    customSubmitContainer(() {
                      Get.back();
                    }, 'Apply Filters'),
                    sizedBox02,
                    customResetButtonFilterDialogHomeScreen('Reset', () {
                      customSetState(() {
                        selectedCategories = [];
                        filter = false;
                        minFilterController.text = '';
                        maxFilterController.text = '';
                        favorites = false;
                      });
                    }),
                    sizedBox02,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool favorites = false;
}

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only digits from 0 to 9 and a dot (.) at most once
    final filteredValue = newValue.text;

    // Remove any non-numeric characters except dot
    final numericValue = filteredValue.replaceAll(RegExp(r'[^0-9.]'), '');

    // Check if the dot occurs more than once
    final dotCount = numericValue.split('.').length - 1;

    // If the dot occurs more than once, remove the extra dots
    if (dotCount > 1) {
      final parts = numericValue.split('.');
      final integerPart = parts[0];
      final decimalPart = parts[1];
      return TextEditingValue(
        text: '$integerPart.$decimalPart',
        selection: TextSelection.collapsed(
          offset: '$integerPart.$decimalPart'.length,
        ),
      );
    }

    return TextEditingValue(
      text: numericValue,
      selection: TextSelection.collapsed(offset: numericValue.length),
    );
  }
}
