import 'package:edupilot/models/quiz/lesson.dart';
import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.lesson, required this.defaultColor});

  final Lesson lesson;
  final Color defaultColor;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  
  // tween (between)
  late Animation _sizeAnimation;

  @override
  void initState() {
    
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this
    );

    _sizeAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(begin: 25, end: 40),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 40, end: 25),
        weight: 50,
      ),
    ]).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton( 
          icon: Icon(Icons.favorite,
            color: widget.lesson.isFav ? const Color.fromRGBO(255, 0, 0, 1) : widget.defaultColor,
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            _controller.reset();
            if (!widget.lesson.isFav) {
              _controller.forward();
            }
            widget.lesson.toggleIsFav();
          },
        );
      }
    );
  }
}