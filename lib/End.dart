import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'Score.dart';
import 'package:http/http.dart' as http;

class EndPage extends StatefulWidget { // ui updates when the user clicks the boxes
  const EndPage({super.key});

  @override
  State<EndPage> createState() => EndPageState();
}

class EndPageState extends State<EndPage> {
  Widget buildBox(BuildContext context, int distance, int points, String label) { // you need context any time you need to read score inside a function,
    // buildbox is a template that creates the box using the info you give it, so then you don't have to repeat it a bunch of times
    final score = context.watch<Score>();
    final isSelected = score.selectedEndDistance == distance; // checks if this box is the one the user picked

    return InkWell(
      onTap: () {
        context.read<Score>().selectEndDistance(distance, points); // stores the box the user picks and updates the points based on it
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          color: Colors.black,
        ),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow, width: 2),
                color: isSelected ? Colors.pinkAccent : Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendToDiscord(String message) async { // bc sending a message to a server takes time it's async, it return nothing, and sends a string message to discord
    final webhookUrl = 'https://discord.com/api/webhooks/1441601173269250048/yivQoOn-HcvSySOcBrX_2AwN-hj2-y-AUUDvamkkS0voAlkiXW1npF0Fg3RW5PoeFnVf';

    await http.post( // sends an http post request
      Uri.parse(webhookUrl), // turns the webhook url string into a real uri object that the http library can use
      headers: {'Content-Type': 'application/x-www-form-urlencoded'}, // its telling it that its sending normal form data which is the format discord expects
      body: {'content': message}, // actual message being sent, it reads the content as the text to display
    );
  }

  Future<bool> confirmSubmit(BuildContext context) async { // if the user confirmed true, else false
    return await showDialog<bool>( // displays the dialog box, pauses the function until the user taps a button, returns a bool
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Submit Match?',
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to submit this match?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final score = context.watch<Score>(); // watches the score and stores the entire score object, not just the total score, all of the values
    final currentRoute = GoRouterState.of(context).uri.toString();
    final isTele = currentRoute == '/tele'; // checks if you're on the tele page if it then its true otherwise its false
    final isEnd = currentRoute == '/end'; // same thing but for the end page and both of them are for the bottom nav bar


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DropdownButton<String>( // dropdown menu that holds string
              value: context.watch<Score>().selectedTeam, // reads the selected team value from the score object and also updates based on what the user picks
              hint: const Text(
                'Select Team',
                style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              dropdownColor: Colors.black,
              items: [
                'Papa John\'s',
                'Little Caesars',
                'Pizza Hut',
                'Farrelli\'s',
                'MOD',
              ].map((teamName) { // map turns each string into widget
                return DropdownMenuItem<String>(
                  value: teamName,
                  child: Text(
                    teamName,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(), // dropdown needs a list so this converts it all into a proper list
              onChanged: (teamName) {
                context.read<Score>().setTeam(teamName!); // grabs the shared score object and calls the score function setTeam() to store the selected team, doesn't rebuild ui bc its read not watch
              },
            ),
            Text(
              'Total Score: ${context.watch<Score>().totalScore} pts',
              style: const TextStyle(
                color: Colors.yellow,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildBox(context, 0, 0, '0 Feet (0 pts)'),
            buildBox(context, 5, 10, '5 Feet (10 pts)'),
            buildBox(context, 10, 25, '10 Feet (25 pts)'),
            buildBox(context, 15, 40, '15 Feet (40 pts)'),
            buildBox(context, 20, 50, '20+ Feet (50 pts)'),
            const SizedBox(height: 70),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              onPressed: () async {

                // makes sure a team is selected
                if (context.read<Score>().selectedTeam == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a team before submitting.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                if (context.read<Score>().selectedEndDistance == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select a distance before submitting.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                final confirmed = await confirmSubmit(context); // shows the confirmation dialog and waits for the user to pick an options

                if (!confirmed) return; // if the user doesn't confirm then stop the function immediately and don't do anythign else, exits the popup
                // if the user does confirm it skips the if and runs the rest of the submit code

                final export = context.read<Score>().exportData();

                final msg = // \n means new line
                    'Match Submitted\n'
                    'Team: ${export['team']}\n'
                    'Total Score: ${export['totalScore']}\n'
                    'Penalties: ${export['penalties']}\n'
                    'Distance Driven: ${export['endDistance']} ft\n'
                    'Assembly Tray: ${export['assembly']}\n'
                    'Oven Column: ${export['oven']}\n'
                    'Delivery Hatch: ${export['hatch']}';

                await sendToDiscord(msg);

                context.read<Score>().resetAll();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Match submitted successfully'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },

              child: const Text(
                'SUBMIT MATCH',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 60,
        color: Colors.pinkAccent,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => context.go('/tele'),
                child: Container(
                  color: isTele ? Colors.pinkAccent : Colors.yellow,
                  alignment: Alignment.center,
                  child: const Text(
                    'TELE',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => context.go('/end'),
                child: Container(
                  color: isEnd ? Colors.pinkAccent : Colors.yellow,
                  alignment: Alignment.center,
                  child: const Text(
                    'END',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



