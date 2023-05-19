import 'package:app_ciudadana/src/home_page.dart';
import 'package:app_ciudadana/src/pages/registro/registro_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginScreen extends StatefulWidget {
  final String userID;
  const LoginScreen({Key? key, required this.userID}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _savedEmail;
  String? _savedPassword;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedEmail = prefs.getString('email');
      _savedPassword = prefs.getString('password');
    });
  }

  Future<void> _saveCredentials(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  Future<void> _clearCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ingresa un correo y una contraseña válidos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      // Verificar que el usuario existe en Firestore
      final snapshot = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user!.uid)
          .get();

      if (!snapshot.exists) {
        throw Exception('El usuario no está registrado');
      }

      await _saveCredentials(email, password);

      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } catch (error) {
      setState(() {
        // _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifica el correo o la contraseña'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Inicio de sesión'),
      // ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffa1c1be), Color(0xff9ec4bb), Color(0xffeed7c5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(child: Container()),
              Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  height: 250,
                  // width: 100,
                ),
              ),
              if (_savedEmail != null && _savedPassword != null)
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Ingresar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Correo electrónico',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              // TextField(
              //   controller: _emailController,
              //   decoration: const InputDecoration(
              //     labelText: 'Correo electrónico',
              //   ),
              // ),
              const SizedBox(height: 20),
              // TextField(
              //   controller: _passwordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(
              //     labelText: 'Contraseña',
              //   ),
              // ),

              TextFormField(
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? CircularProgressIndicator()
                    : Text('Iniciar sesión'),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff59554e),
                ),
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _isLoading ? null : _loginWithGoogle,
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/google.png',
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
                label: const Text('Continuar con Google      '),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff59554e),
                ),
              ),

              // Indicador de carga
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _loginWithFacebook,
                icon: Column(
                  children: [
                    Image.asset(
                      'assets/facebook.png',
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
                label: const Text('Continuar con Facebook'),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff59554e),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No tienes una cuenta?'),
                  TextButton(
                    onPressed: () {
                      // Add registration functionality here
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => RegistrationScreen()),
                      );
                    },
                    child: Text(
                      'Registrate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff59554e),
                      ),
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

  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = userCredential.user;

        // Verificar que el usuario existe en Firestore
        final snapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user!.uid)
            .get();

        if (!snapshot.exists) {
          // Si el usuario no existe, lo agregamos a Firestore
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(user.uid)
              .set({
            'nombre': user.displayName ?? '',
            'correo': user.email ?? '',
            'foto': user.photoURL ?? '',
          });
        }

        await _saveCredentials(googleUser.email, '');

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ocurrió un error al iniciar sesión con Google.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocurrió un error al iniciar sesión con Google.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loginWithFacebook() async {
    // Mostrar un indicador de carga mientras se inicia sesión
    setState(() {
      _isLoading = true;
    });

    try {
      // Iniciar sesión con Facebook y obtener las credenciales
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Crear las credenciales para Firebase
        final AccessToken accessToken = result.accessToken!;
        final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.token,
        );

        // Iniciar sesión en Firebase con las credenciales de Facebook
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final user = userCredential.user;

        // Verificar que el usuario existe en Firestore
        final snapshot = await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user!.uid)
            .get();

        if (!snapshot.exists) {
          // Si el usuario no existe, lo agregamos a Firestore
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(user.uid)
              .set({
            'nombre': user.displayName ?? '',
            'correo': user.email ?? '',
            'foto': user.photoURL ?? '',
          });
        }

        await _saveCredentials(user.email ?? '', '');

        // Ocultar el indicador de carga y navegar a la pantalla principal
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      } else {
        // Si el inicio de sesión falla, mostrar un mensaje de error
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocurrió un error al iniciar sesión con Facebook.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      // Si ocurre un error, mostrar un mensaje de error
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ocurrió un error al iniciar sesión con Facebook.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
