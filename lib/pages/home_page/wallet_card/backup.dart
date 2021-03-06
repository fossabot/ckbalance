import 'package:ckbalance/resources/strings.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:ckbalance/views/dialog/password_bottom_sheet.dart';
import 'package:ckbalance/pages/backup_mnemonic.dart';
import 'package:ckbalance/utils/wallet_manager.dart';

class BackupWidget extends StatelessWidget {
  final bool isBackup;

  BackupWidget(this.isBackup);

  @override
  Widget build(BuildContext context) {
    if (isBackup) {
      return Row(
        children: <Widget>[
          SizedBox(width: 25),
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 3),
          Text(
            CustomLocalizations.of(context).getString(StringIds.backedUp),
            style: TextStyle(fontSize: 16, color: Colors.white),
          )
        ],
      );
    }
    return Row(
      children: <Widget>[
        SizedBox(width: 20),
        Row(
          children: <Widget>[
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    )),
                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.warning,
                      color: Colors.redAccent,
                      size: 16,
                    ),
                    SizedBox(width: 2),
                    Text(
                      CustomLocalizations.of(context).getString(StringIds.backUp),
                      style: TextStyle(fontSize: 16, color: Colors.redAccent),
                    )
                  ],
                ),
              ),
              onTap: () {
                showBottomSheet(
                    context: context,
                    builder: (_) {
                      return PasswordBottomSheet((password) async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                BackupMnemonic(WalletManager.getInstance().getMnemonic())));
                      });
                    });
              },
            ),
          ],
        ),
      ],
    );
  }
}
