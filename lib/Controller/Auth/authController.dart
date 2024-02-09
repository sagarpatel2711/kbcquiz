import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kbcquiz/Controller/fireDBController.dart';
import 'package:kbcquiz/Routes/pages.dart';

import '../../Utilitys/logger.dart';

class AuthController extends FireDBController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
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

      logger.w("dsad: ${user.phoneNumber}");
      Get.offAllNamed(Routes.homeView);
      return user;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<bool> googleSignOutMethod() async {
    try {
      await FirebaseAuth.instance.signOut();
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
