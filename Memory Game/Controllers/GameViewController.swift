//
//  GameViewController.swift
//  Memory Game
//
//  Created by Andrea Bottino on 20/04/2023.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController {
    
    @IBOutlet var allButtons: [CustomButton]!
    @IBOutlet weak var timerBar: UIProgressView!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    var game = GameLogic()
    var musicFx: AVAudioPlayer!
    let defaults = UserDefaults.standard

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStats()
        
        timerBar.progress = 0
        timerBar.transform = timerBar.transform.scaledBy(x: 1, y: 2)
        
        for button in allButtons {
            button.alpha = 0
            button.layer.cornerRadius = 5
            button.clipsToBounds = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            game.setBlack(allButtons)
            
        }
    }

    @IBAction func buttonPressed(_ sender: CustomButton) {
        PlayerStats.stats["Buttons Tapped"]! += 1
        
        playSoundFx(soundname: "selection")
        sender.isEnabled = false
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromRight, animations: nil)
        
        sender.setImage(UIImage(named: sender.revealedAnimal), for: .disabled)
        
        if game.guess1 == "" {
            game.guess1 = sender.revealedAnimal
            game.firstButton = sender
        } else {
            game.guess2 = sender.revealedAnimal
        }
        
        if game.guess1 != "" && game.guess2 != "" {
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [self] in
                
                if game.guess1 == game.guess2 {
                    game.match(sender, game.firstButton!, quitButton, newGameButton)
                    playSoundFx(soundname: "match")
                    
                } else {
                    
                    playSoundFx(soundname: "reset")
                    game.reset(sender, game.firstButton!)
                }
                view.isUserInteractionEnabled = true
            }
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.startAgain(self, allButtons, timerBar, quitButton, newGameButton)
    }
    
    func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "wav")
        musicFx = try! AVAudioPlayer(contentsOf: url!)
        musicFx.play()
    }
    
    func loadStats() {
        if let playerStats = defaults.object(forKey: "playerStats") as? [String : Int] {
            PlayerStats.stats = playerStats
        }
    }
    
    @IBAction func quitPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
