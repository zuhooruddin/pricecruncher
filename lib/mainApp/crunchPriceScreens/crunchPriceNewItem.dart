// import 'package:flutter/material.dart';
// import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
// import 'package:get/get.dart';

// import '../../constants/constants.dart';
// import '../../constants/customContainers.dart';

// class CrunchPriceAddNewItem extends StatefulWidget {
//   const CrunchPriceAddNewItem({super.key});

//   @override
//   State<CrunchPriceAddNewItem> createState() => _CrunchPriceAddNewItemState();
// }

// class _CrunchPriceAddNewItemState extends State<CrunchPriceAddNewItem> {
//   bool isStarActive = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             color: crunchPriceBackGroundColor,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   sizedBox02,
//                   customRowBulkPackaging((value) {
//                     setState(() {
//                       checkBox = !checkBox;
//                     });
//                   }, checkBox, 'Bulk Packaging?'),
//                   customContainerTopHeadingText('Enter the price'),
//                   Container(
//                     width: Get.width,
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.attach_money,
//                           color: Color(0xFFB7C6D2),
//                         ),
//                         customTextField(priceController, null, null),
//                       ],
//                     ),
//                   ),
//                   sizedBox02,
//                   Row(
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           customContainerTopHeadingText('Enter quantity'),
//                           customHalfContainerWithTextField(quantityController)
//                         ],
//                       ),
//                       const Spacer(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           customContainerTopHeadingText('select unit'),
//                           InkWell(
//                             onTap: () {
//                               customShowModalBottomSheetCrunchPrice(context);
//                             },
//                             child: customContainerSelectedUnit(
//                                 selectedUnit, 'Custom', true),
//                           )
//                         ],
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                   sizedBox02,
//                   Row(
//                     children: [
//                       const Spacer(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           customContainerTopHeadingText('Enter unit'),
//                           customContainerSelectedUnit(
//                               selectedUnit, 'Select', false)
//                         ],
//                       ),
//                     ],
//                   ),
//                   sizedBox02,
//                   customContainerTopHeadingText('Select store (optional)'),
//                   Container(
//                     width: Get.width,
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.search,
//                           color: Color.fromARGB(255, 0, 0, 0),
//                         ),
//                         customTextField(searchStoreController, null, null),
//                       ],
//                     ),
//                   ),
//                   sizedBox02,
//                   customContainerTopHeadingText('Enter brand (optional)'),
//                   Container(
//                     width: Get.width,
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     decoration: BoxDecoration(
//                       color: white,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.workspace_premium,
//                           color: Color.fromARGB(255, 0, 0, 0),
//                         ),
//                         customTextField(brandController, null, null),
//                       ],
//                     ),
//                   ),
//                   sizedBox02,
//                   customRowBulkPackaging((value) {
//                     setState(() {
//                       checkBoxSalePrice = !checkBoxSalePrice;
//                     });
//                   }, checkBoxSalePrice, 'Sale Price'),
//                   sizedBox02,
//                   customContainerTopHeadingText('Date'),
//                   InkWell(
//                     onTap: () async {
//                       datePicked = await DatePicker.showSimpleDatePicker(
//                         context,
//                         dateFormat: "dd-MMMM-yyyy",
//                         locale: DateTimePickerLocale.en_us,
//                         looping: true,
//                       );
//                       setState(() {});
//                     },
//                     child: customDateTimeContainer(datePicked),
//                   ),
//                   sizedBox05,
//                   customSubmitContainer(() {}, 'Save Price'),
//                   sizedBox02
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   DateTime? datePicked;
//   String? selectedUnit;
//   late TextEditingController priceController;
//   late TextEditingController quantityController;
//   late TextEditingController brandController;
//   late TextEditingController searchStoreController;
//   late TextEditingController phoneNumberController;
//   bool showPassword = true;
//   bool showConfirmPassword = true;
//   var selected;

//   @override
//   void dispose() {
//     priceController.dispose();
//     quantityController.dispose();
//     brandController.dispose();
//     searchStoreController.dispose();
//     phoneNumberController.dispose();

//     super.dispose();
//   }

//   @override
//   void initState() {
//     priceController = TextEditingController();
//     phoneNumberController = TextEditingController();
//     quantityController = TextEditingController();
//     brandController = TextEditingController();
//     searchStoreController = TextEditingController();

//     super.initState();
//   }

//   bool checkBox = false;
//   bool checkBoxSalePrice = false;
// }
