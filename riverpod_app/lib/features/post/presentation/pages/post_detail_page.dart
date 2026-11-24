import 'package:material_ui/material_ui.dart';

class PostDetailPage extends StatelessWidget {
  const new({super.key, required this.postId});

  final String postId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Post id 5")));
  }
}
