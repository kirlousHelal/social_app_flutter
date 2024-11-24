import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        print(cubit.likes.length);
        print(cubit.posts.length);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty &&
              cubit.userModel != null &&
              cubit.likes.length == cubit.posts.length,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const Image(
                        image: NetworkImage(
                            "https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36129.jpg?t=st=1731207245~exp=1731210845~hmac=36ddf26fb83214345c14e0376a592a7c0e1386ad4c5daa1070ab0aa40082713e&w=1380"),
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 15),
                          child: const Text(
                            "Communicate with us",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        postBuilder(context, cubit, index),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: cubit.posts.length),
                const SizedBox(height: 100)
              ],
            ),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(
              color: defaultColor,
            ),
          ),
        );
      },
    );
  }

  Widget postBuilder(BuildContext context, SocialCubit cubit, int index) =>
      Card(
        margin: const EdgeInsets.all(8),
        elevation: 5,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage("${cubit.posts[index].profileImage}"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${cubit.posts[index].name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.verified,
                              color: defaultColor,
                              size: 18,
                            )
                          ],
                        ),
                        Text(
                          "${cubit.posts[index].dateTime}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz_outlined),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              if (cubit.posts[index].text!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    "${cubit.posts[index].text}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              Wrap(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5),
                      child: Text(
                        "#software_development",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: defaultColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5),
                      child: Text(
                        "#AI",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: defaultColor),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5),
                      child: Text(
                        "#Flutter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: defaultColor),
                      ),
                    ),
                  ),
                ],
              ),
              if (cubit.posts[index].postImage!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Image(
                    image: NetworkImage("${cubit.posts[index].postImage}"),
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 18,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5),
                          Text("${cubit.likes[index]}"),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.comment,
                            size: 18,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 8),
                          Text("${cubit.comments[index]} comment"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundImage:
                        NetworkImage("${cubit.userModel?.profileImage}"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: const Text(
                        "write a comment...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cubit.addLikePost(postId: cubit.postIds[index]);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Like"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
