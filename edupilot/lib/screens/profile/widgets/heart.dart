import 'package:edupilot/models/dtos/favorite_lesson_dto.dart';
import 'package:edupilot/models/dtos/lessons_by_grade_dto.dart';
import 'package:edupilot/services/students_api_handler.dart';
import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  const Heart({super.key, required this.lesson, required this.defaultColor});

  final LessonsByGradeDTO lesson;
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
    return FutureBuilder<List<FavoriteLessonDTO>>(
      future: StudentsApiHandler().getFavoriteLessons(),
      builder: (BuildContext context, AsyncSnapshot studentSnapshot) {
        if (studentSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (studentSnapshot.hasError) {
          return Center(child: Text('Hata oluştu: ${studentSnapshot.error}'));
        } else if (!studentSnapshot.hasData) {
          return const Center(child: Text('Favori ders bulunamadı.'));
        }
        final List<FavoriteLessonDTO> favLessons = studentSnapshot.data!;
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return IconButton( 
              icon: Icon(Icons.favorite,
                color: favLessons.any((fl) => fl.lessonId == widget.lesson.id) ? const Color.fromRGBO(255, 0, 0, 1) : widget.defaultColor,
                size: _sizeAnimation.value,
              ),
              onPressed: () {
                _controller.reset();
                if (!favLessons.any((fl) => fl.lessonId == widget.lesson.id)) {
                  _controller.forward();
                }
                // widget.lesson.toggleIsFav();
              },
            );
          }
        );
      }
    );
  }
}