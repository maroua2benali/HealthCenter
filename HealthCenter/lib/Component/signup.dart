import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  bool _agreeToTerms = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  bool _isEmailValid(String email) {
    // Regular expression for email validation
    String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailPattern);
    return regExp.hasMatch(email);
  }

  Future<void> _handleGoogleSignUp() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Google sign-up successful, proceed with your logic here
        print('Google Sign-Up successful: ${googleUser.displayName}');
      } else {
        // User canceled the sign-up process
        print('Google Sign-Up canceled by user.');
      }
    } catch (error) {
      // Handle sign-up errors
      print('Google Sign-Up error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(
                hintText: 'Full Name',
                prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Color.fromARGB(255, 248, 248, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Color.fromARGB(255, 248, 248, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 248, 248, 248),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  value: _agreeToTerms,
                  onChanged: (value) {
                    setState(() {
                      _agreeToTerms = value!;
                    });
                  },
                ),
                Flexible(
                  // Wrap the text widget with Flexible
                  child: Text(
                    'I agree to the Terms of Service and Privacy Policy',
                    overflow: TextOverflow.clip,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _agreeToTerms
                  ? () {
                      // Validate email
                      if (!_isEmailValid(_emailController.text)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Invalid Email'),
                              content:
                                  Text('Please enter a valid email address.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Proceed with sign-up
                        // Add your sign-up logic here
                      }
                    }
                  : null, // Disable the button if _agreeToTerms is false
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8a86e2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: _agreeToTerms
                        ? Color(0xFFffe0f4)
                        : Color.fromARGB(255, 165, 165, 165),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _handleGoogleSignUp,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 248, 248, 248), // Background color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(40.0), // Button border radius
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 20.0), // Adjust padding
                elevation: 0, // Remove elevation
                shadowColor: Colors.transparent, // Remove shadow
                minimumSize: Size(double.infinity,
                    56), // Match the width and height of the login button
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/google.png', // Path to your icon image
                    width: 24, // Adjust the width as needed
                    height: 24, // Adjust the height as needed
                  ),
                  SizedBox(width: 10), // Add spacing between the icon and text
                  Spacer(), // Add spacer to push text to the center
                  Text(
                    'Sign up with Google',
                    style: TextStyle(
                      fontSize: 15.0, // Font size
                      fontWeight: FontWeight.bold, // Bold font weight
                      color: Colors.black, // Text color
                    ),
                  ),
                  Spacer(), // Add spacer to push text to the center
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?"),
            SizedBox(width: 5.0),
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Navigate back to login page
              },
              child: Text(
                'Login',
                style: TextStyle(
                  color: Color(0xFF8a86e2), // Link color
                  decoration: TextDecoration.none, // Remove underline
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}
