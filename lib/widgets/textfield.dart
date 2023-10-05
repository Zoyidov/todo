import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class GlobalTextField extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final String? suffixIcon;
  final String caption;
  final TextEditingController? controller;
  final int? max;
  final Color? color;
  final ValueChanged? onChanged;

  const GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    this.prefixIcon,
    required this.caption,
    this.controller,
    this.max, required this.textInputAction, this.suffixIcon, this.color, this.onChanged,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _GlobalTextFieldState createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {
  late MaskTextInputFormatter _maskFormatter;

  @override
  void initState() {
    super.initState();
    _maskFormatter = MaskTextInputFormatter(
      mask: '##:## - ##:##',
      filter: {"#": RegExp(r'[0-9]')},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.caption.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              widget.caption,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          onChanged: widget.onChanged,
          controller: widget.controller,
          maxLines: widget.max,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          cursorColor: Colors.grey,
          cursorHeight: 25,
          inputFormatters: widget.keyboardType == TextInputType.number
              ? [_maskFormatter]
              : [],
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
              widget.prefixIcon,
              color: Colors.grey,
            )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.black12,
          ),
          keyboardType: widget.keyboardType,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
