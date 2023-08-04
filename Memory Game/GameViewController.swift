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
    
    var game = GameLogic()
    var musicFx: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
                    game.match(sender, game.firstButton!)
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
        
        game.startAgain(self, allButtons, timerBar)
    }
    
    func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "wav")
        musicFx = try! AVAudioPlayer(contentsOf: url!)
        musicFx.play()
    }
}
