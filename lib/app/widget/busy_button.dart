import 'package:dukka/app/shared/colors.dart';
import 'package:dukka/app/shared/fonts.dart';
import 'package:dukka/app/widget/loader.dart';
import 'package:dukka/app/widget/touchables/touchable_opacity.dart';
import 'package:flutter/material.dart';

/// A button that shows a busy indicator in place of title
class BusyButton extends StatefulWidget {
  const BusyButton({
    required this.title,
    required this.onPressed,
    this.busy = false,
    this.disabled = false,
    this.isSmall = false,
    this.color = AppColors.blueColor,
    this.textColor = Colors.white,
    this.enabled = true,
    this.outline = false,
    this.icon,
    this.borderRadius = 20,
    this.loaderColor = Colors.white,
    Key? key,
  }) : super(key: key);

  final bool busy;
  final String title;
  final VoidCallback? onPressed;
  final bool enabled, outline;
  final bool disabled;
  final Color color, textColor;
  final bool isSmall;
  final String? icon;
  final double borderRadius;
  final Color loaderColor;

  @override
  // ignore: library_private_types_in_public_api
  _BusyButtonState createState() => _BusyButtonState();
}

class _BusyButtonState extends State<BusyButton> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: widget.busy == false && widget.disabled == false
          ? widget.onPressed
          : null,
      child: AnimatedContainer(
        height: widget.isSmall ? 40 : 61,
        // width: widget.busy ? 48 : null,
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.disabled || widget.busy
              ? widget.color.withOpacity(0.24)
              : widget.outline
                  ? Colors.transparent
                  : widget.color,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: widget.outline ? widget.color : Colors.transparent,
          ),
        ),
        child: !widget.busy
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextBold(
                    widget.title,
                    fontSize: 16,
                    color: widget.outline ? widget.color : widget.textColor,
                  ),
                ],
              )
            : ThirdPartyLoader(
                color: widget.loaderColor,
              ),
      ),
    );
  }
}
