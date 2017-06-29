//
//  page2.swift
//  Hangman
//
//  Created by Zeki Oduro on 6/26/17.
//  Copyright © 2017 ZAO. All rights reserved.
//

import UIKit


class page2: UIViewController {

    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var formattedWord: UILabel!
    @IBOutlet weak var enterLetter: UITextField!
    @IBOutlet weak var enterBut: UIButton!
    @IBAction func letterEnt(_ sender: UIButton) {
        gameStatus.isHidden = true
        if enterLetter.text == "" {
            gameStatus.isHidden = false
            gameStatus.text = "Please enter a letter or word"
            return
        }
        var ch: Character = (enterLetter.text?.characters.first)!
        
        if enterLetter.text?.characters.count != 1{
            var index = 0
            var arr = word.characters
            var star: Bool = false
            let size = arr.count
            while index < size{
                star = isLetter(ch: arr.popFirst()!)
                if !star{
                    break
                }
                index += 1
            }
            enterLetter.text = enterLetter.text?.lowercased()
            if enterLetter.text == word && star{
                formattedWord.text = word
                formattedWord.textColor = UIColor.green
                gameStatus.isHidden = false
                gameStatus.text = "You Win!"
                playAgain.isHidden = false
                playAgain.isEnabled = true
                instr.isHidden = true
                enterLetter.isHidden = true
                enterBut.isHidden = true
                enterBut.isEnabled = false
            } else if (!star) {
                gameStatus.isHidden = false
                gameStatus.text = "Please enter a letter or word"
            } else {
                strikes += 1
                hanger.image = UIImage(named: "hangman\(strikes)")
                if strikes == movesAllowed{
                    formattedWord.text = word
                    formattedWord.textColor = UIColor.red
                    gameStatus.isHidden = false
                    gameStatus.text = "You Lose!"
                    playAgain.isHidden = false
                    playAgain.isEnabled = true
                    instr.isHidden = true
                    enterLetter.isHidden = true
                    enterBut.isHidden = true
                    enterBut.isEnabled = false
                }
            }
            return
        } else if !isLetter(ch: ch){
            gameStatus.isHidden = false
            gameStatus.text = "Please enter a letter or word"
            return
        }
        ch = toLower(ch: ch)
        if guessedChars.contains(ch) {
            gameStatus.isHidden = false
            gameStatus.text = "You've already guessed this letter"
            return
        }else if word.characters.contains(ch) {
            guessedChars.insert(ch, at: 0)
            formattedWord.text = formatWord(input: word)
            if formattedWord.text == word{
                formattedWord.textColor = UIColor.green
                gameStatus.isHidden = false
                gameStatus.text = "You Win!"
                playAgain.isHidden = false
                playAgain.isEnabled = true
                instr.isHidden = true
                enterLetter.isHidden = true
                enterBut.isHidden = true
                enterBut.isEnabled = false            }
            return
        } else {
            guessedChars.insert(ch, at: 0)
            strikes += 1
            hanger.image = UIImage(named: "hangman\(strikes)")
            if strikes == movesAllowed{
                formattedWord.text = word
                formattedWord.textColor = UIColor.red
                gameStatus.isHidden = false
                gameStatus.text = "You Lose!"
                playAgain.isHidden = false
                playAgain.isEnabled = true
                instr.isHidden = true
                enterLetter.isHidden = true
                enterBut.isHidden = true
                enterBut.isEnabled = false
            }
            return
        }
    }
    
    func toLower(ch:Character)->Character{
        var output: Character = " "
        var low: [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        var upper: [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        var index = 0
        while index < 26{
            if ch == low[index] || ch == upper[index]{
                output = low[index]
            }
            index += 1
        }
        return output
        
    }
    
    func isLetter(ch:Character)->Bool{
        var low: [Character] = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        var upper: [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        var index = 0
        while index < 26 {
            if ch == low[index] || ch == upper[index]{
                return true
            }
            index += 1
        }
        return false
    }
    @IBOutlet weak var instr: UILabel!
    @IBOutlet weak var hanger: UIImageView!
    @IBAction func again(_ sender: UIButton) {
        performSegue(withIdentifier: "restart", sender: sender)
    }
    
    var word:String!
    var guessedChars:[Character] = []
    let movesAllowed = 6
    var strikes = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStatus.isHidden = true
        playAgain.isHidden = true
        playAgain.isEnabled = false
        formattedWord.text = formatWord(input: word)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatWord(input: String)->String{
        var output = ""
        for ch in word.characters{
            if guessedChars.contains(ch){
                output += "\(ch)"
            } else {
                output += " _ "
            }
        }
        
        return output
        
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
