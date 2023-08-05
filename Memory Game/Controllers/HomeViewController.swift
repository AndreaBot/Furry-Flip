//
//  HomeViewController.swift
//  Furry Flip
//
//  Created by Andrea Bottino on 04/08/2023.
//

import UIKit

class HomeViewController: UIViewController {


    @IBOutlet var buttons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in buttons {
            button.layer.cornerRadius = 10
            button.layer.borderColor = CGColor(gray: 0, alpha: 1)
            button.layer.borderWidth = 4
            button.backgroundColor = .white
        }
    }
}
