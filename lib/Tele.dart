import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'Score.dart';

// it's stateless bc it doesn't manage its own state it just displays what the score objects tells it to
class TelePage extends StatelessWidget {
  const TelePage({super.key});

  @override
  Widget build(BuildContext context) {
    final totalScore = context.watch<Score>().totalScore; // this asks provider for the score object and it grabs the current value of the total score and rebuilds the tele page bc of watch
    final currentRoute = GoRouterState.of(context).uri.toString(); // checks which page we're on
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

      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.red,
                  height: 40,
                  child: const Center(
                      child: Text(
                        'Assembly Tray',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  height: 40,
                  child: const Center(
                      child: Text(
                        'Oven Column',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                  height: 40,
                  child: const Center(
                      child: Text(
                        'Delivery Hatch',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell( // makes any widget tappable
                  onTap: () {
                    context.read<Score>().addAssembly();
                  },
                  child: Container(
                    height: 154,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().subtractPoints(3);
                  },
                  child: Container(
                    height: 154,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().addOven();
                  },
                  child: Container(
                    height: 154,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().subtractPoints(5);
                  },
                  child: Container(
                    height: 154,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().addHatch();
                  },
                  child: Container(
                    height: 154,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().subtractPoints(8);
                  },
                  child: Container(
                    height: 154,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.purple,
                  height: 40,
                  child: const Center(
                      child: Text(
                        'Combo Bonus',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.orangeAccent,
                  height: 40,
                  child: const Center(
                      child: Text(
                        'Oven Override',
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().addPoints(20);
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().subtractPoints(20);
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().addPoints(100);
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    context.read<Score>().subtractPoints(100);
                  },
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '-',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.pinkAccent,
                  height: 60,
                  child: const Center(
                      child: Text(
                        'Penalties',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                            fontSize: 30
                        ),
                      )
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<Score>().addPenalty(20);
                      },
                      child: Container(
                        height: 124.85,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Motor Burnout',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        child: const Icon(
                            Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          context.read<Score>().addPoints(20);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<Score>().addPenalty(5);
                      },
                      child: Container(
                        height: 124.85,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Elevator Malfunction',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        child: const Icon(
                            Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          context.read<Score>().addPoints(5);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<Score>().addPenalty(5);
                      },
                      child: Container(
                        height: 124.85,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Mechanism Detach',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        child: const Icon(
                            Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          context.read<Score>().addPoints(5);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<Score>().addPenalty(30);
                      },
                      child: Container(
                        height: 124,
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Human Interference',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        child: const Icon(
                            Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          context.read<Score>().addPoints(30);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        context.read<Score>().addPenalty(30);
                      },
                      child: Container(
                        height: 124,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Out-of-bounds Robot',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: FloatingActionButton.small(
                        backgroundColor: Colors.black,
                        child: const Icon(
                            Icons.add,
                          color: Colors.pinkAccent,
                        ),
                        onPressed: () {
                          context.read<Score>().addPoints(30);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: Container(
        height: 50,
        color: Colors.pinkAccent,
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => context.go('/tele'),
                child: Container(
                  color: isTele ? Colors.pinkAccent : Colors.yellow,
                  alignment: Alignment.center,
                  child: const Center(
                      child: Text(
                    'TELE',
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  )
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => context.go('/end'),
                child: Container(
                  color: isEnd? Colors.pinkAccent : Colors.yellow,
                  alignment: Alignment.center,
                  child: const Center(
                      child: Text(
                    'END',
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  )
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
