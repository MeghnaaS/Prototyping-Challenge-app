import 'package:flutter/material.dart';
import 'package:fun_app/End.dart';
import 'package:go_router/go_router.dart';
import 'Tele.dart';
import 'package:provider/provider.dart';
import 'Score.dart';

void main() {
  runApp(
    ChangeNotifierProvider( // lets the score class be shared everywhere
      create: (_) => Score(), // makes one score object for the whole app to use
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // router
  static final GoRouter _router = GoRouter(
    initialLocation: '/tele', // starting screen
    routes: [
      GoRoute(
        path: '/tele',
        builder: (context, state) => const TelePage(),
      ),
      GoRoute(
        path: '/end',
        builder: (context, state) => const EndPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router, // tells it to use go router for all navigation
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFEFEFE),
      ),
    );
  }
}
