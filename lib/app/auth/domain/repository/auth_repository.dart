abstract class AuthRepository {
  Future<bool> isUserLoggedIn();

  Future<bool> loginWithGoogle();

  Future<bool> loginWithUsernameAndPassword({
    required String username,
    required String password,
  });

  Future<bool> logout();

  Future<bool> isNewbie();
}
