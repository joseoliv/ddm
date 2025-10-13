import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void test() {
    var s = context;
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: MainWidget())),
    );
  }
}

// a stateful widget with two buttons: one for showing CounterWidget and the other for
// showing a widget AnimationExample (yet to be implemented).
class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            /// go to a new route with CounterWidget
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text('Ticker Example')),
                  body: Center(child: TickerCounterWidget()),
                ),
              ),
            );
          },
          child: const Text('Ticker Example'),
        ),
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: () {
            /// go to a new route with CounterWidget
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text('AnimatedContainer Example')),
                  body: Center(child: AnimatedContainerExample()),
                ),
              ),
            );
          },
          child: const Text('AnimatedContainer Example'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'AnimationController without Animation Class Example',
                    ),
                  ),
                  body: Center(
                    child: AnimationControllerWithoutClassAnimation(),
                  ),
                ),
              ),
            );
          },
          child: const Text(
            'AnimationController without Animation Class Example',
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text('TweenAnimationBuilder Example')),
                  body: Center(child: AnimationExampleTween()),
                ),
              ),
            );
          },
          child: const Text('TweenAnimationBuilder Example'),
        ),

        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text('AnimationController with Animation Class'),
                  ),
                  body: Center(child: AnimationExampleWithClassAnimation()),
                ),
              ),
            );
          },
          child: const Text('AnimationController with Animation Class'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text('FooTransition Example')),
                  body: Center(child: FooTransition()),
                ),
              ),
            );
          },
          child: const Text('FooTransition Example'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(title: Text('Test Example')),
                  body: Center(child: TestExample()),
                ),
              ),
            );
          },
          child: const Text('Test Example'),
        ),
      ],
    );
  }
}

/// a stateful widget that has a counter
class TickerCounterWidget extends StatefulWidget {
  const TickerCounterWidget({super.key});

  @override
  State<TickerCounterWidget> createState() => _TickerCounterWidgetState();
}

class _TickerCounterWidgetState extends State<TickerCounterWidget> {
  int _count = 0;
  double _x = 0.0;
  double _y = 0.0;
  int _incPos = 30;

  late Ticker _ticker;
  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      setState(() {
        _count++;
        // Update position every _incPos counter increments
        if (_count % 10 == 0) {
          // Move in steps of _incPos points from (0,0) to (500,500)
          if (_x < 500) {
            _x += _incPos;
          } else {
            _x = 0;
          }
          if (_y < 500) {
            _y += _incPos;
          } else {
            _y = 0;
          }
        }
      });
    });
    _ticker.start(); // Start the ticker to begin calling the callback
  }

  /// dispose _ticker
  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Count: ${_count % 100}'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _count = 0;
              _x = 0.0;
              _y = 0.0;
            });
          },
          child: const Text('Reset'),
        ),
        const SizedBox(height: 20),

        /// button to stop and start the ticker
        ElevatedButton(
          onPressed: () {
            if (_ticker.isActive) {
              _ticker.stop();
            } else {
              _ticker.start();
            }
          },
          child: const Text('Start/Stop Ticker'),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// buttons to increase/decrease _incPos by 10
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_incPos > 10) _incPos -= 10;
                });
              },
              child: // icon for minus
              Icon(
                Icons.remove,
              ),
            ),
            const SizedBox(width: 20),
            Text('Position Update Interval: $_incPos'),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_incPos < 100) _incPos += 10;
                });
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: 600,
          height: 500,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Stack(
            children: [
              Positioned(
                left: _x,
                top: _y,
                child: Container(width: 20, height: 20, color: Colors.yellow),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// a stateful widget that uses AnimationController without Animation class
class AnimationControllerWithoutClassAnimation extends StatefulWidget {
  const AnimationControllerWithoutClassAnimation({super.key});

  @override
  State<AnimationControllerWithoutClassAnimation> createState() =>
      _AnimationControllerWithoutClassAnimationState();
}

class _AnimationControllerWithoutClassAnimationState
    extends State<AnimationControllerWithoutClassAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _position = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.addListener(_update);
    //_controller.forward();
    _controller.repeat(reverse: true);
  }

  void _update() {
    setState(() {
      // Map controller value (0.0 to 1.0) to position (0 to 300)
      _position = _controller.value * 300;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_update);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.red,
      transform:
          /// rotate and translate the container based on _position
          Matrix4.rotationZ(_position * 0.01),
    );
  }
}

/// a stateful widget that demonstrates SizeTransition with an icon
class FooTransition extends StatefulWidget {
  const FooTransition({super.key});

  @override
  State<FooTransition> createState() => _FooTransitionState();
}

class _FooTransitionState extends State<FooTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.repeat(
      reverse: true,
      min: 0.0,
      max: 1.0,
      period: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
              ElevatedButton(
                onPressed: () {
                  if (_controller.isAnimating) {
                    _controller.stop();
                  } else {
                    _controller.repeat(reverse: true);
                  }
                  setState(() {});
                },
                child: Text(_controller.isAnimating ? 'Stop' : 'Start'),
              ),
        ),
        const SizedBox(width: 30),
        RotationTransition(
          turns: _animation,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(
                255,
                255,
                142,
                36,
              ).withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.favorite, size: 100, color: Colors.red),
          ),
        ),
      ],
    );
  }
}

/// a stateful widget that uses TweenAnimationBuilder to move a box diagonally
class AnimationExampleTween extends StatefulWidget {
  const AnimationExampleTween({super.key});

  @override
  State<AnimationExampleTween> createState() => _AnimationExampleTweenState();
}

class _AnimationExampleTweenState extends State<AnimationExampleTween> {
  double _targetValue = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the animation immediately after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _targetValue = 300.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(seconds: 2),
      tween: Tween<double>(begin: 0, end: _targetValue),
      onEnd: () {
        // Toggle target value when animation completes
        setState(() {
          _targetValue = _targetValue == 0.0 ? 300.0 : 0.0;
        });
      },
      builder: (context, value, child) {
        return Container(
          width: 30,
          height: 30,
          color: Colors.green,
          transform: Matrix4.translationValues(value, value, 0),
        );
      },
    );
  }
}

/// a stateful widget that uses AnimationController to move a box diagonally
/// https://www.youtube.com/watch?v=fneC7t4R_B0&list=PLjxrf2q8roU2v6UqYlt_KPaXlnjbYySua&index=5
class AnimationExampleWithClassAnimation extends StatefulWidget {
  const AnimationExampleWithClassAnimation({super.key});

  @override
  State<AnimationExampleWithClassAnimation> createState() =>
      _AnimationExampleWithClassAnimationState();
}

class _AnimationExampleWithClassAnimationState
    extends State<AnimationExampleWithClassAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 300).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: 30,
          height: 30,

          /// I want that the color varies with the position
          color: Colors.blue.withValues(
            red: _animation.value / 300,
            green: 1 / 2 + _animation.value / 600,
            blue: 1 - _animation.value / 300,
          ),
          transform: Matrix4.translationValues(
            _animation.value,
            _animation.value,
            0,
          ),
        );
      },
    );
  }
}

/// A stateful widget that demonstrates AnimatedContainer with purple color
class AnimatedContainerExample extends StatefulWidget {
  const AnimatedContainerExample({super.key});

  @override
  State<AnimatedContainerExample> createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isExpanded = false;
  double _size = 100.0;
  Color _color = Colors.purple;
  BorderRadius _borderRadius = BorderRadius.circular(8.0);

  void _toggleAnimation() {
    setState(() {
      _isExpanded = !_isExpanded;
      _size = _isExpanded ? 200.0 : 300.0;
      _color = _isExpanded
          ? Colors.orange
          : const Color.fromARGB(255, 103, 155, 239);
      _borderRadius = _isExpanded
          ? BorderRadius.circular(12.0)
          : BorderRadius.circular(8.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.bounceOut,
          width: _size,
          height: 100,
          decoration: BoxDecoration(
            color: _color,
            borderRadius: _borderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: _isExpanded ? 20.0 : 10.0,
                spreadRadius: _isExpanded ? 5.0 : 2.0,
              ),
            ],
          ),
          child: Center(
            child: ListTile(
              leading: Icon(
                _isExpanded ? Icons.star : Icons.favorite,
                color: Colors.white,
                //size: _size * 0.4,
              ),
              trailing: Icon(
                !_isExpanded ? Icons.star : Icons.favorite,
                color: Colors.white,
                //size: _size * 0.4,
              ),

              title: Text(
                'Hello',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _isExpanded ? 24 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: _toggleAnimation,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            foregroundColor: Colors.white,
          ),
          child: Text(_isExpanded ? 'Shrink' : 'Expand'),
        ),
      ],
    );
  }
}

/// a stateful widget named TestExample with a container of size 100x100 and color purple
class TestExample extends StatefulWidget {
  const TestExample({super.key});

  @override
  State<TestExample> createState() => _TestExampleState();
}

/// A stateful widget that represents the state of the TestExample
class _TestExampleState extends State<TestExample>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _colorController;

  late Animation<double> _animation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _colorController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation = Tween<double>(begin: 100, end: 300).animate(_controller);
    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.orange,
    ).animate(_colorController);
    _controller.repeat(reverse: true);
    _colorController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_controller.isAnimating) {
              _controller.stop();
            } else {
              _controller.repeat(reverse: true);
            }
          },
          child: Container(
            width: _animation.value,
            height: _animation.value,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
