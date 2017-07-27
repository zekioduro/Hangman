//
//  page2.swift
//  Hangman
//
//  Created by Zeki Oduro on 6/26/17.
//  Copyright © 2017 ZAO. All rights reserved.
//

import UIKit


class page2: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var formattedWord: UILabel!
    @IBOutlet weak var enterLetter: UITextField!
    @IBOutlet weak var enterBut: UIButton!
    @IBAction func letterEnt(_ sender: UIButton) {
        view.endEditing(true)
        gameStatus.isHidden = true
        if enterLetter.text == "" {
            gameStatus.isHidden = false
            gameStatus.text = "Please enter a letter or word"
            enterLetter.text = ""
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
            enterLetter.text = ""
            return
        } else if !isLetter(ch: ch){
            gameStatus.isHidden = false
            gameStatus.text = "Please enter a letter or word"
            enterLetter.text = ""
            return
        }
        ch = toLower(ch: ch)
        if guessedChars.contains(ch) {
            gameStatus.isHidden = false
            gameStatus.text = "You've already guessed this letter"
            enterLetter.text = ""
            return
        }else if word.characters.contains(ch) {
            guessedChars.append(ch)
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
                enterBut.isEnabled = false
            }
            enterLetter.text = ""
            return
        } else {
            guessedChars.append(ch)
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
            enterLetter.text = ""
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        enterLetter.delegate = self
        gameStatus.isHidden = true
        playAgain.isHidden = true
        playAgain.isEnabled = false
        formattedWord.text = formatWord(input: word)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector (keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
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
    

    func keyboardWillShow(notify: NSNotification){
        if let size = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= size.height
            }
        }
    }
    
    func keyboardWillHide(notify: NSNotification){
        if let size = (notify.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += size.height
            }
        }
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }


}
