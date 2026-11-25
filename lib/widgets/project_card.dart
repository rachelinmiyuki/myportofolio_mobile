
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        
onTap: () async {
  if (item.name == "Tambah Proyek") {
    final loggedIn = await ensureLoggedIn(context);

    if (!context.mounted || !loggedIn) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectFormPage(),
      ),
    );
  } else if (item.name == "Tambah Pengalaman") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExperienceFormPage(),
      ),
    );
  } else if (item.name == "Logout") {
    await context.read<AuthState>().logout();

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil logout!"),
        backgroundColor: AppColors.oldCopper,
      ),
    );
  } else {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("Kamu telah menekan tombol ${item.name}!"),
          backgroundColor: AppColors.oldCopper,
        ),
      );
  }
},

        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: item.textColor, size: 26.0),
                const SizedBox(height: 2),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: item.textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
