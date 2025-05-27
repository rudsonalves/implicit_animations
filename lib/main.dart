import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/animatedList': (context) => const AnimatedList(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMoved = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animações Implícitas')),
      body: Stack(
        children: [
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/animatedList');
              },
              child: const Text('Clique Aqui!'),
            ),
          ),
          SafeArea(
            child: AnimatedAlign(
              alignment: isMoved ? Alignment.bottomRight : Alignment.topCenter,
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                onTap: () => setState(() => isMoved = !isMoved),
                child: AnimatedContainer(
                  margin: const EdgeInsets.all(12),
                  width: isMoved ? 60 : 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(isMoved ? 30 : 0),
                  ),
                  alignment: isMoved
                      ? Alignment.topCenter
                      : Alignment.bottomRight,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOutCirc,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedList extends StatefulWidget {
  const AnimatedList({super.key});

  @override
  State<AnimatedList> createState() => _AnimatedListState();
}

class _AnimatedListState extends State<AnimatedList> {
  bool openList = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animações Implícitas')),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) => AnimatedListTile(index: index),
      ),
    );
  }
}

class AnimatedListTile extends StatefulWidget {
  final int index;

  const AnimatedListTile({super.key, required this.index});

  @override
  State<AnimatedListTile> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          firstChild: const Divider(),
          secondChild: _fixedWidth(const SizedBox.shrink()),
          crossFadeState: isOpen
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
        ),
        ListTile(
          title: Text('Item ${widget.index}'),
          subtitle: const Text('Trailing expansion arrow icon'),
          trailing: IconButton(
            onPressed: () {
              setState(() => isOpen = !isOpen);
            },
            icon: AnimatedRotation(
              turns: isOpen ? 0 : 0.5,
              duration: const Duration(milliseconds: 500),
              child: const Icon(Icons.expand_more),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: Column(
            children: [
              const FlutterLogo(size: 50),
              Text(
                '${widget.index} - Stay up to date > What\'s new in the docs'
                'This page contains current and recent announcements of '
                'what\'s new on the Flutter website and blog. Find past '
                'what\'s new information on the what\'s new archive page. You '
                'might also check out the Flutter SDK release notes.',
              ),
            ],
          ),
          secondChild: _fixedWidth(const SizedBox.shrink()),
          crossFadeState: isOpen
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
        ),
        AnimatedCrossFade(
          firstChild: const Divider(),
          secondChild: _fixedWidth(const SizedBox.shrink()),
          crossFadeState: isOpen
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 500),
        ),
      ],
    );
  }

  Widget _fixedWidth(Widget child) => LayoutBuilder(
    builder: (context, constraints) => SizedBox(
      width: constraints.maxWidth,
      child: child,
    ),
  );
}
