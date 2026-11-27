import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login will be connected when the backend is ready.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 56,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 28),
                          Text(
                            'STUDENT WELLNESS',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.4,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Welcome back to your '
                                      " wellbeing space",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sign in to continue to your wellbeing space.',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: const Color(0xFF64716B),
                                ),
                          ),
                          const SizedBox(height: 36),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.email],
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                              hintText: 'you@example.com',
                            ),
                            validator: (value) {
                              final email = value?.trim() ?? '';
                              if (email.isEmpty || !email.contains('@')) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 18),
                          TextFormField(
                            obscureText: !_isPasswordVisible,
                            textInputAction: TextInputAction.done,
                            autofillHints: const [AutofillHints.password],
                            onFieldSubmitted: (_) => _submit(),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                tooltip: _isPasswordVisible
                                    ? 'Hide password'
                                    : 'Show password',
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.length < 8) {
                                return 'Password must be at least 8 characters';
                              }
                              return null;
                            },
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Password recovery will be added later.',
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Forgot password?'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 54,
                            child: FilledButton(
                              onPressed: _submit,
                              child: const Text('Sign in'),
                            ),
                          ),
                     const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const DashboardScreen(),
                              ),
                            );
                          },
                          child: const Text('Continue as guest'),
                        ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('New here?'),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Account creation will be added later.',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Create an account'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}