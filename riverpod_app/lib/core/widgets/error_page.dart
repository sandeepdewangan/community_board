import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../config/router/route_constants.dart';

class ErrorPage extends ConsumerWidget {
  const ErrorPage({super.key, this.error});

  final Exception? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedIn = ref.watch(authControllerProvider).user != null;
    return Scaffold(
      appBar: AppBar(title: const Text("Page not found!")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error?.toString() ??
                    "The page you were looking doesnot exists.",
                style: const TextStyle(fontSize: 18, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final path = loggedIn ? RoutePath.post : RoutePath.login;
                  context.go(path);
                },
                child: Text(loggedIn ? 'Go to Home' : 'Go to Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
