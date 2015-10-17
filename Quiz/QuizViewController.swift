//
//  QuizViewController.swift
//  Quiz
//
//  Created by kztskawamu on 2015/10/15.
//  Copyright © 2015年 cazcawa. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    
    //問題文を格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer:Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons1: UIButton!
    @IBOutlet var choiceButtons2: UIButton!
    @IBOutlet var choiceButtons3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [AnyObject]()
        
        //tmpArrayに問題文と３つの選択肢と答えの番号の入った配列を追加していく
        tmpArray.append(["Appleの2015年現在のCEOの名前は？","スティーブ・ジョブズ","ティム・クック","ジョナサン・アイブ",2])
        tmpArray.append(["iPhone6s,iPhone6s Plusから新たに導入された、画面タッチの指の圧力を検出する機能をなんという？","3Dタッチ","4Dタッチ","スーパータッチ",1])
        tmpArray.append(["iPod touchのモデルのなかで最大容量のものは何GB？","64GB","128GB","160GB",2])
        tmpArray.append(["1985年、Appleを追放されたジョブズが立ち上げた会社名の正式表記は？","NEXt, Inc.","NExT, Inc.","NeXT, Inc.",3])
        tmpArray.append(["2015年9月30日にリリースされたOSXの名前は？","El Captain","El Capitan","ElCapital",2])
        tmpArray.append(["Apple WatchはiPhoneとどんな通信方式でペアリングされる？","FM電波","Wi-Fi","Bluetooth",3])
        
        
        // 問題をシャッフルしてquizArrayに格納する
        srand(UInt32(time(nil)))
        while (tmpArray.count > 0) {
            let index = Int(rand()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        
        //問題文のテキストを表示
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButtons1.setTitle((quizArray[0][1] as! String), forState: .Normal)
        choiceButtons2.setTitle((quizArray[0][2] as! String), forState: .Normal)
        choiceButtons3.setTitle((quizArray[0][3] as! String), forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            
            //正解数を増やす
            correctAnswer++
        }
        
        //解いた問題をquizArrayから取り除く
        quizArray.removeAtIndex(0)
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
    
    //セグエが選ばれたときに呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destinationViewController as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


