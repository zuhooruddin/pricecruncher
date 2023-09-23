import 'package:flutter/material.dart';
import 'package:price_cruncher_new/mainApp/homeScreen/no_invites.dart';
import 'package:price_cruncher_new/providers/user_data_provider.dart';
import 'package:price_cruncher_new/services/auth_services_new.dart';
import 'package:price_cruncher_new/shared/custom_button.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';
import 'package:provider/provider.dart';

import '../../services/list_services.dart';
import '../../shared/custom_appBar.dart';

class InviteList extends StatefulWidget {
  const InviteList({super.key});

  @override
  State<InviteList> createState() => _InviteListState();
}

class _InviteListState extends State<InviteList> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    List invites = provider.user!.invites!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2()
          .buildAppBar2(title: 'Invites', context: context, fromVip: false),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(15),
            vertical: getProportionateScreenWidth(21)),
        child: invites.length == 0
            ? NoInvitesWidget()
            : ListView.builder(
                itemCount: invites.length,
                itemBuilder: (context, index) {
                  InvitationModel invitationModel =
                      InvitationModel.fromMap(invites[index]);
                  return Container(
                    margin: EdgeInsets.symmetric(
                        vertical: getProportionateScreenWidth(5)),
                    padding: EdgeInsets.only(
                        left: 21, top: 15, bottom: 15, right: 10),
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                invitationModel.profileUrl,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: getProportionateScreenWidth(41),
                          height: getProportionateScreenWidth(41),
                        ),
                        buildHorizontalSpace(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                invitationModel.name,
                                style: customHeadingStyle.copyWith(
                                    fontSize: getProportionateScreenWidth(18),
                                    fontWeight: FontWeight.w500),
                              ),
                              // buildVerticalSpace(3),
                              Text(
                                invitationModel.listName,
                                style: customStyle.copyWith(
                                    fontSize: getProportionateScreenWidth(10),
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          flex: 3,
                        ),
                        Expanded(
                          child: CustomButton(
                            onTap: () async {
                              try {
                                showLoader(context);
                                await LIstServices()
                                    .acceptRequestForCollaboration(
                                  invitationModel.listId,
                                  invitationModel,
                                  await AuthServicesNew().getEmail(),
                                );
                                await provider.fetchUser();
                                Navigator.pop(context);
                                showToast('Request Accepted');
                              } catch (e) {
                                Navigator.pop(context);
                                showToast('Error : $e');
                              }
                            },
                            title: 'Accept',
                            width: getProportionateScreenWidth(99),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}

class InvitationModel {
  final String listId;
  final String profileUrl;
  final String uid;
  final String name;
  final String listName;
  final String listDescription;

  InvitationModel({
    required this.listId,
    required this.profileUrl,
    required this.uid,
    required this.name,
    required this.listName,
    required this.listDescription,
  });

  factory InvitationModel.fromMap(Map<String, dynamic> map) {
    return InvitationModel(
      listId: map['listId'] ?? "",
      profileUrl: map['profileUrl'] ?? "",
      uid: map['uid'] ?? "",
      name: map['name'] ?? "",
      listName: map['listName'] ?? "",
      listDescription: map['listDescription'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listId': listId,
      'profileUrl': profileUrl,
      'uid': uid,
      'name': name,
      'listName': listName,
      'listDescription': listDescription,
    };
  }
}
