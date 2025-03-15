import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/dataprovider.dart';
import 'package:fpl/home/onboarding.dart';
import 'package:fpl/individualpage/participantview.dart';
import 'package:fpl/individualpage/utils.dart';
import 'package:fpl/leaguepage/leagueview.dart';
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

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    print(password);

    User currentUser = User(email: email, password: password);
    dynamic loggedInUser = await currentUser.retrieveUser(password);

    // Mock logic for demonstration
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Email and Password cannot be empty.';
      });
    } else if (loggedInUser == 'null') {
      setState(() {
        _errorMessage = 'User does not exist, please register an account';
      });
    } else if (loggedInUser != null) {
      // Proceed with login
      setState(() {
        _errorMessage = '';
      });

      //TODO: Update currentUserProvider with desired State
      final snapshot = await userDbRef.where('email', isEqualTo: email).get();
      final userData = snapshot.docs.first.data() as Map<String, dynamic>;
      ref.read(currentUserProvider.notifier).state = User(
          email: userData['email'],
          favoriteTeam: userData['favoriteTeam'],
          fplUrl: parseParticipantIdFromUrl(userData['fplUrl']),
          yearsPlayingFpl: userData['yearsPlayingFpl'],
          username: userData['username']);
      print('Logged in successfully with email: $email');
      print(userData['favoriteTeam']);
      Navigator.pushNamed(context, "/home");
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
          title: Text('Login'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
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
                        errorText:
                            _errorMessage.isNotEmpty ? _errorMessage : null,
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText:
                            _errorMessage.isNotEmpty ? _errorMessage : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Sign In'),
                    ),
                    TextButton(
                      onPressed: _register,
                      child: Text('Register'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Logic for sending email link for password reset
                        print('Send password reset email');
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      //TODO: Persist Login Session
      return Home();
    }
  }
}
