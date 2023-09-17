import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final AuthService _instance = AuthService._constructor();
  late GoogleSignIn _googleSignIn;

  ///constructeur privé - singleton
  AuthService._constructor() {
    ///variable initialisé au constructeur ne nécessite pas d'etre réinstancier à chaque passage
    ///à la fonction signInWithGoogle , un seul utilisateur sur l'application
    _googleSignIn = GoogleSignIn();
  }

  factory AuthService() => _instance;

  ///Fonction permettant de déclencher la connexion au compte Google
  Future<GoogleSignInAuthentication> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = _googleSignIn.currentUser;
    if (googleSignInAccount != null) {
      return googleSignInAccount.authentication;
    }

    final GoogleSignInAccount? googleAccountSignIn =
        await _googleSignIn.signIn();

    if (googleAccountSignIn == null) {
      throw Exception("Impossible de se connecter à Google");
    }

    final GoogleSignInAuthentication googleAuthenticationAccount =
        await googleAccountSignIn.authentication;
    return googleAuthenticationAccount;
  }

  Future<User?> signInToFirestore(
      {required GoogleSignInAuthentication googleSignInAuthentication}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user;
    }

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {}

    return user;
  }

  void signOutFromFirebase(User? user) {
    if (user == null) {
      throw Exception();
    }
    //je me déconnecte de firebase
    FirebaseAuth.instance.signOut();
    //je déconnecte le compte google qui a servit à se connecter à firebase
    _googleSignIn.signOut();
  }

  /// Fonction permettante de récupérer le user du compte google utiliser par l'utilisateur
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  bool isSignInWithFirebase() {
    return getCurrentUser() != null;
  }
}
