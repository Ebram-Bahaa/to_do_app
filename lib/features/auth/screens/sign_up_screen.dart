import 'package:flutter/material.dart';
import 'package:to_do_app/features/auth/cubit/auth_cubit.dart';
import 'package:to_do_app/features/auth/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth/screens/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Enter Your Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter your Email";
                }
                if (!value.contains('@')) {
                  return "Please Enter Valid Email";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: passwordcontroller,
              obscureText: isObscure,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  icon: Icon(
                    isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please Enter Your Password";
                }
                if (value.length < 6) {
                  return "Password must at least 6 characters";
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if(state is AuthSuccess){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return HomeScreen();
                 },));
                  if(state is  AuthFailure){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failure")));
                  }
                }

              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: 
                  state is AuthLoading?null:() {
                    if (_formkey.currentState!.validate()) {
                      final email = emailcontroller.text.trim();
                      final password = passwordcontroller.text;
                      context.read<AuthCubit>().signUp(
                        email: email,
                        password: password,
                      );
                    }
                  },
                  child:state is AuthLoading?CircularProgressIndicator(): Text("Sign Up"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
