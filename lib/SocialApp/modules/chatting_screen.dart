import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/models/message_model.dart';
import 'package:continuelearning/SocialApp/models/user_model.dart';
import 'package:continuelearning/SocialApp/shared/constants/constants.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChattingScreen extends StatelessWidget {
  final UserModel userModel;

  ChattingScreen({super.key, required this.userModel});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SocialCubit.get(context).getMessages(receiverId: userModel.uId as String);
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "${userModel.profileImage}",
                    // height: 150,
                    // width: 150,
                  ),
                ),
                const SizedBox(width: 15),
                Text(
                  "${userModel.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 23),
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  // shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var message = cubit.messages[index];
                    if (uId == message.senderId) return messageFromMe(message);
                    return messageToMe(message);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: cubit.messages.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          cubit.changeColorInTextField();
                        },
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.send,
                        color: textController.text.isNotEmpty
                            ? defaultColor
                            : null,
                      ),
                      onPressed: () {
                        if (textController.text.isNotEmpty) {
                          cubit.sendMessage(
                            receiverId: userModel.uId as String,
                            message: textController.text,
                            dateTime: DateTime.now().toString(),
                          );
                          textController.text = "";
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget messageToMe(MessageModel model) => Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  // bottomLeft: Radius.circular(20),
                )),
            child: Text(
              "${model.message}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      );

  Widget messageFromMe(MessageModel model) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: defaultColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )),
            child: Text(
              "${model.message}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}
