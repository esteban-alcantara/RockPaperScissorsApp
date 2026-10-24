//
//  GameViewController.swift
//  RockPapersCissors
//
//  Created by Daniel Esteban Alcantara on 10/10/26.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var titleGameModeLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var pointRoundLabel: UILabel!
    @IBOutlet weak var playerNameLabel: UILabel!

    @IBOutlet weak var botImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!

    var playerName: String = ""
    var gameMode: Int? = nil
    var rounds: Int? = nil
    var pointsPerWin: Int? = nil
    var pointsPerLoss: Int? = nil
    var pointsToWin: Int? = nil

    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    @IBOutlet weak var nextTurnButton: UIButton!

    var botSelect : Int = 0
    var userSelect : Int = 0
    var matchResults : [Int] = []

    var roundsPlayed : Int = 0
    var pointsEarn : Int = 0
    private var isGameFinished = false
    private var isWaitingForNextTurn = false

    let imagesOotions = ["", "seal.fill", "newspaper", "scissors"]


    override func viewDidLoad() {
        super.viewDidLoad()
        playerNameLabel.text = playerName.isEmpty ? "User" : playerName
        nextTurnButton.isHidden = true
        
        view.backgroundColor = .beige
        
        switch gameMode{
        case 0:
            titleGameModeLabel.text = "Rounds Game"
            modeLabel.text = "Round: "
            pointRoundLabel.text = "1"
        case 1:
            titleGameModeLabel.text = "Points Game"
            modeLabel.text = "Points: "
            pointRoundLabel.text = "0"
        default:
            titleGameModeLabel.text = "Error"
            modeLabel.text = ":c"
        }
        prepareNextTurn()


    }

    @IBAction func rockButtonPressed(_ sender: UIButton) {
        userSelect = 1
        botSelect = Int.random(in: 1...3)
        game(botSelect, userSelect)

        paperButton.tintColor = .blue3
        scissorsButton.tintColor = .blue3
    }

    @IBAction func paperButtonPressed(_ sender: UIButton) {
        userSelect = 2
        botSelect = Int.random(in: 1...3)
        game(botSelect, userSelect)

        rockButton.tintColor = .blue3
        scissorsButton.tintColor = .blue3

    }

    @IBAction func scissorsButtonPressed(_ sender: UIButton) {
        userSelect = 3
        botSelect = Int.random(in: 1...3)
        game(botSelect, userSelect)

        rockButton.tintColor = .blue3
        paperButton.tintColor = .blue3
    }


    @IBAction func gameHistoryButtonPressed(_ sender: UIButton) {
        let historyViewController = HistoryViewController()

        historyViewController.matchResults = matchResults

        navigationController?.pushViewController(historyViewController, animated: true)

    }

    @IBAction func nextTurnButtonPressed(_ sender: UIButton) {
        
        guard !isGameFinished, isWaitingForNextTurn else { return }
        prepareNextTurn()
    }

    private func prepareNextTurn() {
        isWaitingForNextTurn = false
        view.backgroundColor = .beige
        rockButton.isEnabled = true
        paperButton.isEnabled = true
        scissorsButton.isEnabled = true
        nextTurnButton.isHidden = true
        userImage.image = UIImage(named: "user")
        botImage.image = UIImage(named: "bot")

        if gameMode == 0 {
            pointRoundLabel.text = String(roundsPlayed + 1)
        } else {
            pointRoundLabel.text = String(pointsEarn)
        }
    }


    func playerWins(_ j1: Int, _ j2: Int) -> Bool {
        (j1 == 1 && j2 == 3) ||
        (j1 == 2 && j2 == 1) ||
        (j1 == 3 && j2 == 2)
    }

    func game(_ bot: Int, _ player: Int) {
        guard !isGameFinished, !isWaitingForNextTurn else { return }
        isWaitingForNextTurn = true

        rockButton.isEnabled = false
        paperButton.isEnabled = false
        scissorsButton.isEnabled = false

        nextTurnButton.isHidden = false

        userImage.image = UIImage(systemName: imagesOotions[player])
        botImage.image = UIImage(systemName: imagesOotions[bot])

        if bot == player {
            view.backgroundColor = .draw
            matchResults.append(1)
        } else if playerWins(player, bot) {
            view.backgroundColor = .win
            matchResults.append(2)
            if gameMode == 1 {
                pointsEarn += pointsPerWin ?? 0
            }
        } else {
            view.backgroundColor = .lose
            matchResults.append(0)
            if gameMode == 1 {
                pointsEarn -= pointsPerLoss ?? 0
            }
        }

        roundsPlayed += 1
        switch gameMode {
        case 0:
            pointRoundLabel.text = String(roundsPlayed)
            if let rounds, roundsPlayed >= rounds {
                finishGame()
            }
        case 1:
            pointRoundLabel.text = String(pointsEarn)
            if let pointsToWin, pointsEarn >= pointsToWin {
                finishGame()
            }
        default:
            break
        }
    }

    private func finishGame() {
        isGameFinished = true
        nextTurnButton.isHidden = true

        let alert = UIAlertController(
            title: "Game Finish",
            message: "Tap Restart Game to play again with the same settings, or go back to Settings to change them.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Got it", style: .default))
        present(alert, animated: true)
    }

    @IBAction func restartButtonPressed(_ sender: UIButton) {
        roundsPlayed = 0
        pointsEarn = 0
        botSelect = 0
        userSelect = 0
        isGameFinished = false
        prepareNextTurn()
    }


}
