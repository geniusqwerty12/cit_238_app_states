//https://medium.com/@sharansukesh2000/understanding-flutter-app-lifecycle-a-step-by-step-guide-89676251ac84

import 'package:cit_238_app_states/screens/AnotherScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppLifeCycleDisplay extends StatefulWidget {
  const AppLifeCycleDisplay({super.key});

  @override
  State<AppLifeCycleDisplay> createState() => _AppLifeCycleDisplayState();
}

class _AppLifeCycleDisplayState extends State<AppLifeCycleDisplay> {
  late final AppLifecycleListener _listener;
  final ScrollController _scrollController = ScrollController();
  final List<String> _states = <String>[];

  late AppLifecycleState? _state;

  // similar to onStart on Android
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onShow: () => _handleTransition('show'),
      onResume: () => _handleTransition('resume'),
      onHide: () => _handleTransition('hide'),
      onInactive: () => _handleTransition('inactive'),
      onPause: () => _handleTransition('pause'),
      onDetach: () => _handleTransition('detach'),
      onRestart: () => _handleTransition('restart'),
      onStateChange: (value) => _handleStateChange(value),
    );

    if (_state != null) {
      _states.add(_state!.name);
    }
  }

  // onDestroy()
  @override
  void dispose() {
    _listener.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // Function to handle the transitions between states
  void _handleTransition(String name) {
    setState(() {
      _states.add(name);
    });

    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
  }

  void _handleStateChange(AppLifecycleState state) {
    setState(() {
      _state = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("App LifeCycle State"),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Text('Current State: ${_state ?? 'Not initialzied yet'}'),
                const SizedBox(
                  height: 30,
                ),
                Text('State History: \n ${_states.join('\n ')}'),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AnotherScreen()));
                    },
                    icon: Icon(Icons.skip_next))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
