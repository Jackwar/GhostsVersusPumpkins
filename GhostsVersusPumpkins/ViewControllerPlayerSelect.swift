//
//  ViewControllerPlayerSelect.swift
//  GhostsVersusPumpkins
//
//  Created by Jackson Warburton on 4/2/17.
//  Copyright © 2017 Jackson Warburton. All rights reserved.
//

import UIKit

class ViewControllerPlayerSelect: UIViewController, UITextFieldDelegate {

    let orange = UIColor(colorLiteralRed: 241/255, green: 88/255, blue: 2/255, alpha: 1.0)
    
    @IBOutlet weak var playerLbl: UILabel!
    
    @IBOutlet weak var ghostPumpkinLbl: UILabel!
    
    @IBOutlet weak var nameInput: UITextField!
    
    @IBOutlet weak var nextStartBt: UIButton!
    
    var player1Chosen: Bool = false
    
    var player1: String = "Player 1"
    
    var player2: String = "Player 2"
    
    @IBAction func nextAndStart(_ sender: Any) {
        
        if !player1Chosen {
            playerLbl.text = "Player 2"
            ghostPumpkinLbl.text = "Pumpkins"
        
            playerLbl.textColor = orange
            ghostPumpkinLbl.textColor = orange
        
            playerLbl.font = UIFont(name: "Didot", size: 33.0)
            ghostPumpkinLbl.font = UIFont(name: "Didot", size: 33.0)
        
            nameInput.placeholder = "Player 2"
            
            player1Chosen = true
            
            if nameInput.text != "" {
                
                player1 = nameInput.text!
                nameInput.text = ""
                
            }
            
        } else {
            
            if nameInput.text != "" {
                
                player2 = nameInput.text!
                
            }
            
            let passedNames = (player1, player2)
            
            performSegue(withIdentifier: "StartGame", sender: passedNames)
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if (segue.identifier == "StartGame") {
            
            if let destination = segue.destination as? ViewControllerGameBoard {
                
                destination.playerNames = sender as? (String, String)
    
            }
            
        }
        
    }
 

}
