abstract class ITneExceptions implements Exception {
  String message = "Falha na autenticação.";
  ITneExceptions({required this.message});
}

class EmailAlreadyExistsException extends ITneExceptions {
  @override
  EmailAlreadyExistsException({super.message = "E-mail já cadastrado."});
}

class TooManyAttemptsException extends ITneExceptions {
  @override
  TooManyAttemptsException({
    super.message = 'Acesso bloqueado temporariamente. Tente mais tarde.',
  });
}

class DataException extends ITneExceptions {
  @override
  DataException({super.message = "Dado inválido."});
}

class BadRequestJackException extends ITneExceptions {
  @override
  BadRequestJackException({
    super.message = "Falha ao tentar acessar. Por favor tente mais tarde",
  });
}

class WithoutAccountException extends ITneExceptions {
  @override
  WithoutAccountException({
    super.message = "Não encontramos seu cadastro no Tá na escola.",
  });
}

class EmailOrPasswordException extends ITneExceptions {
  @override
  EmailOrPasswordException({super.message = "Email ou senha estão incorretos"});
}

class InvalidPasswordException extends ITneExceptions {
  @override
  InvalidPasswordException({super.message = "Senha informada não confere"});
}

class DisabledUserException extends ITneExceptions {
  @override
  DisabledUserException({
    super.message = "A conta do usuário foi desativada pelo administrador.",
  });
}

class InactiveUserException extends ITneExceptions {
  @override
  InactiveUserException({
    super.message =
        "A conta do usuário ainda não foi ativada pelo administrador.",
  });
}

class DisabledClientException extends ITneExceptions {
  @override
  DisabledClientException({
    super.message = "A sua empresa está inativa. Fale com o administrador",
  });
}
