import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:todolist/utils/appcolor.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with TickerProviderStateMixin {
  late final MeshGradientController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MeshGradientController(
      points: [
        MeshGradientPoint(
          position: const Offset(
            -1,
            0.2,
          ),
          color: AppColor.primaryColor,
        ),
        MeshGradientPoint(
          position: const Offset(
            2,
            0.6,
          ),
          color: AppColor.secondaryColor,
        ),
        MeshGradientPoint(
          position: const Offset(
            0.7,
            0.3,
          ),
          color: const Color.fromARGB(255, 255, 255, 255),
        ),
        MeshGradientPoint(
          position: const Offset(
            0.4,
            0.8,
          ),
          color: const Color.fromARGB(255, 101, 255, 222),
        ),
      ],
      vsync: this,
    );

    startAnimation(duration: 10);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MeshGradient(
              controller: _controller,
              options: MeshGradientOptions(
                blend: 3.5,
                noiseIntensity: 0.5,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Reminder for",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data[0]['title'].toString(),
                          style: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Positioned.fill(
            bottom: 100,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text("Dismiss"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void startAnimation({required duration}) {
    _controller.animateSequence(
      duration: Duration(seconds: duration),
      sequences: [
        AnimationSequence(
          pointIndex: 0,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _controller.points.value[0].color,
          ),
          interval: const Interval(
            0,
            0.5,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 1,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _controller.points.value[1].color,
          ),
          interval: const Interval(
            0.25,
            0.75,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 2,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _controller.points.value[2].color,
          ),
          interval: const Interval(
            0.5,
            1,
            curve: Curves.easeInOut,
          ),
        ),
        AnimationSequence(
          pointIndex: 3,
          newPoint: MeshGradientPoint(
            position: Offset(
              Random().nextDouble() * 2 - 0.5,
              Random().nextDouble() * 2 - 0.5,
            ),
            color: _controller.points.value[3].color,
          ),
          interval: const Interval(
            0.75,
            1,
            curve: Curves.easeInOut,
          ),
        ),
      ],
    );
  }
}
