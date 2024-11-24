import 'dart:io';

import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/shared/components/components.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});

  var textPostController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, SocialStates state) {},
      builder: (BuildContext context, SocialStates state) {
        var cubit = SocialCubit.get(context);
        var widthMobile = MediaQuery.of(context).size.width;
        var heightMobile = MediaQuery.of(context).size.height;
        var userModel = cubit.userModel;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                // cubit.restFileImages();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
            ),
            title: const Text("Create Post"),
            actions: [
              TextButton(
                  onPressed: () {
                    // if (formKey.currentState!.validate()) {}
                    if (textPostController.text.isNotEmpty ||
                        cubit.postImageFile != null) {
                      cubit.createPost(
                        text: textPostController.text,
                        dateTime: DateFormat('yyyy-MM-dd HH:mm')
                            .format(DateTime.now()),
                        context: context,
                      );
                    } else {
                      showToast(
                        message: "Post Can't be Empty",
                        backgroundColor: ToastColors.error,
                      );
                    }
                  },
                  child: const Text(
                    "POST",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  )),
              const SizedBox(width: 10),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is SocialCreatePostLoadingState)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: LinearProgressIndicator(
                        color: defaultColor,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage("${userModel?.profileImage}"),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          "${userModel?.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightMobile * 0.02,
                    // height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: cubit.postImageFile != null
                          ? heightMobile * 0.266
                          : heightMobile * 0.7,
                    ),
                    child: TextField(
                      controller: textPostController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: 'What’s on your mind?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (cubit.postImageFile != null)
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            cubit.postImageFile as File,
                            height: 300,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          CircleAvatar(
                            radius: 15,
                            child: IconButton(
                              onPressed: () {
                                cubit.restFileImages();
                              },
                              icon: const Icon(
                                Icons.close,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            cubit.pickPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo,
                                color: defaultColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Add Photo",
                                style: TextStyle(color: defaultColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "# tags",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: defaultColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
