//
//  SettingsViewController.swift
//  RockPapersCissors
//
//  Created by Daniel Esteban Alcantara on 10/10/26.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var roundsSlider: UISlider!
    
    @IBOutlet weak var pointsPerWinTextField: UITextField!
    
    @IBOutlet weak var pointsLostperLostTextField: UITextField!
    
    @IBOutlet weak var pointsToWinTextField: UITextField!
    
    @IBOutlet weak var roundsModeStack: UIStackView!
    
    @IBOutlet weak var pointsModeStack: UIStackView!
    
    @IBOutlet weak var continueButton: UIButton!
    
    struct GamePayload {
        var playerName: String
        var gameMode: Int

        // Modo por rondas
        var rounds: Int?

        // Modo por puntos
        var pointsPerWin: Int?
        var pointsPerLoss: Int?
        var pointsToWin: Int?
    }

    var gamePayload = GamePayload(
        playerName: "",
        gameMode: 0,
        rounds: nil,
        pointsPerWin: nil,
        pointsPerLoss: nil,
        pointsToWin: nil
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapOutside = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )

        tapOutside.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOutside)

        roundsSlider.minimumValue = 1
        roundsSlider.maximumValue = 5

        roundLabel.text = String(Int(roundsSlider.value.rounded()))

        updateGameMode()
        updatePayload()
        updateButtonState()

    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateGameMode() {
        switch modeSegmentedControl.selectedSegmentIndex {
        case 0:
            roundsModeStack.isHidden = false
            pointsModeStack.isHidden = true

        case 1:
            roundsModeStack.isHidden = true
            pointsModeStack.isHidden = false

        default:
            break
        }
    }
    
    @IBAction func gameModeChangedControl(_ sender: UISegmentedControl) {
        updateGameMode()
        updatePayload()
        updateButtonState()
    }
    
    @IBAction func roundsSliderChanged(_ sender: UISegmentedControl) {
    }
    
    @IBAction func roundSliderChanged(_ sender: UISlider) {
        
        let rounds = Int(sender.value.rounded())

        roundLabel.text = String(rounds)

        updateButtonState()
    }
    
    @IBAction func nameInputChanged(_ sender: UITextField) {
        updateButtonState()
    }

    @IBAction func pointsPerWinInputLabel(_ sender: UITextField) {
        updateButtonState()
    }
    
    @IBAction func pointsLostPerLostInputLabel(_ sender: UITextField) {
        updateButtonState()
    }
    
    @IBAction func pointsToWinInputLabel(_ sender: UITextField) {
        updateButtonState()
    }
    
    @IBAction func infoButton(_ sender: UIButton) {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true)
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        updatePayload()
        
        let gameViewController = GameViewController(nibName: "GameViewController", bundle: nil)
        
        gameViewController.playerName = gamePayload.playerName
        gameViewController.gameMode = gamePayload.gameMode
        gameViewController.rounds = gamePayload.rounds
        gameViewController.pointsPerWin = gamePayload.pointsPerWin
        gameViewController.pointsPerLoss = gamePayload.pointsPerLoss
        gameViewController.pointsToWin = gamePayload.pointsToWin
        
        navigationController?.pushViewController(gameViewController, animated: true)
        
        print("Configuración de la partida:")
        print(gamePayload)
    }
    
    func validateFields() -> Bool {

        guard let name = nameTextField.text,
              !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }

        switch modeSegmentedControl.selectedSegmentIndex {

        case 0:
            
            guard let text = roundLabel.text,
                  let rounds = Int(text) else {
                return false
            }

            return (1...5).contains(rounds)

        case 1:
            
            guard let pointsWin = Int(pointsPerWinTextField.text ?? ""),
                  let pointsLost = Int(pointsLostperLostTextField.text ?? ""),
                  let pointsToWin = Int(pointsToWinTextField.text ?? "") else {
                return false
            }

            return pointsWin > 0 &&
                   pointsLost >= 0 &&
                   pointsToWin > 0

        default:
            return false
        }
    }
    
    func updateButtonState() {
        continueButton.isEnabled = validateFields()
    }
    
    func updatePayload() {

        gamePayload.playerName = nameTextField.text ?? ""
        gamePayload.gameMode = modeSegmentedControl.selectedSegmentIndex

        switch gamePayload.gameMode {

        case 0:
            gamePayload.rounds = Int(roundLabel.text ?? "")

            gamePayload.pointsPerWin = nil
            gamePayload.pointsPerLoss = nil
            gamePayload.pointsToWin = nil

        case 1:
            gamePayload.rounds = nil

            gamePayload.pointsPerWin = Int(pointsPerWinTextField.text ?? "")
            gamePayload.pointsPerLoss = Int(pointsLostperLostTextField.text ?? "")
            gamePayload.pointsToWin = Int(pointsToWinTextField.text ?? "")

        default:
            break
        }
    }
    
}
