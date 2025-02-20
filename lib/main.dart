import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlowSync',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const AuthScreen(),
    );
  }
}

/// **Authentication Screen (Signup/Login)**
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to FlowSync",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              _buildTextField("Email", _emailController, Icons.email),
              _buildTextField(
                "Password",
                _passwordController,
                Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 20),

              /// **Login Button**
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectionScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Login / Sign Up",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              /// **Social Login Buttons**
              _buildSocialLoginButton(
                "Continue with Google",
                Icons.g_mobiledata,
              ),
              _buildSocialLoginButton("Use Phone Number (OTP)", Icons.phone),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable Text Field**
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool obscureText = false,
  }) {
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

  /// **Reusable Social Login Button**
  Widget _buildSocialLoginButton(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: OutlinedButton.icon(
        onPressed: () {}, // Implement Firebase Auth here
        icon: Icon(icon, color: Colors.red),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          minimumSize: const Size(double.infinity, 50),
          side: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}

/// **Selection Screen (Choose Donate or Receive)**
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "How do you want to proceed?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              _buildButton("I want to Donate", Colors.red, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BloodDonationDashboard(),
                  ),
                );
              }),
              _buildButton(
                "I need Blood/Breast Milk",
                Colors.pink.shade300,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestDashboard(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "By continuing, you agree to our Terms of Use & Privacy Policy.",
                style: TextStyle(fontSize: 12, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}

/// **Donation Dashboard**
class DonationDashboard extends StatelessWidget {
  const DonationDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Donation Dashboard')),
      body: const Center(child: Text("Welcome to the Donation Section")),
    );
  }
}

/// **Request Dashboard**
class RequestDashboard extends StatelessWidget {
  const RequestDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Dashboard')),
      body: const Center(child: Text("Welcome to the Request Section")),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),
      appBar: AppBar(title: const Text('Dashboard'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(
              "Blood Donation",
              "You can donate your blood here",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BloodDonationScreen(),
                  ),
                );
              },
            ),
            _buildListTile(
              "Breast Milk Donation",
              "You can donate your breast milk here",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BreastMilkDonationScreen(),
                  ),
                );
              },
            ),
            _buildListTile(
              "Find a Donor",
              "Search for nearby hospitals and donors",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FindDonorScreen(),
                  ),
                );
              },
            ),
            _buildListTile(
              "Track Donations",
              "See your donation history",
              () {},
            ),
            _buildListTile("Alerts", "Check urgent blood & milk needs", () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AlertsScreen()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.pink.shade300)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}

// Find a Donor Screen
class FindDonorScreen extends StatelessWidget {
  const FindDonorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),
      appBar: AppBar(title: const Text('Find a Donor')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Search for nearby donors"),
        ),
      ),
    );
  }
}

// Alerts Screen
class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCE8E8),
      appBar: AppBar(title: const Text('Alerts')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildAlertTile("Vandaloor", "Urgent Need"),
            _buildAlertTile("Chengalpattu", "Critical Need"),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertTile(String location, String urgency) {
    return Card(
      color: Colors.pink.shade100,
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.red),
        title: Text(
          location,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(urgency, style: TextStyle(color: Colors.red.shade700)),
      ),
    );
  }
}

class BloodDonationScreen extends StatefulWidget {
  const BloodDonationScreen({super.key});

  @override
  _BloodDonationScreenState createState() => _BloodDonationScreenState();
}

class _BloodDonationScreenState extends State<BloodDonationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bloodGroupController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEC),
      appBar: AppBar(title: const Text('Donate Blood')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Fill your details to donate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildTextField("Full Name", _nameController),
            _buildTextField("Blood Group", _bloodGroupController),
            _buildTextField("Contact Number", _contactController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Proceed to Donate",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Enrollment Successful 🎉"),
          content: const Text(
            "You have successfully enrolled yourself for blood donation. You will be notified when required.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearFields();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    setState(() {
      _nameController.clear();
      _bloodGroupController.clear();
      _contactController.clear();
    });
  }
}

class BreastMilkDonationScreen extends StatefulWidget {
  const BreastMilkDonationScreen({super.key});

  @override
  _BreastMilkDonationScreenState createState() =>
      _BreastMilkDonationScreenState();
}

class _BreastMilkDonationScreenState extends State<BreastMilkDonationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _babyAgeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDECEC), // Light pink background
      appBar: AppBar(title: const Text('Breast Milk Donation')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Fill your details to donate',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildTextField("Full Name", _nameController),
            _buildTextField("Contact Number", _contactController),
            _buildTextField("Baby’s Age (in months)", _babyAgeController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showConfirmationDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Proceed to Donate",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Enrollment Successful 🎉"),
          content: const Text(
            "You have successfully enrolled yourself for breast milk donation. You will be notified when required.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearFields();
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _clearFields() {
    setState(() {
      _nameController.clear();
      _contactController.clear();
      _babyAgeController.clear();
    });
  }
}

class BloodDonationDashboard extends StatelessWidget {
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
                onTap: () {},
              ),
              _buildListTile(
                title: "Blood Donation",
                subtitle: "You can donate your blood here",
                onTap: () {},
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade100,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text("Donate now"),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Track your donations & rewards",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildListTile(title: "My Donations", onTap: () {}),
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
