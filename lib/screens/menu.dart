import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506536553";
  final String nama = "Rachelin Miyuki Hendratmo";
  final String kelas = "PBP F";

  final List<ItemHomepage> items = [
    ItemHomepage(
      "Lihat Proyek",
      Icons.folder,
      AppColors.oldCopper,
      Colors.white,
    ),
    ItemHomepage(
      "Tambah Proyek",
      Icons.add_circle,
      AppColors.butterYellow,
      AppColors.oldCopper,
    ),
    ItemHomepage(
      "Lihat Pengalaman",
      Icons.work,
      AppColors.oldCopper,
      Colors.white,
    ),
    ItemHomepage(
      "Tambah Pengalaman",
      Icons.add_circle,
      AppColors.butterYellow,
      AppColors.oldCopper,
    ),
    ItemHomepage("Logout", Icons.logout, AppColors.dustyPink, Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const LeftDrawer(),
      // Body halaman utama dengan padding di sekelilingnya.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),

              const SizedBox(height: 16.0),

              // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Selamat datang di MyPortfolio Mobile!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),

                    // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                    GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      childAspectRatio: 2.2,
                      // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                      shrinkWrap: true,
                      children: [
                        // Baris Proyek
                        ItemCard(items[0]),
                        ItemCard(items[1]),

                        // Baris Pengalaman
                        ItemCard(items[2]),
                        ItemCard(items[3]),

                        // Logout di tengah
                        Transform.translate(
                          offset: Offset(
                            MediaQuery.of(context).size.width / 4,
                            0,
                          ),
                          child: ItemCard(items[4]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  // Kartu informasi yang menampilkan judul (title) dan isi (content).
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Memberikan efek bayangan kartu elevasi 2 unit.
      color: AppColors.nebula,
      elevation: 2.0,
      child: Container(
        // Menyesuaikan lebar kartu dengan proporsi layar (dibagi 3.5).
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        // Menyusun teks title dan content secara vertikal.
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.oldCopper,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.oldCopper),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final Color textColor;

  ItemHomepage(this.name, this.icon, this.color, this.textColor);
}

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna sekunder dari skema tema aplikasi.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () {
          // Menampilkan SnackBar dengan pesan interaktif.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
                backgroundColor: AppColors.oldCopper,
              ),
            );

          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProjectFormPage()),
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
