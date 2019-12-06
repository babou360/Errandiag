import 'package:errandiaga/model/user.dart';
import 'package:errandiaga/notifier/auth_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

login(User user,AuthNotifier authNotifier) async{
  AuthResult authResult= await FirebaseAuth.instance.
    signInWithEmailAndPassword( email: user.email,password: user.password
  ).catchError((error)=> print(error.code));

  if(authResult!=null){
    FirebaseUser firebaseUser=authResult.user;

    if(firebaseUser!=null){
      print("Login: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
  }
}
signUp(User user,AuthNotifier authNotifier) async{
  AuthResult authResult= await FirebaseAuth.instance.
    createUserWithEmailAndPassword( email: user.email,password: user.password
  ).catchError((error)=> print(error.code));

  if(authResult!=null){
    UserUpdateInfo updateInfo=UserUpdateInfo();
    updateInfo.displayName=user.displayName;
    FirebaseUser firebaseUser=authResult.user;

    if(firebaseUser!=null){
      await firebaseUser.updateProfile(updateInfo);
      await firebaseUser.reload();
      print("Sign uo: $firebaseUser");

      FirebaseUser currentUser=await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}
signOut(AuthNotifier authNotifier) async{
  await FirebaseAuth.instance.signOut().
  catchError((error)=> print(error.code));
  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async{
  FirebaseUser firebaseUser=await FirebaseAuth.instance.currentUser(); 

  if(firebaseUser!=null){
    authNotifier.setUser(firebaseUser);
  }
}