//
//  ViewController.swift
//  Hangman
//
//  Created by Zeki Oduro on 6/25/17.
//  Copyright © 2017 ZAO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBAction func startGame(_ sender: UIButton) {
        let word = enterWord.text!
        if (word.characters.count) > 20 || (word.characters.count) == 0{
            warningLabel.isHidden = false
            warningLabel.text = "Word must be between 1 and 20 characters. Enter Again"
            return
        }
        var index = 0
        var arr = word.characters
        let size = arr.count
        while index < size{
            if !isLetter(ch: arr.popFirst()!){
                warningLabel.isHidden = false
                warningLabel.text = "Please enter one word with only letters"
                return
            }
            index += 1
        }
        enterWord.text = word.lowercased()
        performSegue(withIdentifier: "start", sender: sender)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var enterWord: UITextField!
   
    @IBOutlet var second: UIView!
    @IBOutlet var first: UIView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "start"{
            let sec = segue.destination as! page2
            sec.word = enterWord.text
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

    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

