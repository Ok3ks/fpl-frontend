import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/themes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../types.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBox(),
    );
  }
}

class LoginBox extends ConsumerStatefulWidget {
  const LoginBox({super.key});

  @override
  _LoginBoxState createState() => _LoginBoxState();
}

class _LoginBoxState extends ConsumerState<LoginBox> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool toggled = true;
  bool signInWithPassWord = false;
  bool forgotPassword = false;
  late bool loggedIn = false;

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
    dynamic LoggedInUser = await currentUser.retrieveUser(password);

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
      setState(() {
        _errorMessage = 'User does not exist, please Register and retry';
      });
    } else {
      setState(() {
        _errorMessage = '';
        loggedIn = true;
      });

      final snapshot = await userDbRef.where('email', isEqualTo: email).get();
      final userData = snapshot.docs.first.data() as Map<String, dynamic>;
      box.write('isLoggedIn', true);
      ref.read(currentUserProvider.notifier).state = Participant(
          email: userData['email'],
          favoriteTeam: userData['favoriteTeam'],
          participantId: userData['participantId'],
          yearsPlayingFpl: userData['yearsPlayingFpl'],
          username: userData['username'],
          history: userData['history']);

      box.write("participant", {
        "email": userData['email'],
        "favoriteTeam": userData['favoriteTeam'],
        "participantId": userData['participantId'],
        "yearsPlayingFpl": userData['yearsPlayingFpl'],
        "username": userData['username'],
      });

      context.go('/home');
    }
  }

  void _register() {
    context.go('/onboarding');
  }

  Widget _buildGradientButton(
      {required VoidCallback onPressed, required String text}) {
    final funkyGradient = ref.watch(funkyGradientProvider);
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: funkyGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 88, minHeight: 36),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget loginBox() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _emailController,
          style: GoogleFonts.poppins(),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: GoogleFonts.poppins(),
          ),
        ),
        if (signInWithPassWord)
          TextField(
            controller: _passwordController,
            obscureText: toggled,
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: GoogleFonts.poppins(),
              errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
              suffixIcon: IconButton(
                onPressed: toggleObscurePassword,
                icon: const Icon(Icons.remove_red_eye),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildGradientButton(
            text: 'Sign In',
            onPressed: () {
              if (!signInWithPassWord) {
                setState(() {
                  signInWithPassWord = true;
                });
              } else {
                _login();
              }
            },
          ),
          const SizedBox(width: 20),
          if (signInWithPassWord)
            TextButton(
              onPressed: () {
                setState(() {
                  forgotPassword = true;
                });
                _resetPassword();
              },
              child: Text('Forgot Password', style: GoogleFonts.poppins()),
            ),
        ]),
        const SizedBox(
          height: 15,
        ),
        TextButton(
          onPressed: _register,
          child: Text('No account? Register', style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final funkyGradient = ref.watch(funkyGradientProvider);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: !forgotPassword
              ? Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) =>
                              funkyGradient.createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        loginBox(),
                      ],
                    ),
                  ),
                )
              : Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          "A link to reset your password has been sent. Check your inbox.",
                          style: GoogleFonts.poppins(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.mail),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.keyboard_return),
                              onPressed: () {
                                setState(() {
                                  forgotPassword = false;
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
