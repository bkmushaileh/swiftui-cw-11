//
//  ContentView.swift
//  XOGame
//
//  Created by Khaled Al-Mushaileh on 1/5/21.
//

import SwiftUI
struct Field
{
    var player : String
    var enabled : Bool
}

struct ContentView: View {
    @State var fields: [[Field]] = .init(repeating: .init(repeating: Field(player: "", enabled: true), count:3 ), count:3)
    @State var playerTurn : String = "X"
    @State var winner = ""
    @State var winStatus = false
    @State var drawCounter = 0
    
    
    var body: some View {
        VStack(spacing: 10){
            if winStatus == false{
            Text("\(playerTurn)'s Turn")
                .font(.title)
                
            }
            else
            {
                Text("\(winner)")
                    .font(.title)
            }
            
            ForEach(0..<3) { r in
                HStack(spacing: 10){
                    ForEach(0..<3) { c in
                        Button(action: {
                                // Logic
                                // Check if the field that i press it enabled
                                // if its enabled than you can play
                                
                                if fields[r][c].enabled{

                                    fields[r][c].player = playerTurn
                                    drawCounter += 1
                                    checkWinner()
                                    if winStatus == false
                                    {
                                        
                                        // changing player
                                        playerTurn = playerTurn == "X" ? "O" : "X"
                                        // enabled the field
                                        fields[r][c].enabled = false
                                    }
                                    else {
                                        fields[0][0].enabled = false
                                        fields[0][1].enabled = false
                                        fields[0][2].enabled = false
                                        fields[1][0].enabled = false
                                        fields[1][1].enabled = false
                                        fields[1][2].enabled = false
                                        fields[2][0].enabled = false
                                        fields[2][1].enabled = false
                                        fields[2][2].enabled = false

                                    }
                                }  } )
                        {
                            //Label Desigin
                            Text(fields[r][c].player)
                                .font(.system(size: 60))
                                .foregroundColor(.black)
                                .frame(width:90 , height: 90, alignment: .center)
                                .background(Color.white)
                        }
                    }
                }
            }
            if winner != "" {
                Button(action: {restartG()}){
                    Text("Restart")
                        .font(.largeTitle)
                }
                .padding(.top,20)
            }
        }.background(Color.gray)
    }
    
    func checkWinner(){
        let r1 = fields[0][0].player == playerTurn &&
        fields[0][1].player == playerTurn &&
        fields[0][2].player == playerTurn
        let r2 = fields[1][0].player == playerTurn &&
        fields[1][1].player == playerTurn &&
        fields[1][2].player == playerTurn
        let r3 = fields[2][0].player == playerTurn &&
        fields[2][1].player == playerTurn &&
        fields[2][2].player == playerTurn
        let c1 = fields[0][0].player == playerTurn &&
        fields[1][0].player == playerTurn &&
        fields[2][0].player == playerTurn
        let c2 = fields[0][1].player == playerTurn &&
        fields[1][1].player == playerTurn &&
        fields[2][1].player == playerTurn
        let c3 = fields[0][2].player == playerTurn &&
        fields[1][2].player == playerTurn &&
        fields[2][2].player == playerTurn
        let d1 = fields[0][0].player == playerTurn &&
        fields[1][1].player == playerTurn &&
        fields[2][2].player == playerTurn
        let d2 = fields[0][2].player == playerTurn &&
        fields[1][1].player == playerTurn &&
        fields[2][0].player == playerTurn
        
        if r1 || r2 || r3 || c1 || c2 || c3 || r3 || d1 || d2
        {
            winner = ("\(playerTurn) win")
            winStatus = true
        }
        else if drawCounter == 9{
            winner  = "Draw"
            winStatus = true
        }
    }

    func restartG(){
        fields = .init(repeating: .init(repeating: Field(player: "", enabled: true), count: 3), count:3)
        playerTurn = "X"
        winner = ""
        winStatus = false
        drawCounter = 0
    }
    }




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }

}
