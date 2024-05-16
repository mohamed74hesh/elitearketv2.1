import 'package:elitemarketv2/common/widgets/custom_button.dart';
import 'package:elitemarketv2/common/widgets/custom_textfield.dart';
import 'package:elitemarketv2/constants/global_variables.dart';
import 'package:elitemarketv2/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String type = 'user';
  bool _isPasswordVisible = false;
  BuildContext? _context;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _context = context;
  }

   @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }
  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      type: type,
    );
  }

  List<String> usertype = ['user', 'admin'];

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
    
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Elite Mart',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      tileColor: _auth == Auth.signup
                          ? GlobalVariables.backgroundColor
                          : Color.fromRGBO(230, 46, 4, 0.1),
                      title: const Text(
                        'Create Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color.fromRGBO(230, 46, 4, 1),
                        value: Auth.signup,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      tileColor: _auth == Auth.signin
                          ? GlobalVariables.backgroundColor
                          : GlobalVariables.greyBackgroundCOlor,
                      title: const Text(
                        'Sign-In.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Radio(
                        activeColor: Color.fromRGBO(230, 46, 4, 1),
                        value: Auth.signin,
                        groupValue: _auth,
                        onChanged: (Auth? val) {
                          setState(() {
                            _auth = val!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: GlobalVariables.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Retype Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: DropdownButton(
                            value: type,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: usertype.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Center(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      color: Colors.orange,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newVal) {
                              setState(() {
                                type = newVal!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          },
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ),
                ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: GlobalVariables.backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          text: 'Sign In',
                          onTap: () {
                            if (_signInFormKey.currentState!.validate()) {
                              signInUser();
                            }
                          },
                          color: Colors.orange,
                        )
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
