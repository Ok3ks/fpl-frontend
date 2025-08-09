import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/individualpage/utils.dart';
import 'package:fpl/utils.dart' hide parseParticipantIdFromUrl;
import 'package:go_router/go_router.dart';
import 'package:fpl/types.dart';

void main() {
  runApp(const Onboarding());
}

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPL League Analytics Tool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingFlow(),
    );
  }
}

class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  int currentStep = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Form data
  String? username;
  String? email;
  String? fplUrl;
  String? miniLeagueUrlI;
  String? miniLeagueUrlII;
  String? miniLeagueUrlIII;
  String? favoriteTeam;
  String? yearsPlaying;
  String? password;
  String? _error;

  final List<Map<String, String>> steps = [
    {
      'title': 'Welcome to FplWrapped',
      'description': 'FplWrapped is made for participants and miniLeagues!'
    },
    {
      'title': 'Tell us about yourself',
      'description': 'Help us personalize your experience'
    },
    {'title': 'Secure your account', 'description': ''},
    {
      'title': 'Get Started',
      'description': "You're all set to begin your journey to FPL mastery"
    }
  ];

  final List<String> teams = [
    'Arsenal',
    'Aston Villa',
    'Brighton',
    'Burnley',
    'Chelsea',
    'Crystal Palace',
    'Everton',
    'Leeds United',
    'Leicester City',
    'Liverpool',
    'Manchester City',
    'Manchester United',
    'Newcastle United',
    'Norwich City',
    'Southampton',
    'Tottenham Hotspur',
    'Watford',
    'West Ham United',
    'Wolves'
  ];

  // ------------------ UI Section ------------------

  // Welcome Step
  Widget _buildWelcomeStep() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(
        Icons.emoji_events,
        size: 64,
        color: Colors.blue,
      ),
      const SizedBox(height: 24),
      const Text(
        'Enhance Your FPL Strategy',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 24),
      _buildFeatureItem(
          icon: Icons.analytics, text: 'Keep an Eye on your mini leagues'),
    ]);
  }

  Widget _buildFeatureItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Form Step
  Widget _buildFormStep() {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please enter a username'
                      : null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 48),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Fantasy Premier League URL',
                  border: OutlineInputBorder(),
                  hintTextDirection: TextDirection.ltr,
                  hintText:
                      "https://fantasy.premierleague.com/entry/*****/event/**",
                ),
                keyboardType: TextInputType.url,
                onChanged: (value) {
                  setState(() {
                    fplUrl = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Fantasy Premier League URL';
                  }
                  if (!value.contains('entry')) {
                    return 'Please enter a valid Fantasy Premier League URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Mini League URL I',
                  border: OutlineInputBorder(),
                  hintTextDirection: TextDirection.ltr,
                  hintText:
                      "https://fantasy.premierleague.com/leagues/*****/standings/**",
                ),
                keyboardType: TextInputType.url,
                onChanged: (value) {
                  setState(() {
                    miniLeagueUrlI = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Fantasy Premier League URL';
                  }
                  if (!value.contains('leagues')) {
                    return 'Please enter a valid Mini League URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Mini League URL II',
                  border: OutlineInputBorder(),
                  hintTextDirection: TextDirection.ltr,
                  hintText:
                      "https://fantasy.premierleague.com/leagues/*****/standings/**",
                ),
                keyboardType: TextInputType.url,
                onChanged: (value) {
                  setState(() {
                    miniLeagueUrlII = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Fantasy Premier League URL';
                  }
                  if (!value.contains('leagues')) {
                    return 'Please enter a valid Mini League URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                autocorrect: false,
                decoration: const InputDecoration(
                  labelText: 'Mini League URL III',
                  border: OutlineInputBorder(),
                  hintTextDirection: TextDirection.ltr,
                  hintText:
                      "https://fantasy.premierleague.com/leagues/*****/standings/**",
                ),
                keyboardType: TextInputType.url,
                onChanged: (value) {
                  setState(() {
                    miniLeagueUrlIII = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Fantasy Premier League URL';
                  }
                  if (!value.contains('leagues')) {
                    return 'Please enter a valid Mini League URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 48),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Favorite Team',
                  border: OutlineInputBorder(),
                ),
                items: teams.map((team) {
                  return DropdownMenuItem<String>(
                    value: team,
                    child: Text(team),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    favoriteTeam = value;
                  });
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please select your favorite team'
                      : null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Years Playing FPL',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'new', child: Text('First Season')),
                  DropdownMenuItem(value: '1-2', child: Text('1-2 Years')),
                  DropdownMenuItem(value: '3-5', child: Text('3-5 Years')),
                  DropdownMenuItem(value: '5+', child: Text('5+ Years')),
                ],
                onChanged: (value) {
                  setState(() {
                    yearsPlaying = value;
                  });
                },
                validator: (value) {
                  return (value == null || value.isEmpty)
                      ? 'Please select your experience'
                      : null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Password Step
  Widget _buildPasswordStep() {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeatureItem(
                  icon: Icons.key, text: 'Please enter a password'),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  errorText: _error,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                validator: (value) {
                  return (value == null || value.isEmpty || value.length < 4)
                      ? 'Please enter a password with 4+ characters'
                      : null;
                },
                onSaved: (value) => password = value,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Completion Step
  Widget _buildCompletionStep() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.star, size: 64, color: Colors.amber),
          const SizedBox(height: 24),
          const Text(
            'You\'re All Set!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Get ready to take your FPL game to the next level',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              debugPrint('Navigating to dashboard');
              context.go('/login');
            },
            child: const Text('Now login to view your Dashboard'),
          ),
        ],
      ),
    );
  }

  // Progress Indicator
  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isOdd) {
            return Expanded(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: index < currentStep * 2
                        ? [Colors.blueAccent, Colors.blue]
                        : [Colors.grey.shade300, Colors.grey.shade300],
                  ),
                ),
              ),
            );
          }
          final int stepIndex = index ~/ 2;
          return Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  stepIndex <= currentStep ? Colors.blue : Colors.grey.shade300,
              boxShadow: [
                if (stepIndex <= currentStep)
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Center(
              child: stepIndex < currentStep
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : Text(
                      '${stepIndex + 1}',
                      style: TextStyle(
                        color: stepIndex <= currentStep
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
            ),
          );
        }),
      ),
    );
  }

  // ------------------ Build ------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator at the top
            _buildProgressIndicator(),
            // Titles for each step
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    steps[currentStep]['title']!,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    steps[currentStep]['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            // Dynamic content based on current step
            Expanded(
              child: SingleChildScrollView(
                child: _buildStepContent(),
              ),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0)
                    TextButton(
                      onPressed: () =>
                          setState(() => currentStep = max(currentStep - 1, 0)),
                      child: const Text('Back', style: TextStyle(fontSize: 16)),
                    )
                  else
                    const SizedBox(width: 80),
                  if (currentStep < steps.length - 1)
                    ElevatedButton(
                      onPressed: () async {
                        if (currentStep == 2) {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            print(
                                "$favoriteTeam, $username, $email, $fplUrl, $yearsPlaying, $password");
                            if (favoriteTeam != null &&
                                username != null &&
                                email != null &&
                                fplUrl != null &&
                                yearsPlaying != null &&
                                password != null) {
                              Participant registeringParticipant = Participant(
                                  favoriteTeam: favoriteTeam!,
                                  username: username!,
                                  password: password!,
                                  email: email!,
                                  participantId:
                                      parseParticipantIdFromUrl(fplUrl!),
                                  yearsPlayingFpl: yearsPlaying!,
                                  leagues: [
                                    parseLeagueCodeFromUrl(miniLeagueUrlI!),
                                    parseLeagueCodeFromUrl(miniLeagueUrlII!),
                                    parseLeagueCodeFromUrl(miniLeagueUrlIII!)
                                  ]);
                              UserCredential? currentUser =
                                  await registeringParticipant.registerUser();
                              setState(() {
                                _error = registeringParticipant.error;
                              });
                              setState(() {
                                currentStep =
                                    min(currentStep + 1, steps.length - 1);
                              });
                            }
                          }
                        } else if (currentStep == 1) {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() {
                              currentStep =
                                  min(currentStep + 1, steps.length - 1);
                            });
                          }
                        } else {
                          setState(() {
                            currentStep =
                                min(currentStep + 1, steps.length - 1);
                          });
                        }
                      },
                      child: const Text('Next', style: TextStyle(fontSize: 16)),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------ Helpers ------------------

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildFormStep();
      case 2:
        return _buildPasswordStep();
      case 3:
        return _buildCompletionStep();
      default:
        return const SizedBox.shrink();
    }
  }
}
