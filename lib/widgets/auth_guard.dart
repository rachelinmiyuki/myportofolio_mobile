
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

Future<bool> ensureLoggedIn(BuildContext context) async {
  // Jika sudah login, langsung izinkan.
  if (context.read<AuthState>().isLoggedIn) {
    return true;
  }

  // Jika belum login, arahkan ke LoginScreen.
  final loggedIn = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );

  return loggedIn ?? false;
}
