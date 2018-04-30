import 'package:flutter/material.dart';
import 'game_button.dart';
import 'package:flutter/rendering.dart';
import 'custom_dialouge.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
 @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
{
  List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit()
  {
    player1 = new List();
    player2 = new List();
    activePlayer=1;
    var gameButtons = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
  new GameButton(id: 3),
  new GameButton(id: 4),
  new GameButton(id: 5),
  new GameButton(id: 6),
  new GameButton(id: 7),
  new GameButton(id: 8),
  new GameButton(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameButton gb){
    setState((){
      if(activePlayer==1)
        {
          gb.text="X";

          gb.bg=Colors.red;
          activePlayer=2;
          player1.add(gb.id);
        }
        else {
        gb.text="O";
        gb.bg=Colors.black;
        activePlayer=1;
        player2.add(gb.id);
        }
        gb.enabled=false;
        int winner=checkWinner();
        if(winner==-1)
          {
            if(buttonsList.every((p)=>p.text!="")){
              showDialog(context: context, child: new CustomDialouge("Game tied", "Press the reset button to restart",resetGame));
            }
            else{
              activePlayer == 2 ?autoPlay():null;
            }
          }
    });
  }

  void autoPlay()
  {
    var emptyCells = new List();
    var list = new List.generate(9, (i)=>i+1);
    for(var cellID in list)
      {
        if(!(player1.contains(cellID) || player2.contains(cellID)))
          {
            emptyCells.add(cellID);
          }
      }

      var r = new Random();
      var randIndex = r.nextInt(emptyCells.length-1);
      var cellId = emptyCells[randIndex];
      int i =buttonsList.indexWhere((p)=>p.id == cellId);
      playGame(buttonsList[i]);
  }

  int checkWinner(){
    var winner=-1;
    if(player1.contains(1) && player1.contains(2) && player1.contains(3))
      {
        winner=1;
      }
    else if(player1.contains(4) && player1.contains(5) && player1.contains(6))
    {
      winner=1;
    }
    else if(player1.contains(7) && player1.contains(8) && player1.contains(9))
    {
      winner=1;
    }
    else if(player1.contains(1) && player1.contains(4) && player1.contains(7))
    {
      winner=1;
    }
    else if(player1.contains(2) && player1.contains(5) && player1.contains(8))
    {
      winner=1;
    }
    else if(player1.contains(3) && player1.contains(6) && player1.contains(9))
    {
      winner=1;
    }
    else if(player1.contains(1) && player1.contains(5) && player1.contains(9))
    {
      winner=1;
    }
    else if(player1.contains(3) && player1.contains(5) && player1.contains(7))
    {
      winner=1;
    }


    if(player2.contains(1) && player2.contains(2) && player2.contains(3))
    {
      winner=2;
    }
    else if(player2.contains(4) && player2.contains(5) && player2.contains(6))
    {
      winner=2;
    }
    else if(player2.contains(7) && player2.contains(8) && player2.contains(9))
    {
      winner=2;
    }
    else if(player2.contains(1) && player2.contains(4) && player2.contains(7))
    {
      winner=2;
    }
    else if(player2.contains(2) && player2.contains(5) && player2.contains(8))
    {
      winner=2;
    }
    else if(player2.contains(3) && player2.contains(6) && player2.contains(9))
    {
      winner=2;
    }
    else if(player2.contains(1) && player2.contains(5) && player2.contains(9))
    {
      winner=2;
    }
    else if(player2.contains(3) && player2.contains(5) && player2.contains(7))
    {
      winner=2;
    }

    if(winner!=-1) {
      if (winner == 1) {
        showDialog(context: context,
          child: new CustomDialouge("Player 1 Won","Press the reset button to restart", resetGame),
        );
      }
    else{
        showDialog(context: context,
          child: new CustomDialouge("Player 2 Won","Press the reset button to restart", resetGame),
        );
      }
      }
      return winner;

  }

  void resetGame(){
    if(Navigator.canPop(context))
      Navigator.pop(context);
    setState((){
      buttonsList=doInit();
    });
  }
  
  @override
  Widget build(BuildContext context)
  {
    return new Scaffold(
      appBar: new AppBar(title:new Text("Tic Tac Toe"),),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[

        new Expanded(child:
        new GridView.builder(
          itemCount: buttonsList.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.0,
            crossAxisSpacing: 9.0,
            mainAxisSpacing: 9.0,
          ) ,
          itemBuilder: (context,i)=> new SizedBox(
            width: 100.0,
            height: 100.0,
            child: new RaisedButton(
              padding:  const EdgeInsets.all(8.0),
              onPressed: buttonsList[i].enabled?()=> playGame(buttonsList[i]):null,
              child: new Text(
                buttonsList[i].text,
                style: new TextStyle(color: Colors.white,fontSize: 20.0),
              ),
              color: buttonsList[i].bg,
              disabledColor: buttonsList[i].bg,
            ),
          ),
        ),
        ),
        new RaisedButton(
          child: new Text("Reset",style: new TextStyle(
              color: Colors.white,
            fontSize: 20.0
          )
          ),
            onPressed: resetGame,
          color: Colors.green,
        ),
      ],
    )
    );
  }
}
