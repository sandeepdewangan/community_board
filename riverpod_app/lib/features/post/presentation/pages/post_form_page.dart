import 'package:material_ui/material_ui.dart';

class PostFormPage extends StatelessWidget {
  const new({super.key, this.postId});
  final String? postId;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Post Form Page")));
  }
}
