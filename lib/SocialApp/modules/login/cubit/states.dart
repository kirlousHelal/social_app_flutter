abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeFocusState extends LoginStates {}

class LoginPostLoadingState extends LoginStates {}

class LoginPostSuccessState extends LoginStates {
  final String? uId;

  LoginPostSuccessState({required this.uId});
}

class LoginPostErrorState extends LoginStates {
  final String? error;

  LoginPostErrorState({required this.error});
}
