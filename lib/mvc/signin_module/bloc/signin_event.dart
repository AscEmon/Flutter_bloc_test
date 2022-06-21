abstract class SignInEvent {}


class SignInSubmitEvent extends SignInEvent {}

class PasswordShowEvent extends SignInEvent {}

class ValidateEvent extends SignInEvent {}
