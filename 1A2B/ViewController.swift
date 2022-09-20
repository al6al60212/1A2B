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
    
    var nums: [String] = []
    var answer: [String] = []
    
    //用於讀取guessNumberLable為第inputIndex位
    var inputIndex = Int()
    var life = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newGame()
    }
    
    func newGame(){
        //重置recordLable畫面
        recordLable[0].text = ""
        recordLable[1].text = ""
        //重置answer
        nums = ["0","1","2","3","4","5","6","7","8","9"]
        answer = []
        for _ in 0...3{
            let index = Int.random(in: 0...nums.count - 1)
            answer.append(nums[index])
            nums.remove(at: index)
        }
        
        //將guessNumberLables重置為第1位
        inputIndex = 0
        
        //重置生命
        life = 12
        lifeResultLable.text = "❤️：\(life)    遊戲開始囉～"
        
        //確保所有數字按鈕為開啟狀態
        for button in numberBtnLable{
            button.isEnabled = true
        }
    }
    
    //數字鍵
    @IBAction func numberBtn(_ sender: UIButton) {
        //使用者只能輸入四個數字
        if inputIndex < 4{
            //將使用者按下的數字存入當前guessNumberLables，並關閉按鈕
            guessNumberLables[inputIndex].text = String(sender.tag)
            sender.isEnabled = false
            
            //輸入完後跳至下一位
            inputIndex += 1
        }
    }
    
    //刪除鍵
       @IBAction func deleteBtn(_ sender: Any) {
           //判斷當前guessNumberLables不是在第一位，inputIndex不可小於0
           if inputIndex > 0{
               //將guessNumberLables回復至前一位
               inputIndex -= 1
               
               //判斷當前數字按鈕並恢復
               for numberTag in numberBtnLable{
                   if numberTag.tag == Int(guessNumberLables[inputIndex].text!){
                       numberTag.isEnabled = true
                   }
               }
               //再清空當前guessNumberLables上的數字
               guessNumberLables[inputIndex].text = ""
           }
       }

    
    //GO按鈕
    @IBAction func goBtn(_ sender: Any) {
        //用於儲存判斷完後，a.b的數量
        var a = 0
        var b = 0
        //設變數用於儲存輸入的數字
        var recordNumberString = ""
        
        
        //先判斷輸入數字是否達到4位，未達四位無法執行
        if guessNumberLables[3].text != ""{
            
            //判斷幾Ａ幾Ｂ
            for idx in 0...3{
                if guessNumberLables[idx].text == answer[idx]{
                    a += 1
                }else if answer.contains(guessNumberLables[idx].text!){
                    b += 1
                }
                
                //將輸入的數字存入變數
                recordNumberString += guessNumberLables[idx].text!
                //再將按鈕恢復
                for button in numberBtnLable{
                    if button.tag == Int(guessNumberLables[idx].text!){
                        button.isEnabled = true
                    }
                }
                
                //讓guessNumberLables畫面上輸入的數字變回空值
                guessNumberLables[idx].text = ""
            }
            //並將guessNumberLables重置為第一位
            inputIndex = 0
            
            //每判斷一次，剩餘次數減1
            life -= 1
            //並顯示於lifeResultLable
            lifeResultLable.text = "❤️：\(life)    加油，繼續努力～"
            
            //將輸入結果記錄於recordLable，礙於排版，前6次(後6次)記錄在第一(二)區，且第6(12)次不換行
            if life == 0{
                recordLable[1].text! += recordNumberString + "  \(a)A\(b)B"
            }else if life < 6{
                recordLable[1].text! += recordNumberString + "  \(a)A\(b)B\n"
            }else if life == 6{
                recordLable[0].text! += recordNumberString + "  \(a)A\(b)B"
            }else{
                recordLable[0].text! += recordNumberString + "  \(a)A\(b)B\n"
            }
            
            //判斷遊戲是否結束
            if a == 4{
                lifeResultLable.text = "恭喜你答對了!\n答案是\(answer)"
                for button in numberBtnLable{
                    button.isEnabled = false
                }
            }else if life == 0{
                lifeResultLable.text = "GG!芭比Ｑ了~\n答案是\(answer)"
                for button in numberBtnLable{
                    button.isEnabled = false
                }
            }
        }
    }
    
    //replay按鈕重新開始遊戲
    @IBAction func replayBtn(_ sender: Any) {
        newGame()
    }
    
}

