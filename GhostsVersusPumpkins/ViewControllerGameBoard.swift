//
//  ViewControllerGameBoard.swift
//  GhostsVersusPumpkins
//
//  Created by Jackson Warburton on 4/2/17.
//  Copyright © 2017 Jackson Warburton. All rights reserved.
//

import UIKit

class ViewControllerGameBoard: UIViewController {
    
    //Colors used for labels, buttons and backgrounds
    let orange = UIColor(colorLiteralRed: 241/255, green: 88/255, blue: 2/255, alpha: 1.0)
    
    let orangeBackground = UIColor(colorLiteralRed: 241/255, green: 88/255, blue: 2/255, alpha: 0.25)
    
    let whiteBackground = UIColor(colorLiteralRed: 61/255, green: 61/255, blue: 61/255, alpha: 0.50)
    
    //The players names
    var playerNames: (String, String)!
    
    //Array of all the ImageViews for the Tic Tac Toe board
    @IBOutlet var images: [UIImageView]!
    
    //Label to be shown when a player wins
    //Displays the winners name
    @IBOutlet weak var winLabel: UILabel!
    
    //Label to be displayed underneath the winners name
    @IBOutlet weak var winsLabel: UILabel!
    
    //Label to display the current players name
    @IBOutlet weak var playerName: UILabel!
    
    //Button to go back to the first screen
    @IBOutlet weak var mainScreenBT: UIButton!
    
    //Button to reset the game board and play again
    @IBOutlet weak var playAgainBt: UIButton!
    
    //Is the game over or still going?
    var gameOver = false
    
    //Sets the first player to ghost
    var firstPlayer = "ghost"
    
    //Sets the first active player to ghost
    var activePlayer = "ghost"
    
    //Array to tell if a ImageView has been pressed yet
    //using the ImageViews tag
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    //The binary values for each ImageView
    var squareValue = [1, 2, 4, 8, 16, 32, 64, 128, 256]
    //The winning binary values
    var winsArray = [7, 56, 448, 73, 146, 292, 273, 84]
    
    //The pumpkin players current score
    var pumpkinScore = 0
    //The ghost players current score
    var ghostScore = 0
    
    //The amount of turns played so far
    var turnCount = 0
    
    //Runs when an ImageView is pressed, or spot in the game board
    @IBAction func playerSelection(_ sender: AnyObject) {
        
        //Get the pressed ImageView from the corresponding TagGestureRecognizer
        var pressedImage = (sender as? UITapGestureRecognizer)?.view as? UIImageView
        
        //Check if ImageView has been pressed, or if the game is still going
        if (gameState[(pressedImage?.tag)!] == 0 && !gameOver) {
            
            if (activePlayer == "ghost") {
                
                animateGhost(ghostImg: pressedImage!)
                
                ghostScore += squareValue[(pressedImage?.tag)!]
                
                if (checkWin(score: ghostScore)) {
                    
                    winLabel.text = playerNames.0
                    
                } else {
                
                    setPumpkinText()
                    
                }
                
                
            } else if (!gameOver) {
                
                animatePumpkin(pumpkinImg: pressedImage!)
                
                pumpkinScore += squareValue[(pressedImage?.tag)!]
                
                if (checkWin(score: pumpkinScore)) {
                    
                    winLabel.text = playerNames.1
                    
                } else {
                
                    setGhostText()
                }
                
            }
            
            turnCount = turnCount + 1
            
            gameState[(pressedImage?.tag)!] = 1
            
            if (turnCount == 9 && !gameOver) {
                
                playerWon()
                winsLabel.isHidden = true
                
                winLabel.text = "Draw!"
                
            }
            
        }
        
        
        
    }
    
    //Runs when Play Again is pressed, resets board to default state
    @IBAction func playAgain(_ sender: Any) {
        
        for image in images {
            image.image = UIImage()
        }
        
        hideButtonsLabels()
        
        pumpkinScore = 0
        ghostScore = 0
        
        gameOver = false
        
        turnCount = 0
        
        for i in 0...gameState.count - 1 {
            
            gameState[i] = 0
            
        }
        
        if (firstPlayer == "ghost") {
            
            firstPlayer = "pumpkin"
            activePlayer = "pumpkin"
            
            setPumpkinText()
            
        } else {
            
            firstPlayer = "ghost"
            activePlayer = "ghost"
            
            setGhostText()
            
        }
        
        
    }
    
    //Check for a winning score
    func checkWin(score: Int) -> Bool {
        
        for winVals in winsArray {
            
            if ((winVals & score) == winVals) {
                playerWon()
                return true
            }
        }
        
        return false
        
    }
    
    //Unhides winning labels when player wins, and sets the game as over
    func playerWon() {
        
        winLabel.isHidden = false
        winsLabel.isHidden = false
        mainScreenBT.isHidden = false
        playAgainBt.isHidden = false
        
        gameOver = true
        
    }
    
    //Hides the winning labels
    func hideButtonsLabels() {
        
        winLabel.isHidden = true
        winsLabel.isHidden = true
        mainScreenBT.isHidden = true
        playAgainBt.isHidden = true
        
    }
    
    //Sets the playerName label color, font, and name to the pumpkin player
    func setPumpkinText() {
        
        playerName.text = playerNames.1
        playerName.textColor = orange
        playerName.font = UIFont(name: "Didot", size: 33.0)
        playerName.backgroundColor = whiteBackground
        
        activePlayer = "pumpkin"
        
    }
    
    //Sets the playerName label color, font, and name to the ghost player
    func setGhostText() {
        
        playerName.text = playerNames.0
        playerName.textColor = UIColor.white
        playerName.font = UIFont(name: "American Typewriter", size: 33.0)
        playerName.backgroundColor = orangeBackground
        
        activePlayer = "ghost"
        
    }
    
    //Animates in a ghost image in the board where presed
    func animateGhost(ghostImg: UIImageView) {
        
        ghostImg.alpha = 0
        
        ghostImg.image = UIImage(named: "ghost.png")
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            ghostImg.alpha = 1
        })
        
    }
    
    //Animates in a pumpkin image in the board where presed
    func animatePumpkin(pumpkinImg: UIImageView) {
        
        let originalX = pumpkinImg.center.x
        let originalY = pumpkinImg.center.y
        
        pumpkinImg.center = CGPoint(x: originalX, y: originalY + -400)
        
        pumpkinImg.image = UIImage(named: "pumpkin.png")
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            pumpkinImg.center = CGPoint(x: originalX, y: originalY)
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Hide winner labels on load
        hideButtonsLabels()
        
        //Sets up the playerName label for first run
        playerName.text = playerNames.0
        
        playerName.backgroundColor = orangeBackground
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
