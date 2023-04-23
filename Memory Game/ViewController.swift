//
//  ViewController.swift
//  Memory Game
//
//  Created by Andrea Bottino on 20/04/2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var game = Buttons()
    
    @IBOutlet var allButtons: [UIButton]!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    
    var musicFx: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.assignAll()
        game.setBlack(allButtons)
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        playSoundFx(soundname: "selection")
        sender.isEnabled = false
        
        switch sender {
            
        case button1:
            
            sender.setImage(UIImage(named: game.img1!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img1!
                game.firstButton = sender
            } else {
                game.guess2 = game.img1!
            }
            
        case button2:
            
            sender.setImage(UIImage(named: game.img2!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img2!
                game.firstButton = sender
            } else {
                game.guess2 = game.img2!
            }
            
        case button3:
            
            sender.setImage(UIImage(named: game.img3!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img3!
                game.firstButton = sender
            } else {
                game.guess2 = game.img3!
            }
            
        case button4:
            
            sender.setImage(UIImage(named: game.img4!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img4!
                game.firstButton = sender
            } else {
                game.guess2 = game.img4!
            }
            
        case button5:
            
            sender.setImage(UIImage(named: game.img5!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img5!
                game.firstButton = sender
            } else {
                game.guess2 = game.img5!
            }
            
        case button6:
            
            sender.setImage(UIImage(named: game.img6!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img6!
                game.firstButton = sender
            } else {
                game.guess2 = game.img6!
            }
            
        case button7:
            
            sender.setImage(UIImage(named: game.img7!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img7!
                game.firstButton = sender
            } else {
                game.guess2 = game.img7!
            }
            
        case button8:
            
            sender.setImage(UIImage(named: game.img8!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img8!
                game.firstButton = sender
            } else {
                game.guess2 = game.img8!
            }
            
        case button9:
            
            sender.setImage(UIImage(named: game.img9!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img9!
                game.firstButton = sender
            } else {
                game.guess2 = game.img9!
            }
            
        case button10:
            
            sender.setImage(UIImage(named: game.img10!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img10!
                game.firstButton = sender
            } else {
                game.guess2 = game.img10!
            }
            
        case button11:
            
            sender.setImage(UIImage(named: game.img11!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img11!
                game.firstButton = sender
            } else {
                game.guess2 = game.img11!
            }
            
        case button12:
            
            sender.setImage(UIImage(named: game.img12!), for: .disabled)
            if game.guess1 == "" {
                game.guess1 = game.img12!
                game.firstButton = sender
            } else {
                game.guess2 = game.img12!
            }
            
        default:
            print("")
        }
        
        if game.guess1 != "" && game.guess2 != "" {
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
                
                if game.guess1 == game.guess2 {
                    game.match(sender, game.firstButton!)
                    playSoundFx(soundname: "match")
                } else {
                    game.reset(sender, game.firstButton!)
                    playSoundFx(soundname: "reset")
                }
                view.isUserInteractionEnabled = true
            }
        }
    }
    
    @IBAction func resetGame(_ sender: UIButton) {
        
        game.startAgain(allButtons)
        game.assignAll()
    }
    
    func playSoundFx(soundname: String) {
        let url = Bundle.main.url(forResource: soundname, withExtension: "wav")
        musicFx = try! AVAudioPlayer(contentsOf: url!)
        musicFx.play()
    }
}
