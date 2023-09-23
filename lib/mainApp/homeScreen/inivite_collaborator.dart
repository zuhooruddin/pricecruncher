import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/services/database_services.dart';
import 'package:price_cruncher_new/shared/custom_appBar.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/customContainers.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_list.dart';

class InviteCollaborator extends StatefulWidget {
  final ShoppingList shoppingList;
  InviteCollaborator({
    Key? key,
    required this.shoppingList,
  }) : super(key: key);

  @override
  State<InviteCollaborator> createState() => _InviteCollaboratorState();
}

class _InviteCollaboratorState extends State<InviteCollaborator> {
  late TextEditingController email;
  late TextEditingController descriptionController;

  @override
  void dispose() {
    email.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    email = TextEditingController();
    descriptionController = TextEditingController(text: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: CustomAppBar2().buildAppBar2(
          title: 'Invite Collaborator',
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
                        "Invite Collaborator",
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
                        'Email',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: Get.width * 0.7,
                        height: Get.height * 0.06,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8)),
                        child: customTextFieldSmall(
                          email,
                          TextInputType.emailAddress,
                          '',
                        ),
                      ),
                    ],
                  ),
                  sizedBox05,
                  customSubmitContainerSmall(() async {
                    if (email.text.isNotEmpty) {
                      if (email.text != provider.user!.userId) {
                        showLoader(context);
                        bool isAvailable =
                            await AuthServicesNew().doesEmailExist(email.text);
                        if (isAvailable) {
                          Map<String, dynamic> map = {
                            'listId': widget.shoppingList.docId,
                            'listDescription':
                                widget.shoppingList.listDescription,
                            'listName': widget.shoppingList.listName,
                            'profileUrl': provider.user!.profilePic,
                            'name': provider.user!.userName,
                            'uid': provider.user!.userId,
                          };
                          await DatabaseServices()
                              .inviteToCollaborate(email.text, map);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          showToast('Invitation successful');
                        } else {
                          Navigator.pop(context);

                          showToast('user not available');
                        }
                      } else {
                        showToast('You cant invite yourself to this list');
                      }
                    } else {
                      showToast('Enter list name', Colors.red);
                    }
                  }, 'Invite')
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
