import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:continuelearning/SocialApp/cubit/states.dart';
import 'package:continuelearning/SocialApp/models/message_model.dart';
import 'package:continuelearning/SocialApp/models/post_model.dart';
import 'package:continuelearning/SocialApp/models/user_model.dart';
import 'package:continuelearning/SocialApp/modules/create_post_screen.dart';
import 'package:continuelearning/SocialApp/modules/layout_screens/chats_screen.dart';
import 'package:continuelearning/SocialApp/modules/layout_screens/home_screen.dart';
import 'package:continuelearning/SocialApp/modules/layout_screens/settings_screen.dart';
import 'package:continuelearning/SocialApp/modules/layout_screens/users_screen.dart';
import 'package:continuelearning/SocialApp/shared/components/components.dart';
import 'package:continuelearning/SocialApp/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const ChatsScreen(),
    CreatePostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    "Home",
    "Chats",
    "Create Post",
    "Users",
    "Settings",
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.wechat_sharp), label: "Chats"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.upload_file_outlined), label: "Post"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.location_history), label: "Users"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: "Settings"),
  ];

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    if (index == 2) {
      emit(SocialChangeToCreatePostState());
      currentIndex = 0;
      return;
    }
    if (index == 1) getAllUserData();

    currentIndex = index;
    emit(SocialChangeBottomNavBarState());
  }

  void changeColorInTextField() {
    emit(SocialChangeColorState());
  }

  void restAllValues() {
    currentIndex = 0;
    userModel = null;
    posts.clear();
    likes.clear();
    comments.clear();
  }

  void setUpData() {
    restAllValues();
    getUserData();
    getPosts();
    // getLikesPost();
  }

  List<UserModel> users = [];

  void getAllUserData() {
    // emit(SocialGetProfileDataLoadingState());
    users.clear();
    FirebaseFirestore.instance.collection("users").get().then(
      (value) {
        var count = 0;
        var lstTrial = value.docs.length - 1;
        value.docs.forEach((element) {
          if (uId != element.id) users.add(UserModel.fromJson(element.data()));
          if (count == lstTrial) {
            emit(SocialGetAllUsersSuccessState());
          }
          count++;
        });
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState());
    });
  }

  UserModel? userModel;

  void getUserData() {
    // emit(SocialGetProfileDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then(
      (value) {
        userModel = UserModel.fromJson(value.data() as Map<String, dynamic>);
        uId = userModel?.uId;
        emit(SocialGetProfileDataSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialGetProfileDataErrorState());
    });
  }

  final ImagePicker picker = ImagePicker();

  File? coverImageFile;

  void pickCoverImage() {
    picker.pickImage(source: ImageSource.gallery).then(
      (pickedFile) {
        if (pickedFile != null) {
          coverImageFile = File(pickedFile.path);
        } else {
          print("No image selected.");
        }
        emit(SocialCoverImagePickedSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialCoverImagePickedErrorState());
    });
  }

  File? profileImageFile;

  void pickProfileImage() {
    picker.pickImage(source: ImageSource.gallery).then(
      (pickedFile) {
        if (pickedFile != null) {
          profileImageFile = File(pickedFile.path);
        } else {
          print("No image selected.");
        }
        emit(SocialProfileImagePickedSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialProfileImagePickedErrorState());
    });
  }

  void restFileImages() {
    coverImageFile = null;
    profileImageFile = null;
    postImageFile = null;
    emit(SocialRestFileImagesState());
  }

  void uploadProfileImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(profileImageFile!.path).pathSegments.last}")
        .putFile(profileImageFile!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            userModel?.profileImage = value;
            print("upload profile image");
            print(userModel?.profileImage);
            uploadInfo(name: name, bio: bio, phone: phone);
          },
        ).catchError((error) {
          print(error.toString());
        });
      },
    ).catchError((error) {
      print(error.toString());
    });
  }

  void uploadCoverImage({
    required String name,
    required String bio,
    required String phone,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("users/${Uri.file(coverImageFile!.path).pathSegments.last}")
        .putFile(coverImageFile!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            userModel?.coverImage = value;
            print("upload cover image");
            print(userModel?.coverImage);
            uploadInfo(name: name, bio: bio, phone: phone);
          },
        ).catchError((error) {
          print(error.toString());
        });
      },
    ).catchError((error) {
      print(error.toString());
    });
  }

  void uploadInfo({
    required String name,
    required String bio,
    required String phone,
  }) {
    UserModel model = UserModel(
      uId: userModel?.uId,
      name: name,
      email: userModel?.email,
      phone: phone,
      bio: bio,
      coverImage: userModel?.coverImage,
      profileImage: userModel?.profileImage,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .update(model.toJson())
        .then(
      (value) {
        updatePostsAfterUpdateUser(name: name);
        // print("Info");
        // print(userModel?.coverImage);
        restFileImages();
        emit(SocialUpdateProfileDataSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialUpdateProfileDataErrorState());
    });
  }

  void updatePostsAfterUpdateUser({required String name}) {
    int index = 0;
    bool isSetupData = false;
    for (var post in posts) {
      if (post.uId == uId) {
        isSetupData = true;
        post = PostModel(
          uId: uId,
          name: name,
          text: post.text,
          postImage: post.postImage,
          dateTime: post.dateTime,
          profileImage: userModel?.profileImage,
        );
        FirebaseFirestore.instance
            .collection("posts")
            .doc(postIds[index])
            .update(post.toJson())
            .then(
          (value) {
            setUpData();
          },
        );
      }
      index++;
    }
    if (!isSetupData) setUpData();
  }

  void updateUser({
    required String name,
    required String bio,
    required String phone,
  }) {
    emit(SocialUpdateProfileDataLoadingState());

    if (profileImageFile != null) {
      uploadProfileImage(name: name, bio: bio, phone: phone);
    }
    if (coverImageFile != null) {
      uploadCoverImage(name: name, bio: bio, phone: phone);
    }
    if (profileImageFile == null && coverImageFile == null) {
      uploadInfo(name: name, bio: bio, phone: phone);
    }
  }

  File? postImageFile;

  void pickPostImage() {
    picker.pickImage(source: ImageSource.gallery).then(
      (pickedFile) {
        if (pickedFile != null) {
          postImageFile = File(pickedFile.path);
        } else {
          print("No image selected.");
        }
        emit(SocialPostImagePickedSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialPostImagePickedErrorState());
    });
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
    required context,
  }) {
    FirebaseStorage.instance
        .ref()
        .child("posts/${Uri.file(postImageFile!.path).pathSegments.last}")
        .putFile(postImageFile!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            uploadPostInfo(
                text: text,
                dateTime: dateTime,
                postImage: value,
                context: context);
          },
        ).catchError((error) {
          print(error.toString());
        });
      },
    ).catchError((error) {
      print(error.toString());
    });
  }

  void uploadPostInfo({
    required String text,
    required String dateTime,
    required context,
    String? postImage,
  }) {
    PostModel model = PostModel(
      uId: userModel?.uId,
      name: userModel?.name,
      profileImage: userModel?.profileImage,
      dateTime: dateTime,
      postImage: postImage ?? "",
      text: text,
    );
    FirebaseFirestore.instance.collection("posts").add(model.toJson()).then(
      (value) {
        getPosts();
        // print("Info");
        // print(userModel?.coverImage);
        restFileImages();
        showToast(
          message: "Post Added Successfully",
          backgroundColor: ToastColors.success,
        );
        Navigator.pop(context);
        emit(SocialCreatePostSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postIds = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    likes.clear();
    comments.clear();
    posts.clear();

    FirebaseFirestore.instance.collection("posts").get().then(
      (value) {
        var count = 0;
        var lastTrial = value.docs.length - 1;
        value.docs.forEach(
          (element) {
            element.reference.collection("likes").get().then((value) {
              likes.add(value.docs.length);
              comments.add(value.docs.length);
              // print(likes);
              postIds.add(element.id);
              posts.add(PostModel.fromJson(element.data()));
              if (count == lastTrial) {
                emit(SocialGetPostsSuccessState());
              }
              count++;
            });
          },
        );
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialGetPostsErrorState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    required context,
  }) {
    emit(SocialCreatePostLoadingState());

    if (postImageFile != null) {
      uploadPostImage(text: text, dateTime: dateTime, context: context);
    } else {
      uploadPostInfo(text: text, dateTime: dateTime, context: context);
    }
  }

  void addLikePost({required String postId}) {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(uId)
        .set({"like": true}).then(
      (value) {
        // getLikesPost();
        getPosts();
        emit(SocialAddLikePostSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialAddLikePostErrorState());
    });
  }

  void sendMessage({
    required String receiverId,
    required String message,
    required String dateTime,
  }) {
    MessageModel messageModel = MessageModel(
      message: message,
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: uId,
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(messageModel.toJson())
        .then(
      (value) {
        emit(SocialSendMessageSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(uId)
        .collection("messages")
        .add(messageModel.toJson())
        .then(
      (value) {
        // getMessages(receiverId: receiverId);
        emit(SocialSendMessageSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy('dateTime')
        .snapshots()
        .listen(
      (event) {
        var count = 0;
        var lst = event.docs.length - 1;
        messages.clear();
        event.docs.forEach(
          (element) {
            messages.add(MessageModel.fromJson(element.data()));
            // if (count == lst)
            // count++;
          },
        );
        emit(SocialGetMessagesSuccessState());
      },
    );
  }
}
