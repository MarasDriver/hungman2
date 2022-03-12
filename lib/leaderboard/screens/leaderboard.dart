import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hangman2/auth/data/providers/auth_state.dart';
import 'package:hangman2/leaderboard/data/models/leaderboard_model.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatelessWidget {
  Leaderboard({Key? key}) : super(key: key);
  List<String> documentsID = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LeaderBoard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () =>
                Provider.of<AuthState>(context, listen: false).signOut(),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Leaderborard")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<LeaderBoardModel> _listOfResults =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return LeaderBoardModel.fromJson(data);
                  }).toList();

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: _listOfResults.length,
                      itemBuilder: (context, index) {
                        LeaderBoardModel _result = _listOfResults[index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(_result.user!),
                              Text(_result.score!.toString()),
                              Text(_result.time!.toString()),
                            ],
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }

//   Widget listItem(Cars car, docID, context) {
//     return Dismissible(
//       key: UniqueKey(),
//       onDismissed: (direction) {
//         if (direction == DismissDirection.startToEnd ||
//             direction == DismissDirection.endToStart)
//           FirebaseFirestore.instance.collection("Leaderboard").doc(docID).delete();
//       },
//       child: ListTile(
//         title: Text(car.brand!),
//         subtitle: Text(car.model!),
//         trailing: IconButton(
//           onPressed: () {
//             showDialog(
//                 context: context,
//                 builder: (_) => Dialog(
//                       child: CarModal(
//                         car: car,
//                         docID: docID,
//                       ),
//                     ));
//           },
//           icon: Icon(Icons.edit),
//         ),
//       ),
//     );
//   }
// }
}
