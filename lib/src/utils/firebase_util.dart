import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleUser = GoogleSignIn();


Future<bool>googleSignIn() async{
  GoogleSignInAccount googleSignInAccount = await googleUser.signIn();

  if(googleSignInAccount!=null){
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken,accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(credential);
    User user = await result.user;
    print(user.uid);
    print(user.email);
    print(user.displayName);

    return Future.value(true);
  }
}

Future<bool> signOutUser() async{
  User user = await auth.currentUser;
  if(user.providerData[1].providerId == 'google.com'){
    await googleUser.disconnect();
  }
  await auth.signOut();
  return Future.value(true);
}