import 'package:core/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/config/router/route_constants.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class MyProfilePage extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text("My Profile")),
      floatingActionButton:
          ref.watch(authControllerProvider).user?.role == Roles.admin
          ? FloatingActionButton(
              heroTag: null,
              onPressed: () {
                context.push(RoutePath.postCreate);
              },
              tooltip: 'Create Post',
              child: const Icon(Icons.add),
            )
          : const SizedBox.shrink(),
    );
  }
}
