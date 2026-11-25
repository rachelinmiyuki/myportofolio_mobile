
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/screens/project_detail.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Future<List<Project>> futureProjects;

  @override
  void initState() {
    super.initState();
    futureProjects = ApiClient.getProjects();
  }

  Future<void> refreshProjects() async {
    setState(() {
      futureProjects = ApiClient.getProjects();
    });

    await futureProjects;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
      ),
      body: RefreshIndicator(
        onRefresh: refreshProjects,
        child: FutureBuilder<List<Project>>(
          future: futureProjects,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Terjadi error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Belum ada proyek.'),
              );
            }

            final projects = snapshot.data!;

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProjectDetailScreen(
                            project: project,
                          ),
                        ),
                      );
                    },
                    title: Text(project.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(project.description),
                        const SizedBox(height: 4),
                        Text(project.categoryDisplay),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
