import 'package:flutter/material.dart';

class DetailExampleListTile extends StatelessWidget {
  const DetailExampleListTile({
    super.key,
    required this.title,
    required this.page,
  });

  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<Widget>(
          builder: (_) => page,
        ),
      ),
    );
  }
}
