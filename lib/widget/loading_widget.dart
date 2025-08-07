import 'package:flutter/material.dart';
import 'package:my_first_app/values/colors.dart';

class LoadingWidget extends StatefulWidget {
  final bool? backgroundTransparent;
  final String? message;
  final bool status;
  final Widget child;

  const LoadingWidget({
    required this.status,
    required this.child,
    this.message,
    this.backgroundTransparent,
    super.key,
  });

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[widget.child, _loading(widget.status)]);
  }

  /* Widget _loading(bool loading) {
    return loading
        ? Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          color: widget.backgroundTransparent == true
              ? Colors.transparent
              : Colors.black.withSafeOpacity(0.3),
        ),
        const Center(child: CircularProgressIndicator.adaptive()),
      ],
    )
        : const SizedBox.shrink();
  }*/

  Widget _loading(bool loading) {
    return loading == true
        ? Container(
            alignment: Alignment.center,
            color: widget.backgroundTransparent == true
                ? Colors.transparent
                : Colors.grey.withSafeOpacity(0.7),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(color: Colors.pinkAccent),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
