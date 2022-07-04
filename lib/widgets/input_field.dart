import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  final String hint;
  final String title;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: titlestyle,
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey)),
          height: 45,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: 14,
          ),
          margin: const EdgeInsets.only(top: 8),
          child: Row(children: [
            Expanded(
              child: TextFormField(
                readOnly: widget != null ? true : false,
                style: subtitlestyle,
                controller: controller,
                autofocus: false,
                cursorColor:
                    Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: subtitlestyle,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 0)),
                ),
              ),
            ),
            widget ?? Container(),
          ]),
        ),
      ]),
    );
  }
}
