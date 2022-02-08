abstract class RegisterScreenStates{}

class RegisterScreenInitialState extends RegisterScreenStates{}

class RegisterScreenPasswordChanged extends RegisterScreenStates{}

class RegisterSuccessState extends RegisterScreenStates{}

class RegisterLoadingState extends RegisterScreenStates{}

class RegisterErrorState extends RegisterScreenStates{
  final String error;
   RegisterErrorState({required this.error});
}