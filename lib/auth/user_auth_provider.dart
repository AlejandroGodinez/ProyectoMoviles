import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAlreadyLogged() {
    var user = FirebaseAuth.instance.currentUser;
    //print("user: ${user.displayName}");
    return user != null;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebase() async {
    await _auth.signOut();
  }

  //anonimo
  Future<void> anonymousSignIn() async {
    final anonymousUser = (await _auth.signInAnonymously()).user;
    await anonymousUser.updateProfile(
      displayName: "${anonymousUser.uid.substring(0, 5)}_Invitado",
    );
    await anonymousUser.reload();
  }

  Future<void> signInWithGoogle() async {
    // Google sign in
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    print('user: ${googleUser.displayName}');
    print('user: ${googleUser.email}');
    print('user: ${googleUser.photoUrl}');

    //credenciales para firebase
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //firebase sign in
    final authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    final firebaseAuthToken = await user.getIdToken();
    assert(!user.isAnonymous);
    assert(firebaseAuthToken != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print('Firebase user auth token: $firebaseAuthToken');
  }

  //Email and Password
  Future<void> registerNewUser(
    String email,
    String password,
    String name,
  ) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await FirebaseAuth.instance.currentUser.updateProfile(displayName: name);
    // try {
    //   await FirebaseAuth.instance
    //       .createUserWithEmailAndPassword(email: email, password: password);
    //   await FirebaseAuth.instance.currentUser.updateProfile(displayName: name);
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
  }

  Future<void> loginEmailUser(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // try {
    //   await FirebaseAuth.instance
    //       .signInWithEmailAndPassword(email: email, password: password);
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }
  }
}
