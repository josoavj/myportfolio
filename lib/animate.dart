//import 'package:flutter/animation.dart';
import 'dart:async'; // Bibliothèque utile pour l'ensemble du code
import 'package:flutter/material.dart';

class DelayedAnimation extends StatelessWidget {
  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  final Widget Child; // Widget à animer 
  final int delay; // Délai d'apparition du widget en millisecondes
  const DelayedAnimation({required this.delay, required this.Child});
}
class _DelayedAnimationState extends State<DelayedAnimation>
 with SingleTickerProviderStateMixin{
  [...]
 @override
  Widget build(BuildContext context){
    return [...];
  }
 late AnimationController controller;
 late Animation<Offset> animateOffset;

  void initState(){
    super.initState();  
  }

  controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 800),
  );

  final curve = CurvedAnimation(
    curve: Curves.decelerate,
    parent: controller, 
  );

 animatedOffset = Tween<Offset>(
    begin: Offset(0.0, -0.35), 
    end: Offset.zero).animate(curve);

Time(Duration(milliseconds: widget.delay),(){
  controller.forward();
});
}

