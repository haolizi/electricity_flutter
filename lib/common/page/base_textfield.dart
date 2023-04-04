/// @date: 2023/2/23 10:33 上午
/// @since: flutter 3.0.0+
/// @version: 1.0.0
/// @author: hc
/// @file: base_textfield.dart
/// @description: 输入框

import 'package:flutter/material.dart';

typedef OnClear = Function();
typedef OnValidator = Function(String value);
typedef OnChanged = Function(String formKey, String value);

class BaseTextField extends StatefulWidget {
  String formKey; // 判断哪个输入框
  String value;
  TextInputType keyboardType;
  FocusNode? focusNode;
  TextEditingController? controller;
  OnChanged? onChanged;
  String? hintText;
  String prefixIcon;
  OnClear? onClear; // 清除按钮响应
  FormFieldValidator<String>? validator; // 输入内容校验
  bool isEnableClear;
  bool obscureText;
  EdgeInsetsGeometry padding;

  BaseTextField({
    Key? key,
    this.formKey = "",
    this.value = "",
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.hintText,
    this.prefixIcon = "",
    this.onClear,
    this.validator,
    this.isEnableClear = false,
    this.obscureText = false,
    this.padding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
  }) : super(key: key);

  @override
  _BaseTextFieldState createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  @override
  void initState() {
    if (widget.value.isNotEmpty) {
      widget.controller?.text = widget.value;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        obscureText: widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          hintText: widget.hintText,
          icon: widget.prefixIcon.isNotEmpty
              ? Image(
                  image: AssetImage(widget.prefixIcon),
                )
              : null,
          border: InputBorder.none,
          suffixIcon: widget.isEnableClear
              ? GestureDetector(
                  child: Offstage(
                    offstage: widget.value.isEmpty || widget.value == "",
                    child: const Icon(
                      Icons.clear,
                      size: 15,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      widget.value = "";
                      widget.controller?.text = "";
                      widget.onClear!();
                    });
                  },
                )
              : null,
        ),
        validator: widget.validator,
        onChanged: (v) {
          setState(() {
            widget.value = v;
            widget.onChanged!(widget.formKey, v);
          });
        },
      ),
    );
  }
}
