import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/modules/edit_profile_screen.dart';
import 'package:continuelearning/SocialApp/modules/login/login_screen.dart';
import 'package:continuelearning/SocialApp/shared/components/components.dart';
import 'package:continuelearning/SocialApp/shared/constants/constants.dart';
import 'package:continuelearning/SocialApp/shared/network/local/cache_helper.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var userModel = cubit.userModel;
        return ConditionalBuilder(
            condition: cubit.userModel != null,
            builder: (context) => Column(
                  children: [
                    SizedBox(
                      height: 200,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image(
                              image: NetworkImage("${userModel?.coverImage}"),
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            foregroundColor: Colors.red,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage:
                                  NetworkImage("${userModel?.profileImage}"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "${userModel?.name}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${userModel?.bio}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: const Column(
                                children: [
                                  Text(
                                    "100",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Posts",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: const Column(
                                children: [
                                  Text(
                                    "257",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Photos",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: const Column(
                                children: [
                                  Text(
                                    "10k",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Followers",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: const Column(
                                children: [
                                  Text(
                                    "80",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Followings",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              child: const Text(
                                "Add Photos",
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              navigateTo(
                                context: context,
                                widget: EditProfileScreen(),
                                removeAllPrevious: false,
                              );
                            },
                            child: const Icon(Icons.edit),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                        style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(
                          Size.fromWidth(double.maxFinite),
                        )),
                        onPressed: () {
                          uId = null;
                          CacheHelper.removeData(key: "uId");
                          navigateTo(
                            context: context,
                            widget: LoginScreen(),
                            removeAllPrevious: true,
                          );
                        },
                        child: const Text(
                          "LOGOUT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(
                    color: defaultColor,
                    backgroundColor: Colors.white,
                  ),
                ));
      },
    );
  }
}
