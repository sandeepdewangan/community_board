import 'package:material_ui/material_ui.dart';

class UserProfilePage extends StatelessWidget {
  const new({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("User A Profile")));
  }
}
