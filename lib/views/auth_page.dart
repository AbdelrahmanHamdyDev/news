import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/app_fonts.dart';
import 'package:news/widgets/standalone_AppBar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _isLogin = true;

  Future<void> _authenticate() async {
    final supabase = Supabase.instance.client;
    setState(() => _loading = true);

    try {
      if (_isLogin) {
        // Login
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        // Register
        await supabase.auth.signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      Navigator.pushReplacementNamed(context, '/app');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandaloneAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1565C0).withValues(alpha: 0.5),
                      offset: Offset(5, 5),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage("assets/news_logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "${_isLogin ? 'Login' : 'Register'} to News",
                style: AppFonts.headlineLarge.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Text(
                "Stay Ahead. Stay Informed",
                style: AppFonts.bodyLarge.copyWith(color: Colors.grey[700]),
              ),
              SizedBox(height: 20.h),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: AppFonts.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: AppFonts.bodyMedium.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.h),
              _loading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          foregroundColor: Color(0xFF1565C0),
                        ),
                        onPressed: _authenticate,
                        child: Text(
                          _isLogin ? 'Login' : 'Register',
                          style: AppFonts.headlineMedium,
                        ),
                      ),
                    ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    _isLogin
                        ? "Don't have an account?"
                        : "Already have an account?",
                    style: AppFonts.bodyMedium.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF1565C0),
                    ),
                    onPressed: () => setState(() => _isLogin = !_isLogin),
                    child: Text(
                      _isLogin ? "Register" : "Login",
                      style: AppFonts.headlineMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
