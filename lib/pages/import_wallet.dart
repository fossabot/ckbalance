import 'package:flutter/material.dart';
import 'package:ckbalance/resources/strings.dart';
import 'package:fluintl/fluintl.dart';
import 'package:ckbalance/pages/input_password.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:ckbalance/views/button/my_raised_button.dart';

class ImportWalletPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ImportWalletPage> {
  final GlobalKey<FormFieldState<String>> _fieldKey = GlobalKey<FormFieldState<String>>();

  _import() {
    final FormFieldState<String> _field = _fieldKey.currentState;
    if (_field.validate()) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => InputPasswordPage(
                mnemonic: _field.value,
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizations.of(context).getString(StringIds.importWalletTitle)),
        leading: IconButton(
          tooltip: 'back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          child: Column(
            children: <Widget>[
              Text(
                CustomLocalizations.of(context).getString(StringIds.importWalletInputHelper),
                style: Theme.of(context).textTheme.body2,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      CustomLocalizations.of(context).getString(StringIds.importWalletInputHint),
                ),
                key: _fieldKey,
                maxLines: 3,
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty)
                    return CustomLocalizations.of(context).getString(StringIds.errorEmptyInput);
                  if (!bip39.validateMnemonic(value))
                    return CustomLocalizations.of(context).getString(StringIds.errorValidMnemonic);
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              MyRaisedButton(
                text: CustomLocalizations.of(context).getString(StringIds.importWalletTitle),
                onPressed: _import,
              ),
              FlatButton(
                child: Text(CustomLocalizations.of(context).getString(StringIds.scanQRCodeButton),
                    style: Theme.of(context).textTheme.body1),
                onPressed: () {},
              )
            ],
          )),
    );
  }
}
