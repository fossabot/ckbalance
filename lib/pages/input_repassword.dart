import 'package:ckbalance/pages/home_page/home.dart';
import 'package:ckbalance/resources/strings.dart';
import 'package:ckbalance/utils/wallet_manager.dart';
import 'package:ckbalance/views/password_field.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:ckbalance/views/dialog/loading_dialog.dart';

class InputRePasswordPage extends StatefulWidget {
  final String pwd;
  final String mnemonic;

  InputRePasswordPage(this.pwd, {this.mnemonic = ""});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<InputRePasswordPage> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  String _validatePassword(String value) {
    final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
    if (passwordField.value == null || passwordField.value.isEmpty)
      return CustomLocalizations.of(context).getString(StringIds.errorEmptyPwd);
    if (passwordField.value.length < 8)
      return CustomLocalizations.of(context).getString(StringIds.errorLessPwd);
    if (passwordField.value != widget.pwd)
      return CustomLocalizations.of(context).getString(StringIds.errorDiffPwd);
    return null;
  }

  _handlePwd() async {
    try {
      final FormFieldState<String> passwordField = _passwordFieldKey.currentState;
      if (passwordField.validate()) {
        showDialog(
            context: context,
            builder: (_) => LoadingDialog(
                  text: "saving",
                ));
        await WalletManager.getInstance().importWallet(widget.mnemonic, widget.pwd);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => HomePage()),
            (Route route) => route == null);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocalizations.of(context).getString(StringIds.inputPwdTitle)),
        leading: new IconButton(
          tooltip: 'back',
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                CustomLocalizations.of(context).getString(StringIds.inputPwdReTip),
                style: Theme.of(context).textTheme.body2,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                CustomLocalizations.of(context).getString(StringIds.inputPwdReAttention),
                style: Theme.of(context).textTheme.body1.copyWith(color: Colors.red),
              ),
              const SizedBox(
                height: 20,
              ),
              PasswordField(
                fieldKey: _passwordFieldKey,
                labelText: CustomLocalizations.of(context).getString(StringIds.inputPwdFieldLabel),
                helperText:
                    CustomLocalizations.of(context).getString(StringIds.inputPwdFieldHelper),
                validator: _validatePassword,
                autofocus: true,
                onFieldSubmitted: (value) {
                  _handlePwd();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: RaisedButton(
                  padding: const EdgeInsets.fromLTRB(60, 5, 60, 5),
                  child: Text(
                    CustomLocalizations.of(context).getString(StringIds.nextButton),
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: _handlePwd,
                ),
              ),
            ],
          )),
    );
  }
}
