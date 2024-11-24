import 'package:continuelearning/SocialApp/modules/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  // LoginModel? loginModel;

  void changeFocus() {
    emit(LoginChangeFocusState());
  }

  void postData({required String email, required String password}) {
    emit(LoginPostLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        emit(LoginPostSuccessState(uId: value.user?.uid));
      },
    ).catchError((error) {
      print(error.toString());
      emit(LoginPostErrorState(error: error.toString()));
    });
  }
}
