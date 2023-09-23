import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:price_cruncher_new/mainApp/BottomNavigationBar/bottomNavBar.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import '../../shared/custom_button.dart';
import '../../utils/constants.dart';
import '../../utils/customContainers.dart';
import '../../utils/size_confiq.dart';
import 'package:get/get.dart';

class BarCodeScannerScreen extends StatefulWidget {
  const BarCodeScannerScreen({super.key});

  @override
  State<BarCodeScannerScreen> createState() => _BarCodeScannerScreenState();
}

class _BarCodeScannerScreenState extends State<BarCodeScannerScreen> {
  bool isScanCompleted = false;
  MobileScannerController cameraController = MobileScannerController();
  TextEditingController controller = TextEditingController(text: '');

  void resetScanCompleted() {
    setState(() {
      isScanCompleted = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.off(ScreenBottomNavBar());
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: CustomAppBar().buildAppBar(
            title: 'Bar Code Scanner',
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     IconButton(
              //       color: Colors.white,
              //       icon: ValueListenableBuilder(
              //         valueListenable: cameraController.cameraFacingState,
              //         builder: (context, state, child) {
              //           switch (state) {
              //             case CameraFacing.front:
              //               return const Icon(Icons.camera_front);
              //             case CameraFacing.back:
              //               return const Icon(Icons.camera_rear);
              //           }
              //         },
              //       ),
              //       iconSize: 32.0,
              //       onPressed: () => cameraController.switchCamera(),
              //     ),
              //     IconButton(
              //       color: Colors.white,
              //       icon: ValueListenableBuilder(
              //         valueListenable: cameraController.torchState,
              //         builder: (context, state, child) {
              //           switch (state) {
              //             case TorchState.off:
              //               return const Icon(Icons.flash_off,
              //                   color: Colors.grey);
              //             case TorchState.on:
              //               return const Icon(Icons.flash_on,
              //                   color: Colors.yellow);
              //           }
              //         },
              //       ),
              //       iconSize: 32.0,
              //       onPressed: () => cameraController.toggleTorch(),
              //     ),
              //   ],
              // ),
              Expanded(
                flex: 5,
                child: MobileScanner(onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;
                  // final Uint8List? image = capture.image;

                  if (!isScanCompleted && barcodes.isNotEmpty) {
                    isScanCompleted = true;

                    showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (BuildContext context,
                              StateSetter customSetState) {
                            return WillPopScope(
                              onWillPop: () async {
                                resetScanCompleted();
                                return true;
                              },
                              child: AlertDialog(
                                contentPadding: EdgeInsets.only(
                                    bottom: getProportionateScreenWidth(21)),
                                insetPadding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      getProportionateScreenWidth(20)),
                                ),
                                title: Center(
                                  child: Text(
                                    'New Barcode Detected',
                                    style: customHeadingStyle.copyWith(
                                      fontSize: getProportionateScreenWidth(20),
                                    ),
                                  ),
                                ),
                                content: Container(
                                  width: SizeConfig.screenWidth,
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionateScreenWidth(21)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                            child: CustomButton(
                                          onTap: () {},
                                          title: 'Add New Item',
                                        )),
                                        buildVerticalSpace(10),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        31)),
                                            child: Divider(),
                                          ),
                                        ),
                                        buildVerticalSpace(12),
                                        Text(
                                          'Link Existing Item:',
                                          style: customStyle,
                                        ),
                                        Center(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    getProportionateScreenWidth(
                                                        15),
                                                vertical:
                                                    getProportionateScreenWidth(
                                                        18)),
                                            width: Get.width * 0.65,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  242, 242, 242, 1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: customTextField(
                                                controller, null, 'Search'),
                                          ),
                                        ),
                                        expansionTilesBarCodeScreen(),
                                        sizedBox02,
                                        expansionTilesBarCodeScreen(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }

                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => BarCodeResult()));
                  // if (image != null) {
                  //
                  // }
                }),
              ),
            ]),
          )),
    );
  }

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
    String text1,
    String text2,
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
                  text1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  text2,
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
