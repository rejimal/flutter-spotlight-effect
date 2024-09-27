import 'package:flutter/material.dart';

void main() => runApp(const SpotlightApp());

class SpotlightApp extends StatefulWidget {
  const SpotlightApp({super.key});

  @override
  State<SpotlightApp> createState() => _SpotlightAppState();
}

class _SpotlightAppState extends State<SpotlightApp> {
  Offset _touchPosition = const Offset(-100, -100);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            setState(() {
              _touchPosition = details.localPosition;
            });
          },
          onPanEnd: (DragEndDetails details) {
            setState(() {
              _touchPosition = const Offset(-100, -100);
            });
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return RadialGradient(
                      center: Alignment(
                        (_touchPosition.dx / rect.width) * 2 - 1,
                        (_touchPosition.dy / rect.height) * 2 - 1,
                      ),
                      radius: 0.2,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(1),
                      ],
                      stops: const [0.0, 0.5, 1],
                    ).createShader(rect);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
