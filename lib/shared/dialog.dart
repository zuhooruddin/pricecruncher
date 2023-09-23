import 'package:flutter/material.dart';
import 'package:price_cruncher_new/services/list_services.dart';
import 'package:price_cruncher_new/utils/constants.dart';

class ClassicConfirmationDialog extends StatelessWidget {
  final String listId;
  ClassicConfirmationDialog({required this.listId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmation'),
      content:
          Text('Are you sure you want to remove this user from collaboration?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            try {
              showLoader(context);
              LIstServices().removeCollaborator(listId);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              showToast('Collaborator Removed');
            } catch (e) {
              Navigator.pop(context);
              showToast('Error $e');
            }
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
