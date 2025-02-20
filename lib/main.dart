import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ssxvmwngixoxtkhflddc.supabase.co', // From Step 1
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNzeHZtd25naXhveHRraGZsZGRjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAwMjk5MjksImV4cCI6MjA1NTYwNTkyOX0.WJk1_qRaVts-gSVsiP4nX0qjCV6yN2kvworeDqK885E', // From Step 1
  );

  runApp(const FlowSyncApp());
}

final supabase = Supabase.instance.client;

class FlowSyncAnimation extends StatefulWidget {
  @override
  _FlowSyncAnimationState createState() => _FlowSyncAnimationState();
}

class _FlowSyncAnimationState extends State<FlowSyncAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _leftAnimation;
  late Animation<double> _rightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
    );

    _leftAnimation = Tween<double>(
      begin: 0,
      end: -40,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rightAnimation = Tween<double>(
      begin: 0,
      end: 40,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().then((_) => _controller.reverse());

    // Delay before navigating to AuthScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1D6D6), // Updated background color
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(_leftAnimation.value, 0),
                  child: Text(
                    "Fl",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBD8F8F), // Updated text color
                    ),
                  ),
                ),
                SizedBox(width: 0),
                Text(
                  "🩸", // Blood drop emoji
                  style: TextStyle(fontSize: 62),
                ),
                SizedBox(width: 0),
                Transform.translate(
                  offset: Offset(_rightAnimation.value, 0),
                  child: Text(
                    "wsync",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBD8F8F), // Updated text color
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  // Email validation
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  // Sign up method
  Future<void> signUp(String email, String password) async {
    if (!isValidEmail(email)) {
      print("Invalid email format");
      return;
    }

    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      print("Signup successful: ${response.user!.email}");
    } catch (error) {
      print("Signup error: $error");
    }
  }

  // Login method
  Future<void> login(String email, String password) async {
    if (!isValidEmail(email)) {
      print("Invalid email format");
      return;
    }

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print("Login successful: ${response.user!.email}");
    } catch (error) {
      print("Login error: $error");
    }
  }
}

Future<void> signUp(String email, String password) async {
  final supabase = Supabase.instance.client;
  try {
    await supabase.auth.signUp(email: email, password: password);
    print("User registered successfully!");
  } catch (e) {
    print("Signup error: $e");
  }
}

Future<void> login(String email, String password) async {
  final supabase = Supabase.instance.client;
  try {
    await supabase.auth.signInWithPassword(email: email, password: password);
    print("User logged in successfully!");
  } catch (e) {
    print("Login error: $e");
  }
}

class FlowSyncApp extends StatelessWidget {
  const FlowSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: AuthScreen());
  }
}

// LOGIN SCREEN
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true; // Toggle between login & signup
  bool _isLoading = false; // Show loading indicator

  void _authenticate() async {
    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields.");
      setState(() => _isLoading = false);
      return;
    }

    try {
      if (_isLogin) {
        await _authService.login(email, password);
      } else {
        await _authService.signUp(email, password);
      }

      // Navigate to the next screen after successful login/signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SelectRequirementScreen()),
      );
    } catch (error) {
      _showMessage(error.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1D6D6), // Set background color
      appBar: AppBar(title: Text(_isLogin ? "Login" : "Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isLogin
                  ? "Welcome Back!"
                  : "Welcome to Flowsync\nCreate an Account",
              textAlign: TextAlign.center, // Centers text horizontally
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color(
                  0xFFBD8F8F,
                ), // Change this to any color you want
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                filled: true, // Enables the background color
                fillColor: Colors.white, // Sets background to white
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                filled: true, // Enables the background color
                fillColor: Colors.white, // Sets background to white
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _authenticate,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    _isLogin ? "Login" : "Sign Up",
                    style: TextStyle(color: const Color(0xFFBD8F8F)),
                  ),
                ),
            TextButton(
              onPressed: () => setState(() => _isLogin = !_isLogin),
              child: Text(
                _isLogin
                    ? "Don't have an account? Sign Up"
                    : "Already have an account? Login",
                style: TextStyle(color: const Color(0xFFBD8F8F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SELECT REQUIREMENT SCREEN
class SelectRequirementScreen extends StatelessWidget {
  const SelectRequirementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2DADA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Select Requirements:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationDashboard(),
                    ),
                  );
                },

                child: const Text("I want to Donate "),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 50,
                  ),
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                child: const Text("I need Blood/Breast Milk"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonationDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCE8E8), // Light pink background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Donate now to those in need",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildListTile(
                title: "Breast Milk Donation",
                subtitle: "You can donate your breast milk here",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BreastMilkDonationScreen(),
                    ),
                  );
                },
              ),
              _buildListTile(
                title: "Blood Donation",
                subtitle: "You can donate your blood here",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BloodDonationScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 24),
              Text(
                "Track your donations & rewards",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildListTile(
                title: "My Donations",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDonationsScreen(),
                    ),
                  );
                },
              ),
              _buildListTile(title: "My Rewards", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
          subtitle != null
              ? Text(subtitle, style: TextStyle(color: Colors.pink.shade300))
              : null,
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: onTap,
    );
  }
}

class BloodDonationScreen extends StatefulWidget {
  const BloodDonationScreen({super.key});

  @override
  _BloodDonationScreenState createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void _submitForm() {
    if (nameController.text.isEmpty ||
        bloodGroupController.text.isEmpty ||
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all details!")),
      );
      return;
    }

    // Show popup confirmation
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Enrolled Successfully!"),
            content: const Text("You are enrolled to donate blood."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );

    // Clear input fields
    nameController.clear();
    bloodGroupController.clear();
    locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donation"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donate Blood",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Fill in the details below to schedule your blood donation.",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bloodGroupController,
              decoration: const InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text("Submit"),
              ),
            ),
            const SizedBox(height: 10),

            // "View Map" Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OSMMapScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text("View Map"),
              ),
            ),

            const SizedBox(height: 10),

            // Navigate to Book Donation Screen
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDonationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text("Go to Book Donation"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreastMilkDonationScreen extends StatefulWidget {
  const BreastMilkDonationScreen({super.key});

  @override
  _BreastMilkDonationScreenState createState() =>
      _BreastMilkDonationScreenState();
}

class _BreastMilkDonationScreenState extends State<BreastMilkDonationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void _submitForm() {
    if (nameController.text.isEmpty ||
        bloodGroupController.text.isEmpty ||
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all details!")),
      );
      return;
    }

    // Show popup confirmation
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Enrolled Successfully!"),
            content: const Text("You are enrolled to donate breast milk."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              ),
            ],
          ),
    );

    // Clear input fields
    nameController.clear();
    bloodGroupController.clear();
    locationController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Breast Milk Donation"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Donate Breast Milk",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Fill in the details below to schedule your breast milk donation.",
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Full Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: bloodGroupController,
              decoration: const InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Baby's Age",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.red),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 15),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // Function to show the notification pop-up
  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("Notification Enabled"),
          content: const Text("You will be notified whenever we find a match."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Function to show the SOS alert pop-up
  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text("SOS Alert Sent"),
          content: const Text(
            "Your emergency request has been received. You will be notified via SMS shortly.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8D1D1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2DADA),
        title: const Text("Dashboard", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search for a donor or hospital by name",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Find a Donor",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text("Search for nearby hospitals and donors"),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookDonationScreen()),
                );
              },
              child: const Text("Start Search"),
            ),
            const SizedBox(height: 20),

            // Get Notified Section with Pop-up Alert
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.black54),
              title: const Text(
                "Get Notified",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("We’ll notify you when we find a match"),
              onTap: () => _showNotificationDialog(context), // Trigger popup
            ),

            ListTile(
              leading: const Icon(Icons.warning, color: Colors.black54),
              title: const Text(
                "SOS Alerts",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("In case of emergency, send an SOS request"),
              onTap: () => _showSOSDialog(context), // Trigger SOS popup
            ),
          ],
        ),
      ),
    );
  }
}

class BookDonationScreen extends StatelessWidget {
  const BookDonationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2DDDD), // Light pink background
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              // Title
              const Center(
                child: Text(
                  "Book a donation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Search Bar
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search for your hospital",
                  filled: true,
                  fillColor: const Color(0xFFF8E5E5), // Light pink
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Map Placeholder
              SizedBox(
                height: 200, // Adjust height as needed
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(
                      12.7954927,
                      80.2157292,
                    ), // Bangalore, India
                    initialZoom: 13,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 40.0,
                          height: 40.0,
                          point: LatLng(12.7954927, 80.2157292),
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Hospital List
              _buildHospitalItem(
                name: "Chettinad Hospital",
                address: "SH 49A, Kelambakkam, Tamil Nadu 603103",
              ),
              _buildHospitalItem(
                name: "Sri Meenakshi Hospital",
                address: "Rice Mill Street, Kandigai, Chennai 600127",
              ),

              const SizedBox(height: 20),

              // Remind Me to Donate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Reminder set for donation!"),
                      ),
                    );
                  },
                  child: const Text(
                    "Remind me to donate",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying a hospital item
  Widget _buildHospitalItem({required String name, required String address}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(address, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF2DDDD),
              foregroundColor: Colors.black,
            ),
            onPressed: () {},
            child: const Text("Select"),
          ),
        ],
      ),
    );
  }
}

class MyDonationsScreen extends StatelessWidget {
  const MyDonationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample donation data
    final List<Map<String, String>> donations = [
      {
        "type": "Blood Donation",
        "hospital": "Chettinad Hospital",
        "date": "Feb 15, 2025",
      },
      {
        "type": "Breast Milk Donation",
        "hospital": "Sri Meenakshi Hospital",
        "date": "Feb 10, 2025",
      },
      {
        "type": "Blood Donation",
        "hospital": "Apollo Hospital",
        "date": "Jan 25, 2025",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF2DDDD), // Light pink background
      appBar: AppBar(
        title: const Text("My Donations"),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.separated(
            itemCount: donations.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final donation = donations[index];
              return ListTile(
                title: Text(
                  donation["type"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "${donation["hospital"]!}\n${donation["date"]!}",
                  style: const TextStyle(color: Colors.grey),
                ),
                isThreeLine: true,
                leading: Icon(
                  donation["type"] == "Blood Donation"
                      ? Icons.bloodtype
                      : Icons.child_care,
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class OSMMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OpenStreetMap"),
        backgroundColor: Colors.red,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(12.7954927, 80.2157292), // Bangalore, India
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 40.0,
                height: 40.0,
                point: LatLng(12.7954927, 80.2157292), // Example Location
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
