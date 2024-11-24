abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangeFocusState extends RegisterStates {}

class RegisterPostLoadingState extends RegisterStates {}

class RegisterPostSuccessState extends RegisterStates {}

class RegisterPostErrorState extends RegisterStates {}

class RegisterDataSavedLoadingState extends RegisterStates {}

class RegisterDataSavedSuccessState extends RegisterStates {
  final String? uId;

  RegisterDataSavedSuccessState({required this.uId});
}

class RegisterDataSavedErrorState extends RegisterStates {}
