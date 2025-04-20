import 'package:flutter/material.dart';
import 'package:notes_app/widgets/drawer_home.dart';
import 'package:notes_app/widgets/home/floatingactionbutton_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> notes = [
    {"title": "Note One", "img": "assets/images/folder.png"},
    {"title": "Note Two", "img": "assets/images/folder.png"},
    {"title": "Note Three", "img": "assets/images/folder.png"},
    {"title": "Note Four", "img": "assets/images/folder.png"},
    {"title": "Note Five", "img": "assets/images/folder.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      drawer: const DrawerHome(),
      floatingActionButton: FloatingActionButtonWidget(onPressed: () {}),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 3 / 2,
          ),
          itemBuilder: (context, index) {
            final note = notes[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  // tıklama işlemi yapılabilir
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(note['img']!, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        note['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
