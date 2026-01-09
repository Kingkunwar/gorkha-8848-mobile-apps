import 'dart:async';
import 'package:flutter/material.dart';

class EaseInWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;
  final BorderRadius? borderRadius;
  final int debounceDuration;

  const EaseInWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.borderRadius,
    this.onDoubleTap,
    this.debounceDuration = 2,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EaseInWidgetState();
}

class _EaseInWidgetState extends State<EaseInWidget>
    with TickerProviderStateMixin<EaseInWidget> {
  late AnimationController controller;
  late Animation<double> easeInAnimation;
  final ValueNotifier<bool> _isEnabled = ValueNotifier(true);
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 50,
          // milliseconds: 0,
        ),
        value: 1.0);
    easeInAnimation = Tween(begin: 1.0, end: 0.90).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _isEnabled,
        builder: (context, bool isEnabled, child) {
          return InkWell(
            key: UniqueKey(),
            onDoubleTap: widget.onDoubleTap,
            borderRadius: widget.borderRadius,
            onTap: !isEnabled
                ? null
                : () {
                    _isEnabled.value = false;
                    if (widget.onTap == null) {
                      return;
                    }
                    controller.forward().then((val) {
                      controller.reverse().then((val) {
                        widget.onTap!();
                      });
                    });
                    _debounce =
                        Timer(Duration(seconds: widget.debounceDuration), () {
                      _isEnabled.value = true;
                    });
                  },
            onLongPress: () {
              if (widget.onLongPress == null) {
                return;
              }
              controller.forward().then((val) {
                controller.reverse().then((val) {
                  widget.onLongPress!();
                });
              });
            },
            child: ScaleTransition(
              scale: easeInAnimation,
              child: widget.child,
            ),
          );
        });
  }

  @override
  void dispose() {
    if (_debounce != null) {
      _debounce!.cancel();
    }
    controller.dispose();
    super.dispose();
  }
}
