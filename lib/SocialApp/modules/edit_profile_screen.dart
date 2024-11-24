import 'package:continuelearning/SocialApp/cubit/cubit.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SocialUpdateProfileDataSuccessState) {
        showToast(
            message: "Data Updated Successfully",
            backgroundColor: ToastColors.success);
      } else if (state is SocialUpdateProfileDataErrorState) {
        showToast(
            message: "Failed to Update", backgroundColor: ToastColors.error);
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      var userModel = cubit.userModel;

      if (userModel != null) {
        nameController.text = userModel.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
      }

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              cubit.restFileImages();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
            ),
          ),
          title: const Text("Edit Profile"),
          actions: [
            TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    cubit.updateUser(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                    );
                  }
                },
                child: const Text(
                  "UPDATE",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image(
                            image: cubit.coverImageFile == null
                                ? NetworkImage("${userModel?.coverImage}")
                                : FileImage(cubit.coverImageFile!)
                                    as ImageProvider,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  cubit.pickCoverImage();
                                },
                                icon: const Icon(Icons.camera_alt_outlined),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          foregroundColor: Colors.red,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: cubit.profileImageFile == null
                                ? NetworkImage("${userModel?.profileImage}")
                                : FileImage(cubit.profileImageFile!)
                                    as ImageProvider,
                          ),
                        ),
                        CircleAvatar(
                          radius: 17,
                          child: IconButton(
                            onPressed: () {
                              cubit.pickProfileImage();
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultTextForm(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name must not be Empty";
                          }
                          return null;
                        },
                        label: "Name",
                        prefixIcon: Icons.person,
                        focusColor: defaultColor,
                      ),
                      const SizedBox(height: 10),
                      defaultTextForm(
                        controller: bioController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Bio must not be Empty";
                          }
                          return null;
                        },
                        label: "Bio",
                        prefixIcon: Icons.info_outline,
                        focusColor: defaultColor,
                      ),
                      const SizedBox(height: 10),
                      defaultTextForm(
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone must not be Empty";
                          }
                          return null;
                        },
                        label: "Phone",
                        prefixIcon: Icons.phone,
                        focusColor: defaultColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (state is SocialUpdateProfileDataLoadingState)
                LinearProgressIndicator(
                  color: defaultColor,
                  backgroundColor: Colors.white,
                ),
            ],
          ),
        ),
      );
    });
  }
}
