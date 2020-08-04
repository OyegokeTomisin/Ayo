//
//  Game.swift
//  Ayo
//
//  Created by OYEGOKE TOMISIN on 03/08/2020.
//  Copyright © 2020 OYEGOKE TOMISIN. All rights reserved.
//

import Foundation

class Game {

    var gamePot = [Pot]()
    var playerWinnerGamePot = (player1: 0, player2: 0)
    var playerGamePot = (player1: [Pot](), player2: [Pot]())
    var currentPlayer: Player = .player2

    init() {
        setupPot()
        var index = 4
        startPlay(from: &index)
    }

    func setupPot(){
        for _ in 0 ..< 12 {
            let pot = Pot()
            gamePot.append(pot)
        }
        playerGamePot.player1 = Array(gamePot[0...5])
        playerGamePot.player2 = Array(gamePot[6...11])
    }

    func startPlay(from index: inout Int){
        guard index < 6 else { return } // Index of player one or two collection view can't be more than 6 i.e UI is 2D
        if currentPlayer == .player2 { index += 6 }
        let pickedUpSeeds = gamePot[index].seed
        if pickedUpSeeds > 0 { // You can't pick up from an empty pot
            gamePot[index].seed =  0
            moveSeeeds(from: index, with: pickedUpSeeds)
        }
    }

    func moveSeeeds(from startIndex: Int, with numberOfPickedUpSeeds: Int){
        print("\nPicking started at \( 0...5 ~= startIndex ? "A" : "B")\(startIndex)")
        var spaceToDropSeed = startIndex + 1
        for _ in 0 ..< numberOfPickedUpSeeds {
            spaceToDropSeed = spaceToDropSeed > 11 ? 0 : spaceToDropSeed // Start dropping remaining seeds from beginning i.e index 0
            gamePot[spaceToDropSeed].seed += 1 // Drop one seed in pot
            print("\nPot \(0...5 ~= spaceToDropSeed ? "A" : "B")\(spaceToDropSeed) now at \(gamePot[spaceToDropSeed].seed)")
            spaceToDropSeed += 1
        }

        showPotSize(player: .player1)
        showPotSize(player: .player2)

        applyPotWinnings()
    }

    //TODO: - Apply rules for winning and play continuity
    func applyPotWinnings(){ }
}

extension Game {
    func showPotSize(player: Player) {
        print("\n")
        switch player {
        case .player1:
            for index in 0 ..< playerGamePot.player1.count {
                print("Player 1: A\(index) -------- \(playerGamePot.player1[index].seed)")
            }
        case .player2:
            for index in 0 ..< playerGamePot.player2.count {
                print("Player 2: B\(index + 6) -------- \(playerGamePot.player2[index].seed)")
            }
        }
    }
}
