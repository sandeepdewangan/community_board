import 'dart:io';

import 'package:domain/post.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/presentation_failure_exception.dart';
import '../providers/post_providers.dart';

final createPostMutation = Mutation<PostDisplay>();

Future<PostDisplay> runCreatePost({
  required WidgetRef ref,
  required String title,
  required String content,
  File? imageFile,
}) async {
  return await createPostMutation.run(ref, (tsx) async {
    final uploadPostImageUsecase = tsx.get(uploadPostImageUsecaseProvider);
    final createPostUsecase = tsx.get(createPostUsecaseProvider);

    String? postId;
    String? imageUrl;

    if (imageFile != null) {
      final uploadResult = await uploadPostImageUsecase(
        UploadPostImageParams(image: imageFile, postId: null),
      );
      uploadResult.fold(
        (failure) => throw PresentationFailureException(failure),
        (result) {
          postId = result.postId;
          imageUrl = result.imageUrl;
        },
      );
    }
    await Future.delayed(const Duration(seconds: 1));
    final createResult = await createPostUsecase(
      CreatePostParams(
        postId: postId,
        title: title,
        content: content,
        imageUrl: imageUrl,
      ),
    );
    return createResult.fold(
      (failure) => throw PresentationFailureException(failure),
      (created) => created,
    );
  });
}
