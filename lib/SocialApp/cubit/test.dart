import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:flutter/material.dart';

extension CreatePost on SocialCubit {
  void testCreatePost({
    required String text,
    required String dateTime,
    required BuildContext context,
  }) {
    // Indicate loading state
    emit(SocialCreatePostLoadingState());

    if (postImageFile != null) {
      // If there's an image, upload it along with post data
      uploadPostImage(text: text, dateTime: dateTime, context: context);
    } else {
      // Otherwise, just upload the text and other info
      uploadPostInfo(text: text, dateTime: dateTime, context: context);
    }
  }
}
