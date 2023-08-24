import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final String matchName;
  const ScoreScreen({super.key, required this.matchName});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('match').doc(matchName).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final score = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                title: Text("${score['team_a']} vs ${score['team_b']}"),
              ),
              body: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "${score['team_a']} vs ${score['team_b']}",
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 35
                            ),
                          ),
                          Text(
                              "${score['team_a_score']} : ${score['team_b_score']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35
                              )
                          ),
                          Text(
                              "Time : ${score['match_start_time']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22
                              )
                          ),
                          Text(
                              "Total Time : ${score['total_match_time']}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          else if(snapshot.hasError){
            return const Scaffold(body: Center(child: Text("Unable to fetch data"),));
          }
          else{
            return const Scaffold(body: Center(child: CircularProgressIndicator(),));
          }

        }
    );
  }
}
