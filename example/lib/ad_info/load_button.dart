import 'package:flutter/material.dart';

class LoadButton extends StatelessWidget {
  final bool isLoading;
  final void Function()? onPressed;

  const LoadButton({Key? key, required this.isLoading, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ElevatedButton.icon(
            icon: Transform.scale(
              scale: 0.4,
              child: const CircularProgressIndicator(),
            ),
            label: const Text('Loading'),
            onPressed: null,
          )
        : ElevatedButton.icon(
            icon: const Icon(Icons.play_arrow_outlined),
            label: const Text('Load ad'),
            onPressed: onPressed,
          );
  }
}
