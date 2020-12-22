import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vietnamese_learning/src/models/user_gmail.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final googleUser = GoogleSignIn();


Future<User_Gmail>googleSignIn() async{
  GoogleSignInAccount googleSignInAccount = await googleUser.signIn();
  if(googleSignInAccount!=null){
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken,accessToken: googleSignInAuthentication.accessToken);
    UserCredential result = await auth.signInWithCredential(credential);
    User user = await result.user;
    String username = user.email.substring(0, user.email.indexOf("@"));
    print(username);
    User_Gmail user_gmail = new User_Gmail(username, user.photoURL,user.email, user.displayName, user.uid);
    return user_gmail;
  }
}

Future<bool> signOutUser() async{
  if(auth.currentUser != null) {
    User user = await auth.currentUser;
    if (user.providerData[0].providerId == 'google.com') {
      await googleUser.disconnect();
    }
    await auth.signOut();
    return Future.value(true);
  }else{
    return Future.value(true);
  }
}