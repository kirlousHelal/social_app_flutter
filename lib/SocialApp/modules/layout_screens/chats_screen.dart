import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/models/user_model.dart';
import 'package:continuelearning/SocialApp/modules/chatting_screen.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
            condition: true,
            builder: (context) {
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      buildItemChat(cubit.users[index], context),
                  separatorBuilder: (context, index) => Container(
                        color: Colors.grey,
                        height: 1,
                      ),
                  itemCount: cubit.users.length);
            },
            fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                    backgroundColor: Colors.white,
                  ),
                ));
      },
    );
  }

  Widget buildItemChat(UserModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          navigateTo(
              context: context, widget: ChattingScreen(userModel: model));
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                "${model.profileImage}",
                // height: 150,
                // width: 150,
              ),
            ),
            const SizedBox(width: 30),
            Text(
              "${model.name}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            )
          ],
        ),
      ),
    );
  }
}
