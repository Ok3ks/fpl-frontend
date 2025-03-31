import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/individualpage/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:fpl/home/home.dart';

import '../types.dart';

void main() {
  runApp(LoginView());
}

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Box',
      theme: ThemeData(
        useMaterial3: true, // Enable Material 3
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: LoginBox(),
    );
  }
}

class LoginBox extends ConsumerStatefulWidget {
  @override
  _LoginBoxState createState() => _LoginBoxState();
}

class _LoginBoxState extends ConsumerState<LoginBox> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool toggled = true;
  bool signIn = false;
  bool signInWithPassWord = false;
  bool forgotPassword = false;

  void toggleObscurePassword() {
    setState(() {
      toggled = !toggled;
    });
  }

  void _resetPassword() async {
    Participant currentUser = Participant(
        email: _emailController.text, password: _passwordController.text);
    await currentUser.sendEmailLink();
  }

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    final box = GetStorage();

    Participant currentUser = Participant(
        email: _emailController.text, password: _passwordController.text);
    dynamic loggedInUser = await currentUser.retrieveUser(password);

    // Mock logic for demonstration
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Email and Password cannot be empty.';
      });
    } else if (currentUser.error == 'wrong-password' ||
        currentUser.error == 'invalid-email') {
      setState(() {
        _errorMessage = 'Email or password supplied is incorrect';
      });
    } else if (currentUser.error == 'user-not-found') {
      // Proceed with login
      setState(() {
        _errorMessage = 'User does not exist, please Register and retry';
      });
    } else {
      // Proceed with login
      setState(() {
        _errorMessage = '';
      });
      //Update field with userHistory

      //TODO: Update currentUserProvider with desired State
      final snapshot = await userDbRef.where('email', isEqualTo: email).get();
      final userData = snapshot.docs.first.data() as Map<String, dynamic>;
      final local = GetStorage();
      // await currentUser.getHistory(participantID ?? "null");
      box.write('isLoggedIn', true);
      ref.read(currentUserProvider.notifier).state = Participant(
          email: userData['email'],
          favoriteTeam: userData['favoriteTeam'],
          participantId: userData['participantId'],
          yearsPlayingFpl: userData['yearsPlayingFpl'],
          username: userData['username'],
          history: userData['history']);

      local.write("participant", {
        "email": userData['email'],
        "favoriteTeam": userData['favoriteTeam'],
        "participantId": userData['participantId'],
        "yearsPlayingFpl": userData['yearsPlayingFpl'],
        "username": userData['username'],
      });

      // Navigator.of(context).pushNamed('/home');
      context.go('/home');
    }
  }

  void _register() {
    // Logic for registration (e.g., navigating to a registration page)
    context.go('/onboarding');
  }

  //TODO: Adjust Styling
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser == null) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Center(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: !forgotPassword
                      ? Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                  ),
                                  if (signInWithPassWord)
                                    // Row(
                                    //   children: [
                                    TextField(
                                      controller: _passwordController,
                                      obscureText: toggled ? true : false,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        errorText: _errorMessage.isNotEmpty
                                            ? _errorMessage
                                            : null,
                                      ),
                                    ),
                                  if (signInWithPassWord)
                                    IconButton(
                                        onPressed: toggleObscurePassword,
                                        icon: const Icon(Icons.remove_red_eye)),
                                  // ]),

                                  const SizedBox(height: 20),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              if (_passwordController
                                                  .text.isEmpty) {
                                                setState(() {
                                                  signInWithPassWord = true;
                                                });
                                              } else {
                                                _login();
                                              }
                                            },
                                            child: const Text(
                                              'Sign In',
                                            ),
                                            style: signInWithPassWord
                                                ? ButtonStyle()
                                                : ButtonStyle()),
                                        const SizedBox(width: 20),
                                        if (signInWithPassWord)
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                forgotPassword = true;
                                              });
                                              // _resetPassword();
                                            },
                                            child:
                                                const Text('Forgot Password'),
                                          ),
                                      ]),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                    onPressed: _register,
                                    child: const Text('Register'),
                                  ),
                                ]),
                          ),
                        )
                      : Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 60,
                              child: Column(children: [
                                Text(
                                    "A link to reset your password has been sent. Check your inbox"),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.mail),
                                        onPressed: () {
                                          // context.go("/");
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.keyboard_return),
                                        onPressed: () {
                                          setState(() {
                                            forgotPassword = false;
                                          });
                                          // context.go("/login");
                                        },
                                      )
                                    ])
                              ]),
                            ),
                          )))));
    } else {
      //TODO: Persist Login Session
      return const Home();
    }
  }
}
