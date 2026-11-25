
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({
    super.key,
    required this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Proyek'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),

            Text(
              'Kategori: ${project.categoryDisplay}',
            ),
            const SizedBox(height: 12),

            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(project.description),

            if (project.technologies != null &&
                project.technologies!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Teknologi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(project.technologies!),
            ],

            if (project.projectLink != null &&
                project.projectLink!.isNotEmpty) ...[
              const SizedBox(height: 12),
              const Text(
                'Tautan Proyek',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SelectableText(project.projectLink!),
            ],
          ],
        ),
      ),
    );
  }
}
