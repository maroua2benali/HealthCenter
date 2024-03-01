import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:healthcenter/Component/signup.dart';
import 'package:healthcenter/Component/forgotpassword.dart'; // Import the ForgotPasswordPage
import 'package:healthcenter/Component/onboarding/onboarding_view.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Authentication successful, proceed with your logic here
        print('Google Sign-In successful: ${googleUser.displayName}');
      } else {
        // User canceled the sign-in process
        print('Google Sign-In canceled by user.');
      }
    } catch (error) {
      // Handle sign-in errors
      print('Google Sign-In error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Make the title bold
          ),
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the onboarding page with a fade transition
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) => OnboardingView(),
                transitionsBuilder: (_, animation, __, child) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248), // Field color
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.email), // Email icon
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Enter your email', // Change labelText to hintText
                        hintStyle: TextStyle(
                            color: Colors.grey), // Light grey text color
                        border: InputBorder.none, // Remove TextField border
                        contentPadding: EdgeInsets.all(20.0), // Add padding
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 248, 248, 248), // Field color
                borderRadius: BorderRadius.circular(40.0),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.lock), // Password icon
                  ),
                  Expanded(
                    child: TextField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText:
                            'Enter your password', // Change labelText to hintText
                        hintStyle: TextStyle(
                            color: Colors.grey), // Light grey text color
                        border: InputBorder.none, // Remove TextField border
                        contentPadding: EdgeInsets.all(20.0), // Add padding
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {
                // Navigate to Forgot Password page with smooth transition
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => ForgotPasswordPage(),
                    transitionsBuilder: (_, animation, __, child) =>
                        FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.centerRight, // Align right
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    color: Color(0xFF8a86e2), // Link color
                    decoration: TextDecoration.none, // Remove underline
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Handle login button pressed
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF8a86e2), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(40.0), // Button border radius
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20.0, // Increase text size
                    color: Colors.white, // Link color
                    decoration: TextDecoration.none, // Remove underline
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
              onPressed: _handleGoogleSignIn,
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
                    'Sign in with Google',
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
            Text("Don't have an account?"),
            SizedBox(width: 5.0),
            GestureDetector(
              onTap: () {
                // Use a fade transition when navigating to the sign-up page
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => SignUpPage(),
                    transitionsBuilder: (_, animation, __, child) =>
                        FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              },
              child: Text(
                'Sign up',
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
