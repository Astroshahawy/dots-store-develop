import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'text_field_border.dart';

class TextFiledAuthentication extends StatefulWidget {
  final String? label;
  final TextEditingController? textEditingController;
  final bool isPassword;
  final bool isLogin;
  final bool isEmail;
  final String? Function(String?)? validatorFunction;
  final Function(String?)? onSave;
  final IconData? icon;
  final IconData? suffIcon;
  final bool isEnabeled;
  const TextFiledAuthentication({
    Key? key,
    this.label,
    this.isEnabeled = true,
    this.textEditingController,
    this.isPassword = false,
    this.isEmail = false,
    this.validatorFunction,
    this.onSave,
    this.icon,
    this.suffIcon,
    this.isLogin = false,
  }) : super(key: key);

  @override
  State<TextFiledAuthentication> createState() =>
      _TextFiledAuthenticationState();
}

class _TextFiledAuthenticationState extends State<TextFiledAuthentication> {
  bool visibility = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: TextFormField(
        enabled: widget.isEnabeled,
        maxLength: widget.isLogin ? 9 : 500,
        minLines: 1,
        maxLines: widget.isPassword
            ? 1
            : widget.isLogin
                ? 1
                : 4,
        keyboardType: widget.isLogin
            ? TextInputType.phone
            : widget.isEmail
                ? TextInputType.emailAddress
                : TextInputType.text,
        controller: widget.textEditingController,
        obscureText: widget.isPassword ? visibility : !visibility,
        obscuringCharacter: '*',
        inputFormatters: widget.isPassword
              ? [
          FilteringTextInputFormatter.deny(RegExp(r"\s"))]
              : widget.isLogin
                  ? [FilteringTextInputFormatter.deny(RegExp(r"\s"))]
                  : null,
        
        cursorColor: Colors.deepPurple,
        decoration: InputDecoration(
          fillColor: Colors.white,
          counterStyle: widget.isLogin
              ? const TextStyle()
              : const TextStyle(color: Colors.transparent),
          labelText: widget.label,
          labelStyle: const TextStyle(),
          disabledBorder: outlineInputBorder(),
          focusedBorder: outlineInputBorder(),
          enabledBorder: outlineInputBorder(),
          border: outlineInputBorder(),
          // hintText: widget.label,
          prefixIcon: Icon(
            widget.icon,
            color: Colors.orange,
          ),

          suffixIcon: widget.isPassword
              ? InkWell(
                  child: Icon(
                      !visibility ? Icons.visibility_off : Icons.visibility,
                      color: Colors.deepPurple),
                  onTap: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                )
              : widget.isLogin
                  ? const SizedBox(
                      width: 50,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "\t966+\t\t\t",
                            style: TextStyle(),
                          )),
                    )
                  : widget.suffIcon == null
                      ? null
                      : Icon(
                          widget.suffIcon,
                          color: widget.textEditingController!.text.isEmpty
                              ? Colors.grey
                              : Colors.deepPurple,
                        ),
        ),
        style: const TextStyle(),
        validator: widget.validatorFunction!,
        onSaved: widget.onSave!,
      ),
    );
  }
}
