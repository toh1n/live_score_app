import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:live_score_app/score_screen.dart';

class MatchListScreen extends StatefulWidget {
  const MatchListScreen({super.key});

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Match List"),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('match').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final match = snapshot.data!;
              return ListView.builder(
                  itemCount: match.size,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 6),
                      child: SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => ScoreScreen(
                                        matchName: match.docs[index].id,
                                      )));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 2,
                            ),
                            child: ListTile(
                              title: Text(match.docs[index]['match_name']),
                              trailing: const Icon(Icons.arrow_forward),
                            )),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Unable to fetch data"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
