import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FPL Analytics Onboarding',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingFlow(),
    );
  }
}

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int currentStep = 0;
  final _formKey = GlobalKey<FormState>();
  
  // Form data
  String? name;
  String? email;
  String? favoriteTeam;
  String? yearsPlaying;

  final List<Map<String, String>> steps = [
    {
      'title': 'Welcome to FPL Analytics',
      'description': 'Your personal assistant for dominating Fantasy Premier League'
    },
    {
      'title': 'Tell us about yourself',
      'description': 'Help us personalize your experience'
    },
    {
      'title': 'Get Started',
      'description': 'You're all set to begin your journey to FPL mastery'
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

  Widget _buildWelcomeStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.emoji_events, size: 64, color: Colors.blue),
        const SizedBox(height: 24),
        const Text(
          'Enhance Your FPL Strategy',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        _buildFeatureItem(Icons.analytics, 'Advanced player performance analytics'),
        _buildFeatureItem(Icons.people, 'Team optimization suggestions'),
        _buildFeatureItem(Icons.trending_up, 'Price change predictions'),
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
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildFormStep() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) => name = value,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
            onSaved: (value) => email = value,
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Favorite Team',
              border: OutlineInputBorder(),
            ),
            items: teams.map((String team) {
              return DropdownMenuItem(
                value: team,
                child: Text(team),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                favoriteTeam = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your favorite team';
              }
              return null;
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
            onChanged: (String? value) {
              setState(() {
                yearsPlaying = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your experience';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, size: 64, color: Colors.amber),
        const SizedBox(height: 24),
        const Text(
          'You\'re All Set!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        const Text('Get ready to take your FPL game to the next level'),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Navigate to dashboard
            debugPrint('Navigating to dashboard');
          },
          child: const Text('Go to Dashboard'),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 0:
        return _buildWelcomeStep();
      case 1:
        return _buildFormStep();
      case 2:
        return _buildCompletionStep();
      default:
        return const SizedBox.shrink();
    }
  }

  void _handleNext() {
    if (currentStep == 1) {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();
        setState(() {
          currentStep++;
        });
      }
    } else {
      setState(() {
        currentStep = math.min(currentStep + 1, steps.length - 1);
      });
    }
  }

  void _handleBack() {
    setState(() {
      currentStep = math.max(currentStep - 1, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        color: stepIndex <= currentStep
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                      child: Center(
                        child: stepIndex < currentStep
                            ? const Icon(Icons.check, color: Colors.white, size: 16)
                            : Text(
                                '${stepIndex + 1}',
                                style: TextStyle(
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
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    steps[currentStep]['description']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                      child: const Text('Back'),
                    )
                  else
                    const SizedBox(width: 80),
                  if (currentStep < steps.length - 1)
                    ElevatedButton(
                      onPressed: _handleNext,
                      child: const Text('Next'),
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