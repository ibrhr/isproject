import 'package:flutter/material.dart';
import 'package:isproject/recieve.dart';
import 'package:isproject/send.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const SendScreen(),
                  ),
                ),
            child: const Text(
              'Send Screen',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: () => Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: const Duration(seconds: 1),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var begin = const Offset(1.0, 0.0);
                      var end = Offset.zero;
                      var curve = Curves.ease;

                      var tween = Tween(begin: begin, end: end)
                          .chain(CurveTween(curve: curve));

                      return SlideTransition(
                        position: animation.drive(tween),
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const RecieveScreen(),
                  ),
                ),
            child: const Text(
              'Recieve Screen',
              style: TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(100, 50);
}
