import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Routes/pages.dart';

import '../../LocalDB/localDB.dart';
import '../../Utilitys/logger.dart';

class AuthController extends FireDBController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogleMethod() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      final userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      assert(!user!.isAnonymous);
      final User? currentUser = _auth.currentUser;
      assert(currentUser!.uid == user!.uid);
      await createNewUser(user!.displayName.toString(), user.email.toString(),
          user.photoURL.toString(), user.uid);

      await LocalDB.saveName(user.displayName.toString());
      await LocalDB.saveUrl(user.photoURL.toString());

      Get.offAllNamed(Routes.homeView);
      return user;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> googleSignOut() async {
    try {
      await googleSignIn.signOut();
      await _auth.signOut();

      await LocalDB.saveUserID("Null");
      Get.offAllNamed(Routes.signInView);
      return true;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  // @override
  // void onInit() {
  //   signInWithGoogleMethod();
  //   // TODO: implement onInit
  //   super.onInit();
  // }
}
