import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/ui_helpers.dart';
import 'package:dukka/app/widget/note_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class InputField extends StatefulWidget {
  const InputField({
    required this.controller,
    required this.placeholder,
    this.enterPressed,
    this.fieldFocusNode,
    this.nextFocusNode,
    this.additionalNote,
    this.onChanged,
    this.formatter,
    this.maxLines = 1,
    this.validationMessage,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.password = false,
    this.isReadOnly = false,
    this.smallVersion = true,
    this.suffix,
    this.prefix,
    this.height,
    this.onSubmitted,
    this.validationColor = AppColors.blackColor25,
    Key? key,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool password;
  final bool isReadOnly;
  final String placeholder;
  final String? validationMessage;
  final Function? enterPressed;
  final bool smallVersion;
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final String? additionalNote;

  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? formatter;
  final int? maxLines;
  final Widget? suffix;
  final Widget? prefix;
  final double? height;
  final Color validationColor;
  @override
  // ignore: library_private_types_in_public_api
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late bool isPassword;

  @override
  void initState() {
    super.initState();
    isPassword = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: widget.smallVersion ? 48 : widget.height ?? 113,
          alignment: Alignment.centerLeft,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: widget.validationColor),
            color: widget.isReadOnly ? const Color(0xffF0F2F4) : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              widget.prefix ?? const SizedBox(),
              horizontalSpaceSmall,
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onSubmitted: widget.onSubmitted,
                  keyboardType: widget.textInputType,
                  focusNode: widget.fieldFocusNode,
                  textInputAction: widget.textInputAction,
                  onChanged: widget.onChanged,
                  cursorColor: AppColors.blueColor,

                  inputFormatters: widget.formatter ?? [],
                  onEditingComplete: () {
                    if (widget.enterPressed != null) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // ignore: avoid_dynamic_calls
                      widget.enterPressed?.call();
                    }
                  },
                  // onFieldSub
                  //mitted: (value) {
                  //   if (widget.nextFocusNode != null) {
                  //     widget.nextFocusNode.requestFocus();
                  //   }
                  // },
                  obscureText: isPassword,
                  readOnly: widget.isReadOnly,
                  maxLines: widget.maxLines,
                  // decoration:
                  // InputDecoration.collapsed(hintText: widget.placeholder),
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.only(top: 10),

                    hintText: widget.placeholder,
                    border: InputBorder.none,

                    hintStyle: TextStyle(
                      fontSize: widget.smallVersion ? 12 : 14,
                      color: AppColors.blackColor50,
                    ),
                    // suffix:
                  ),
                ),
              ),
              widget.suffix ??
                  GestureDetector(
                    onTap: () => setState(() {
                      isPassword = !isPassword;
                    }),
                    child: widget.password
                        ? Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            child: Icon(
                              isPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                              size: 20,
                            ),
                          )
                        : Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                          ),
                  ),
            ],
          ),
        ),
        if (widget.validationMessage != null)
          NoteText(
            widget.validationMessage!,
            color: Colors.red,
          )
        else
          const SizedBox(),
        if (widget.additionalNote != null) const Gap(5) else const SizedBox(),
        if (widget.additionalNote != null)
          NoteText(widget.additionalNote!)
        else
          const SizedBox(),
        gapSmall
      ],
    );
  }
}
