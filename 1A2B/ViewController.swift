//
//  ViewController.swift
//  1A2B
//
//  Created by 董禾翊 on 2022/9/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var recordLable: [UILabel]!
    @IBOutlet weak var lifeResultLable: UILabel!
    @IBOutlet var guessNumberLables: [UILabel]!
    @IBOutlet var numberBtnLable: [UIButton]!
    
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var delete: UIButton!
    
    var nums = ["0","1","2","3","4","5","6","7","8","9"]
    var answer: [String] = []
    var inputIndex = 0
    var life = 12
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        answer = []
        recordLable[0].text = ""
        recordLable[1].text = ""
        lifeResultLable.text = "❤️：\(life)"
        for _ in 0...3{
            let index = Int.random(in: 0...nums.count - 1)
            answer.append(nums[index])
            nums.remove(at: index)
        }
        print(answer)
    }
    //數字鍵
    @IBAction func numberBtn(_ sender: UIButton) {
        if inputIndex < 4{
            guessNumberLables[inputIndex].text = String(sender.tag)
            inputIndex += 1
            sender.isEnabled = false
        }
        
    }
    //GO按鈕
    @IBAction func goBtn(_ sender: Any) {
        var a = 0
        var b = 0
        //判斷輸入數量是否達到4位，未達四位無法執行
        if guessNumberLables[3].text != ""{
            //設參數紀錄輸入的數字
            var recordNumberString = ""
            //判斷幾Ａ幾Ｂ
            for idx in 0...3{
                if guessNumberLables[idx].text == answer[idx]{
                    a += 1
                }else if answer.contains(guessNumberLables[idx].text!){
                    b += 1
                }
                //將輸入的數字傳入紀錄
                recordNumberString += guessNumberLables[idx].text!
                //恢復按鈕
                for button in numberBtnLable{
                    if button.tag == Int(guessNumberLables[idx].text!){
                        button.isEnabled = true
                    }
                }
                //讓畫面上輸入的數字變回空值
                guessNumberLables[idx].text = ""
            }
            life -= 1
            lifeResultLable.text = "❤️：\(life)"
            
            inputIndex = 0
            if life == 0{
                recordLable[1].text! += recordNumberString + "  \(a)A\(b)B"
            }else if life < 6{
                recordLable[1].text! += recordNumberString + "  \(a)A\(b)B\n"
            }else if life == 6{
                recordLable[0].text! += recordNumberString + "  \(a)A\(b)B"
            }else{
                recordLable[0].text! += recordNumberString + "  \(a)A\(b)B\n"
            }
            
            if a == 4{
                lifeResultLable.text = "恭喜你答對了"
                for button in numberBtnLable{
                    button.isEnabled = false
                }
            }else if life == 0{
                lifeResultLable.text = "GG!芭比Ｑ了"
                for button in numberBtnLable{
                    button.isEnabled = false
                }
            }
        }
    }
    //刪除鍵
    @IBAction func deleteBtn(_ sender: Any) {
        if inputIndex > 0{
            inputIndex -= 1
            for numberTag in numberBtnLable{
                if numberTag.tag == Int(guessNumberLables[inputIndex].text!){
                    numberTag.isEnabled = true
                }
            }
            guessNumberLables[inputIndex].text = ""
        }
    }
    
    @IBAction func replayBtn(_ sender: Any) {
        nums = ["0","1","2","3","4","5","6","7","8","9"]
        answer = []
        inputIndex = 0
        life = 12
        recordLable[0].text = ""
        recordLable[1].text = ""
        lifeResultLable.text = "❤️：\(life)"
        for _ in 0...3{
            let index = Int.random(in: 0...nums.count - 1)
            answer.append(nums[index])
            nums.remove(at: index)
        }
        for button in numberBtnLable{
            button.isEnabled = true
        }
    }
    
}

