import 'package:animations/tiker_test.dart';
import 'package:flutter/material.dart';

import 'hero_demo.dart';
import 'animated_container_size.dart';
import 'animated_container_curve.dart';
import 'animated_container_gradient.dart';
import 'animated_positioned.dart';
import 'tween_demo.dart';
import 'tween_animation_builder.dart';
import 'single_ticker_mixin_demo.dart';
import 'animation_controller_demo.dart';
import 'animated_builder_demo.dart';
import 'positioned_transition.dart';
import 'size_transition.dart';
import 'rotation_transition.dart';
import 'ticker_demo.dart';
import 'fade_transition.dart';
import 'animated_switcher.dart';

void main() {
  runApp(const AnimationDemosApp());
}

class AnimationDemosApp extends StatelessWidget {
  const AnimationDemosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainMenu(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  // Helper para criar os botões mais facilmente
  Widget _buildButton(BuildContext context, String text, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animações no Flutter')),
      body: ListView(
        children: [
          _buildButton(context, 'Hero', const HeroDemo()),
          _buildButton(context, 'Ticker', const TickerDemo()),
          _buildButton(context, 'Ticker (Test)', const TickerTest()),

          _buildButton(
            context,
            'AnimatedContainer/size',
            const AnimatedContainerSize(),
          ),
          _buildButton(
            context,
            'AnimatedContainer/size/Curve',
            const AnimatedContainerCurve(),
          ),
          _buildButton(
            context,
            'AnimatedContainer/gradient',
            const AnimatedContainerGradient(),
          ),
          _buildButton(
            context,
            'AnimatedPositioned',
            const AnimatedPositionedDemo(),
          ),
          _buildButton(context, 'Tween<T>', const TweenDemo()),
          _buildButton(
            context,
            'TweenAnimationBuilder',
            const TweenAnimationBuilderDemo(),
          ),
          _buildButton(
            context,
            'SingleTickerProviderStateMixin',
            const SingleTickerMixinDemo(),
          ),
          _buildButton(
            context,
            'AnimationController',
            const AnimationControllerDemo(),
          ),
          _buildButton(context, 'AnimatedBuilder', const AnimatedBuilderDemo()),
          _buildButton(
            context,
            'PositionedTransition',
            const PositionedTransitionDemo(),
          ),
          _buildButton(context, 'SizeTransition', const SizeTransitionDemo()),
          _buildButton(
            context,
            'RotationTransition',
            const RotationTransitionDemo(),
          ),
          // Widgets adicionais importantes
          _buildButton(
            context,
            'FadeTransition (Extra)',
            const FadeTransitionDemo(),
          ),
          _buildButton(
            context,
            'AnimatedSwitcher (Extra)',
            const AnimatedSwitcherDemo(),
          ),
        ],
      ),
    );
  }
}
