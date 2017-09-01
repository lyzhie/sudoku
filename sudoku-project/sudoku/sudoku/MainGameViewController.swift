//
//  ViewController.swift
//  sudoku
//
//  Created by Lin, Alan on 5/1/17.
//  Copyright © 2017 Lin, Alan. All rights reserved.
//

import UIKit

class MainGameViewController: UIViewController {
    
    let sudoku = SudokuData.shared.sudoku
    let sudokuSolver = SudokuData.shared.sudokuSolver
    var tmpSudoku = SudokuData.shared.sudoku
    //SudokuData.shared.tmpSudoku
    
    var selectedButton: UIButton?
    var buttonStatus: [Bool] = [] //cell can be modified
    var lastButton: [UIButton] = []
    var lastButtonNum: [Int] = []
    let buttonBefore: [UIColor] = [UIColor(red: 203/255, green: 219/255, blue:185/255, alpha: 0.0), UIColor(red: 156/255, green: 179/255, blue:82/255, alpha: 1.0)]
    let buttonAfter: [UIColor] = [UIColor(red: 203/255, green: 219/255, blue:185/255, alpha: 1.0), UIColor(red: 119/255, green: 153/255, blue:71/255, alpha: 1.0)]
    let selectedBtnColor: UIColor = UIColor(red: 156/255, green: 179/255, blue:82/255, alpha: 0.13)
    let defaultBtnColor: UIColor = UIColor(red: 93/255, green: 145/255, blue:174/255, alpha: 1.0)
    var recordWrongNum: [Bool] = [] //record cells that are against to sudoku rule

    let startTime = Date()
    

    
    
    
    // tap cell
    @IBAction func tapCell(_ sender: UIButton) {
        selectedButton = nil

        let button = sender
        
        for key in 0...80 {
            let cell = self.view.viewWithTag(key+1) as? UIButton
            cell?.backgroundColor = buttonBefore[0]
            cell?.layer.borderColor = buttonBefore[1].cgColor
        }
        
        let key = button.tag-1
        print(key)

        if buttonStatus[key] == true{
            selectedButton = sender
            
            let sectionRow = key / 9 / 3
            let sectionCol = key % 9 / 3

            for i in 0...2 {
                for j in 0...2 {
                    let tmpKey = (i+sectionRow*3)*9+(j+sectionCol*3)
                    let cell = self.view.viewWithTag(tmpKey+1) as? UIButton
                    cell?.backgroundColor = selectedBtnColor
                }
            }
            let row = key / 9
            let col = key % 9
            
            for i in 0...8 {
                let tmpKeyX = row*9 + i
                let tmpkeyY = i*9 + col
                let cellX = self.view.viewWithTag(tmpKeyX+1) as? UIButton
                let cellY = self.view.viewWithTag(tmpkeyY+1) as? UIButton
                cellX?.backgroundColor = selectedBtnColor
                cellY?.backgroundColor = selectedBtnColor
            }
            
            selectedButton?.backgroundColor = buttonAfter[0]
            selectedButton?.layer.borderColor = buttonAfter[1].cgColor
            
        }
        
    }

    func arr2sudoku(_ toSudoku:[[Int]])  {
        for key in 0...80 {
            let row = key / 9
            let col = key % 9
            let cell = self.view.viewWithTag(key+1) as? UIButton
            
            if toSudoku[row][col] != 0 {
                cell?.setTitle("\(toSudoku[row][col])", for: .normal)
                buttonStatus.append(false)
                recordWrongNum.append(true)
                buttonStatusStyle(key,UIFontWeightSemibold)
            } else {
                buttonStatus.append(true)
                recordWrongNum.append(true)
                buttonStatusStyle(key,UIFontWeightSemibold)
            }
            
        }
    }
    
    func sudoku2arr()  -> [[Int]] {
        var tmpSudoku = Array(repeating: Array(repeating: 0, count: 9 ), count: 9)
        for key in 0...80 {
            let row = key / 9
            let col = key % 9
            let cell = self.view.viewWithTag(key+1) as? UIButton
            
            tmpSudoku[row][col] = Int((cell?.currentTitle) ?? "0") ?? 0
        }
        SudokuData.shared.tmpSudoku = tmpSudoku
        return tmpSudoku
        
    }
    
// handle wrong num
    func wrongNum(_ tmpNum: Int, _ tmpNum2: Int, _ cell: UIButton, _ cell2: UIButton)  {
        
        if tmpNum == tmpNum2{
            recordWrongNum[cell.tag-1] = false
            recordWrongNum[cell2.tag-1] = false
        }
        switchBtnColor()
    }
    
// normal or wrong num style
    func switchBtnColor()  {
        let wrongBtnColor: UIColor = UIColor(red: 211/255, green: 94/255, blue:57/255, alpha: 1.0)
        for key in 0...80 {
            let cell = self.view.viewWithTag(key+1) as? UIButton
            if recordWrongNum[key] {
                if buttonStatus[key]{
                    cell?.setTitleColor(defaultBtnColor, for: .normal)
                } else{
                    cell?.isUserInteractionEnabled = false
                    cell?.setTitleColor(UIColor(red: 92/255, green: 191/255, blue:181/255, alpha: 1.0), for: .normal)
                }
            } else {
                cell?.setTitleColor(wrongBtnColor, for: .normal)

            }
        }
        
    }
    
//    record last btn & finish
    func recordLast() {
        if selectedButton != nil {
            lastButton.append(selectedButton!)
            lastButtonNum.append(Int((selectedButton!.currentTitle)!) ?? 0)
        }
        finishSudoku()
    }
    
    func finishSudoku()  {
        let mySudoku = sudoku2arr()
        var correctNum = 0
        for i in 0...8{
            for j in 0...8{
                if mySudoku[i][j] == sudokuSolver[i][j] {
                    correctNum = correctNum + 1
                }
            }
        }
        if correctNum == 81 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "FinishedViewController")
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func tmpFinish(_ sender: UIButton) {
        var mySudokuSolver = sudokuSolver
        mySudokuSolver[8][8] = 0
        arr2sudoku(mySudokuSolver)
    }
    
// check num
    func highlightWrongNumber() {
        
        //reset record
        for key in 0...80{
            recordWrongNum[key] = true
        }
        //check row
        for i in 0...8{
            for j in 0..<8{
                let tmpKey = i*9 + j
                let cell = self.view.viewWithTag(tmpKey+1) as? UIButton
                let tmpNum = Int((cell?.currentTitle) ?? "0") ?? 0
                if tmpNum != 0 {
                    for k in 1...(8-j){
                        let cell2 = self.view.viewWithTag(tmpKey+1+k) as? UIButton
                        let tmpNum2 = Int((cell2?.currentTitle) ?? "0") ?? 0
                        if tmpNum2 > 0{
                            wrongNum(tmpNum, tmpNum2, cell!, cell2!)
                        }
                    }
                }
            }
        }
        //check col
        for i in 0...8{
            for j in 0..<8{
                let tmpKey = i + j*9
                let cell = self.view.viewWithTag(tmpKey+1) as? UIButton
                let tmpNum = Int((cell?.currentTitle) ?? "0") ?? 0
                if tmpNum != 0 {
                    for k in 1...(8-j){
                        let cell2 = self.view.viewWithTag(tmpKey+1+k*9) as? UIButton
                        let tmpNum2 = Int((cell2?.currentTitle) ?? "0") ?? 0
                        if tmpNum2 > 0{
                            wrongNum(tmpNum, tmpNum2, cell!, cell2!)
                        }
                    }
                }
            }
        }
        //check 9 cells
        for a in 0...2{
            for b in 0...2{
                var tmpNumArr: [Int] = []
                for i in 0...2{
                    for j in 0...2{
                        let tmpKey = (i + a*3)*9 + (j + b*3)
                        tmpNumArr.append(tmpKey)
                    }
                }
                
                for m in 0..<8{
                    let cell = self.view.viewWithTag(tmpNumArr[m]+1) as? UIButton
                    let tmpNum = Int((cell?.currentTitle) ?? "0") ?? 0
                    if tmpNum != 0 {
                        for n in (m+1)...8{
                            let cell2 = self.view.viewWithTag(tmpNumArr[n]+1) as? UIButton
                            let tmpNum2 = Int((cell2?.currentTitle) ?? "0") ?? 0
                            if tmpNum2 > 0{
                                wrongNum(tmpNum, tmpNum2, cell!, cell2!)
                            }
                        }
                    }
                }
                
            }
        }

    }
    
//    Undo
    @IBAction func tapUndo(_ sender: UIButton) {
        if !self.lastButton.isEmpty {
            
            let lastBtn = self.lastButton.removeLast()
            self.lastButtonNum.removeLast()
            
            let previousBtn = self.lastButton.last
            let previousBtnNum = self.lastButtonNum.last

            
            
            if previousBtn != nil{
                lastBtn.setTitle(nil, for: .normal)
                if previousBtnNum! > 0{
                    previousBtn!.setTitle(String(previousBtnNum!), for: .normal)
                } else {
                    previousBtn!.setTitle(nil, for: .normal)
                }
            } else {
                lastBtn.setTitle(nil,for: .normal)
            }
            highlightWrongNumber()
        }
        
        
    }

//back button
    @IBAction func tapBack(_ sender: UIButton) {
        
    }

    
    @IBAction func tapOne(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("1", for: .normal)
            highlightWrongNumber()
            recordLast()
            
        }
    }
    @IBAction func tapTwo(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("2", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapThree(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("3", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapFour(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("4", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapFive(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("5", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapSix(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("6", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }

    @IBAction func tapSeven(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("7", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapEight(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("8", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapNine(_ sender: UIButton) {
        if selectedButton != nil {
            selectedButton?.setTitle("9", for: .normal)
            highlightWrongNumber()
            recordLast()
        }
    }
    @IBAction func tapDel(_ sender: UIButton) {
        if selectedButton != nil && selectedButton?.currentTitle != nil{
            selectedButton?.setTitle(nil, for: .normal)
            highlightWrongNumber()
            recordLast()
           
        }
    }
    
    
    func buttonStatusStyle(_ i: Int, _ fontWeight: CGFloat = UIFontWeightRegular) {
        let button = self.view.viewWithTag(i+1) as? UIButton
        button?.titleLabel?.font = UIFont.systemFont(ofSize: 25.0, weight: fontWeight)
        if buttonStatus[i] == true {
            button?.setTitleColor(defaultBtnColor, for: .normal)
        } else {
            button?.isUserInteractionEnabled = false
            button?.setTitleColor(UIColor(red: 92/255, green: 191/255, blue:181/255, alpha: 1.0), for: .normal)
        }
    }
    //timer
    @IBOutlet weak var currentTime: UILabel!
    
    var timer = Timer()
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function **Countdown** with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    func updateCounting() {
        let startTime = self.startTime
        let startTimeInterval = startTime.timeIntervalSince1970
        let myStartTimeInt = Int(startTimeInterval)
        
        let endTime = Date()
        let endTimeInterval = endTime.timeIntervalSince1970
        let myEndTimeInt = Int(endTimeInterval)
        
        let myTimer = myEndTimeInt - myStartTimeInt
        let myTimeInterval = Double(myTimer)
        let myDate = Date(timeIntervalSince1970: myTimeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        dateFormatter.dateFormat = "HH:mm:ss"
        let timeWithFormatter = dateFormatter.string(from: myDate as Date)

        currentTime?.text = "Hard \(timeWithFormatter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scheduledTimerWithTimeInterval()
        arr2sudoku(tmpSudoku)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

