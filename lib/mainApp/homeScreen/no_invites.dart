import 'package:flutter/material.dart';
import 'package:price_cruncher_new/utils/constants.dart';
import 'package:price_cruncher_new/utils/size_confiq.dart';

import '../../shared/custom_appBar.dart';

class NoInvites extends StatefulWidget {
  const NoInvites({super.key});

  @override
  State<NoInvites> createState() => _NoInvitesState();
}

class _NoInvitesState extends State<NoInvites> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar2()
          .buildAppBar2(title: 'Invites', context: context, fromVip: false),
      body: NoInvitesWidget(),
    );
  }
}

class NoInvitesWidget extends StatelessWidget {
  const NoInvitesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(37)),
        child: Text(
          'No invites yet. You can ask your families and friends to add you to shopping lists so you can collaborate together ',
          style: customStyle.copyWith(
            fontSize: getProportionateScreenWidth(16),
            fontWeight: FontWeight.w300,
            color: darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
