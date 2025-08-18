import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpl/individualpage/utils.dart';
import 'package:fpl/theme_provider.dart';
import 'package:fpl/themes.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math';
import 'package:go_router/go_router.dart';
import 'package:fpl/types.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return const OnboardingFlow();
    // );
  }
}

class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key});

  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  int currentStep = 0;
  final box = GetStorage();

  final _formKey = GlobalKey<FormState>();

  // Form data
  String? username;
  String? email;
  String? fplUrl;
  String? favoriteTeam;
  String? yearsPlaying;
  String? password;
  String? _error;

  final List<Map<String, String>> steps = [
    {
      'title': 'Tell us about yourself',
      'description': 'Help us personalize your experience'
    },
    {'title': 'Secure your account', 'description': ''},
    {
      'title': 'Get Started',
      'description': "You're all set to begin your journey to FPL mastery",
    }
  ];

  final List<String> teams = [
    'Arsenal',
    'Aston Villa',
    'Brentford',
    'Brighton',
    'Burnley',
    'Chelsea',
    'Crystal Palace',
    'Everton',
    'Fulham',
    'Leeds United',
    'Liverpool',
    'Manchester City',
    'Manchester United',
    'Newcastle United',
    'Nottingham Forest',
    'Sunderland',
    'Tottenham Hotspur',
    'West Ham United',
    'Wolves'
  ];
  Widget _buildWelcomeStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.emoji_events, size: 64, color: Colors.blue),
        const SizedBox(height: 24),
        Text(
          'Enhance Your FPL Strategy',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildFeatureItem(Icons.analytics, 'Personal Season Reflection'),
        _buildFeatureItem(Icons.people,
            'League Analysis, keep an eye on your mini league, all in one view'),
        _buildFeatureItem(Icons.trending_up, 'Game View Dashboard'),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: GoogleFonts.poppins())),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildFormStep();
      case 1:
        return _addPassword();
      case 2:
        box.write("status", "registered");
        return _buildCompletionStep();
      default:
        return const SizedBox.shrink();
    }
  }

  void _handleBack() {
    setState(() {
      currentStep = max(currentStep - 1, 0);
    });
  }

  void _handleNext() async {
    if (currentStep == 2) {
      context.go('/login');
    } else if (currentStep == 1) {
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
              participantId: parseParticipantIdFromUrl(fplUrl!),
              yearsPlayingFpl: yearsPlaying!);

          UserCredential? currentUser =
              await registeringParticipant.registerUser();
          setState(() {
            _error = registeringParticipant.error;
          });
          setState(() {
            currentStep++;
          });
        }
      }
    } else if (currentStep == 0) {
      if (_formKey.currentState?.validate() ?? false) {
        setState(() {
          currentStep = min(currentStep + 1, steps.length - 1);
        });
      }
    } else {
      setState(() {
        currentStep = min(currentStep + 1, steps.length - 1);
      });
    }
  }

  Widget _buildFormStep() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              labelText: 'username',
              border: const OutlineInputBorder(),
              labelStyle: GoogleFonts.poppins(),
            ),
            onChanged: (String? value) {
              setState(() {
                username = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required field';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              labelText: 'Email',
              border: const OutlineInputBorder(),
              labelStyle: GoogleFonts.poppins(),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (String? value) {
              setState(() {
                email = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'required field';
              }
              if (!value.contains('@')) {
                return 'required field';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
              style: GoogleFonts.poppins(),
              autocorrect: false,
              // initialValue: "a",
              decoration: InputDecoration(
                labelText: 'Fantasy Premier League URL',
                border: const OutlineInputBorder(),
                hintTextDirection: TextDirection.ltr,
                hintText:
                    "https://fantasy.premierleague.com/entry/*****/event/**",
                labelStyle: GoogleFonts.poppins(),
                hintStyle: GoogleFonts.poppins(),
              ),
              keyboardType: TextInputType.url,
              onChanged: (String? value) {
                setState(() {
                  fplUrl = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required field';
                }
                if (!value.contains('entry')) {
                  return 'required field';
                }
                return null;
              }),
          ExpansionTile(
              leading: const Icon(Icons.sports_soccer),
              iconColor: MaterialTheme.darkMediumContrastScheme().primary,
              collapsedIconColor:
                  MaterialTheme.darkMediumContrastScheme().primary,
              childrenPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              maintainState: true,
              title: const Text('How can i find my FPL URL'),
              children: [
                Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " 1] From the official Fantasy Premier league page,navigate to the points tab.",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                      const Text(
                        " 2]  Copy the https link in the URL bar of your browser",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        " 3] Return to this page and past the copied link in the rectangular box",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                    ]),
              ]),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              labelText: 'Favorite Team',
              border: const OutlineInputBorder(),
              labelStyle: GoogleFonts.poppins(),
            ),
            items: teams.map((String team) {
              return DropdownMenuItem(
                value: team,
                child:
                    Text(team, style: GoogleFonts.poppins(color: Colors.grey)),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                favoriteTeam = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Be a proud Fan!';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            style: GoogleFonts.poppins(),
            decoration: InputDecoration(
              labelText: 'Years Playing FPL',
              border: const OutlineInputBorder(),
              labelStyle: GoogleFonts.poppins(),
            ),
            items: [
              DropdownMenuItem(
                  value: 'new',
                  child: Text('First Season',
                      style: GoogleFonts.poppins(color: Colors.grey))),
              DropdownMenuItem(
                  value: '1-2',
                  child: Text('1-2 Years',
                      style: GoogleFonts.poppins(color: Colors.grey))),
              DropdownMenuItem(
                  value: '3-5',
                  child: Text('3-5 Years',
                      style: GoogleFonts.poppins(color: Colors.grey))),
              DropdownMenuItem(
                  value: '5+',
                  child: Text('5+ Years',
                      style: GoogleFonts.poppins(color: Colors.grey)))
            ],
            onChanged: (String? value) {
              setState(() {
                yearsPlaying = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Been an addict since when?';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _addPassword() {
    return Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          _buildFeatureItem(Icons.key, 'A safe needs a passkey'),
          TextFormField(
            style: GoogleFonts.poppins(),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              errorText: _error,
              border: const OutlineInputBorder(),
              labelStyle: GoogleFonts.poppins(),
            ),
            onChanged: (String? value) {
              setState(() {
                password = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty || value.length < 4) {
                return 'Please enter a password with 4+ characters';
              }
              return null;
            },
            onSaved: (value) => password = value,
          ),
        ]));
    // )]);
  }

  Widget _buildCompletionStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, size: 64, color: Colors.amber),
        const SizedBox(height: 24),
        Text(
          'You\'re All Set!',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text('Get ready to take your FPL game to the next level',
            style: GoogleFonts.poppins()),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Navigate to dashboard
            debugPrint('Navigating to dashboard');
            context.go('/login');
          },
          child: Text('Now login to view your Dashboard',
              style: GoogleFonts.poppins()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final funkyGradient = ref.watch(funkyGradientProvider);
    final currentTheme = ref.watch(themeProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: List.generate(
                  steps.length * 2 - 1,
                  (index) {
                    if (index.isOdd) {
                      return Expanded(
                        child: Container(
                          height: 2,
                          color: index < currentStep * 2
                              ? Colors.blue
                              : Colors.grey[300],
                        ),
                      );
                    }
                    final stepIndex = index ~/ 2;
                    return Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient:
                            stepIndex <= currentStep ? funkyGradient : null,
                        color:
                            stepIndex <= currentStep ? null : Colors.grey[300],
                      ),
                      child: Center(
                        child: stepIndex < currentStep
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 16)
                            : Text(
                                '${stepIndex + 1}',
                                style: GoogleFonts.poppins(
                                  color: stepIndex <= currentStep
                                      ? Colors.white
                                      : Colors.grey[600],
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Step title and description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    steps[currentStep]['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    steps[currentStep]['description']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Step content
            Expanded(
              child: _buildStepContent(),
            ),
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0)
                    TextButton(
                      onPressed: _handleBack,
                      child: Text('Back', style: GoogleFonts.poppins()),
                    )
                  else
                    const SizedBox(width: 80),
                  if (currentStep < steps.length - 1)
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all<EdgeInsets>(
                            EdgeInsets.zero),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: _handleNext,
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: funkyGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          constraints:
                              const BoxConstraints(minWidth: 88, minHeight: 36),
                          alignment: Alignment.center,
                          child: Text(
                            'Next',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
