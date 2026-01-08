class AddExceptions implements Exception {
  final String errorMessage;
  const AddExceptions(this.errorMessage);
}

class RemoteException extends AddExceptions {
  const RemoteException(super.errorMessage);
}

class LocalException extends AddExceptions {
  const LocalException(super.errorMessage);
}
