import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/modules/create_post_screen.dart';
import 'package:continuelearning/SocialApp/shared/components/components.dart';
import 'package:continuelearning/SocialApp/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).setUpData();

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialChangeToCreatePostState) {
            navigateTo(
              context: context,
              widget: CreatePostScreen(),
              removeAllPrevious: false,
            );
          }
        },
        builder: (context, state) {
          // var currentUser = FirebaseAuth.instance.currentUser;

          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search_rounded),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active_outlined),
                ),
                const SizedBox(width: 10),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              unselectedItemColor: Colors.grey,
              selectedItemColor: defaultColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.shifting,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
            body: IndexedStack(
              index: cubit.currentIndex,
              children: cubit.bottomScreens,
            ),
          );
        },
      );
    });
  }
}

///
// if (!currentUser!.emailVerified)
//   Container(
//     color: Colors.amber[300],
//     child: Padding(
//       padding: const EdgeInsets.all(3.0),
//       child: Row(
//         children: [
//           const Icon(Icons.warning_amber),
//           const SizedBox(
//             width: 15,
//           ),
//           const Text("Please verify your account"),
//           const Spacer(),
//           TextButton(
//               onPressed: () {
//                 currentUser?.sendEmailVerification();
//               },
//               child: const Text("SEND VERIFICATION"))
//         ],
//       ),
//     ),
//   )
///
