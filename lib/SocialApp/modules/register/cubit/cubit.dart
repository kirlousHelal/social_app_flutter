import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:continuelearning/SocialApp/models/user_model.dart';
import 'package:continuelearning/SocialApp/modules/register/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // LoginModel? loginModel;

  void changeFocus() {
    emit(RegisterChangeFocusState());
  }

  void postData({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterPostLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        saveData(
          uId: value.user?.uid,
          email: email,
          name: name,
          phone: phone,
        );
        // print(value.user?.uid);
        // loginModel = LoginModel.fromJson(value.data);
        // emit(RegisterPostSuccessState());
      },
    ).catchError((error) {
      print(error.toString());
      emit(RegisterPostErrorState());
    });
  }

  void saveData({
    required String? uId,
    required String name,
    required String email,
    required String phone,
  }) {
    emit(RegisterDataSavedLoadingState());
    UserModel userModel = UserModel(
      uId: uId,
      name: name,
      email: email,
      phone: phone,
      bio: "write your bio...",
      coverImage:
          "https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-36129.jpg?t=st=1731207245~exp=1731210845~hmac=36ddf26fb83214345c14e0376a592a7c0e1386ad4c5daa1070ab0aa40082713e&w=1380",
      profileImage:
          "https://img.freepik.com/free-photo/portrait-businesswoman-isolated-home_23-2148813223.jpg?t=st=1731205056~exp=1731208656~hmac=f1b838fc75a7ade877ec8ca563d3bc4c0b5da38a8b830c2c62e8d27ba64c448c&w=826",
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(userModel.toJson())
        .then(
      (value) {
        emit(RegisterDataSavedSuccessState(uId: uId));
      },
    ).catchError((error) {
      print(error.toString());
      emit(RegisterDataSavedErrorState());
    });
  }

  void checkFirebaseAuthConnection() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("No user is currently signed in, but Firebase is connected.");
    } else {
      print("Firebase is connected, and the current user is: ${user.email}");
    }
  }
}
