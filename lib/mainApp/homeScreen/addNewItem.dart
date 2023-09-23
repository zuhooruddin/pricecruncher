import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/models/items_model.dart';
import 'package:price_cruncher_new/providers/loader_provider.dart';
import 'package:price_cruncher_new/services/item_services.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../models/categories.dart';
import '../../providers/shop_provider.dart';
import 'homeScreen.dart';

class AddNewItemScreen extends StatefulWidget {
  final AddItem? item;
  const AddNewItemScreen({super.key, this.item});

  @override
  State<AddNewItemScreen> createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  bool isStarActive = false;
  bool showCustom = false;
  bool showPassword = true;
  bool showConfirmPassword = true;
  bool checkBox = false;
  bool checkBoxSalePrice = false;
  String selectedCategory = 'Select a Category';
  DateTime datePicked = DateTime.now();
  String selectedUnit = 'Grams';
  TextEditingController priceController = TextEditingController();
  TextEditingController customController = TextEditingController(text: '');
  TextEditingController quantityController = TextEditingController(text: '');
  TextEditingController brandController = TextEditingController(text: '');
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController barcodeController = TextEditingController(text: '');
  TextEditingController descriptionController = TextEditingController(text: '');
  TextEditingController customUnit = TextEditingController(text: '');

  @override
  void initState() {
    if (widget.item != null) {
      priceController.text = widget.item!.price.toString();
      customController.text = widget.item!.unit.toString();
      quantityController.text = widget.item!.quantity.toString();
      brandController.text = widget.item!.brandName;
      nameController.text = widget.item!.itemName;
      barcodeController.text = widget.item!.barcode;
      descriptionController.text = widget.item!.itemDescription;
      customUnit.text = widget.item!.unit;
      store = widget.item!.storeName;
      checkBox = widget.item!.bulkPackaging;
      datePicked = widget.item!.dateTime;
      selectedCategory = widget.item!.category;
    }
    super.initState();
  }

  @override
  void dispose() {
    priceController.dispose();
    quantityController.dispose();
    brandController.dispose();
    customController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    customUnit.dispose();
    barcodeController.dispose();
    super.dispose();
  }

  String? store;

  @override
  Widget build(BuildContext context) {
    final shops = Provider.of<ShopProvider>(context);
    return Scaffold(
      backgroundColor: white,
      body: Consumer<LoaderProvider>(
        builder: (_, loading, child) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(10),
                  ),
                  color: crunchPriceBackGroundColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              'assets/icons/back.png',
                              width: getProportionateScreenWidth(12),
                              height: getProportionateScreenWidth(12),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            widget.item == null ? 'Add Item' : 'Edit Item',
                            style: TextStyle(
                              color: black,
                              fontSize: getProportionateScreenWidth(22),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      sizedBox03,
                      customContainerEditItem(
                          widget.item == null ? 'Add Item' : 'Edit Item', () {
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(selectedCategory),
                                    Icon(Icons.more_vert),
                                  ],
                                )),
                          ),
                          sizedBox02,
                          customRowWithHeadingAndTextFieldToEditItem(
                              'Bar Code:', barcodeController),
                          sizedBox02,
                        ]),
                      ),
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
                        print(selectedCategory);
                        if (nameController.text.isNotEmpty &&
                                priceController.text.isNotEmpty &&
                                selectedCategory.isNotEmpty &&
                                selectedCategory != 'Select a Category' &&
                                selectedUnit.isNotEmpty &&
                                quantityController.text.isNotEmpty
                            // &&store != null
                            ) {
                          // loading.isLoading = true;
                          showLoader(context);
                          if (widget.item == null) {
                            await ItemServices().addItems(
                              context: context,
                              itemName: nameController.text,
                              category: selectedCategory,
                              dateTime: datePicked,
                              itemDescription: descriptionController.text,
                              barcode: barcodeController.text,
                              quantity: double.parse(quantityController.text),
                              unit: showCustom
                                  ? customController.text
                                  : selectedUnit,
                              price: priceController.text == '' ||
                                      priceController.text.isEmpty
                                  ? 'no price'
                                  : priceController.text,
                              brandName: brandController.text,
                              storeName: store,
                              bulkPackaging: checkBox,
                            );
                            // loading.isLoading = false;
                            Navigator.pop(context);
                            Navigator.pop(context);
                            showToast('Items added successfully', color2);
                          } else {
                            try {
                              ItemServices().updateItem(
                                nameController.text,
                                selectedCategory,
                                datePicked,
                                descriptionController.text,
                                barcodeController.text,
                                double.parse(quantityController.text),
                                showCustom
                                    ? customController.text
                                    : selectedUnit,
                                double.parse(priceController.text),
                                brandController.text,
                                store!,
                                checkBox,
                                widget.item!.itemId,
                              );
                              Navigator.pop(context);
                              Navigator.pop(context);
                              showToast('Items edit successfully', color2);
                            } catch (e) {
                              Navigator.pop(context);
                              showToast('Error $e');
                            }
                          }
                        } else {
                          showToast('Please provide the required details',
                              Colors.red);
                        }
                      }, 'Save Price'),
                      sizedBox02
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

///////////////// Custom bottom sheet for showing categories //////////////////
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
}
