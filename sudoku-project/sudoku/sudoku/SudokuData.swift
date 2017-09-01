//
//  sudoku.swift
//  sudoku
//
//  Created by Lin, Alan on 5/22/17.
//  Copyright © 2017 Lin, Alan. All rights reserved.
//

import Foundation
import UIKit

class SudokuData{
    static let shared: SudokuData = SudokuData()
    
    //        let sudoku: [[Int]] = [
    //            [0, 1, 2,  0, 4, 5,  0, 7, 8],
    //            [9, 10, 11,  12, 13, 14,  15, 16, 17],
    //            [18, 19, 20,  21, 22, 23,  24, 25, 26],
    //
    //            [0, 28, 29,  0, 31, 32,  0, 34, 35],
    //            [36, 37, 38,  39, 40, 41,  42, 43, 44],
    //            [45, 46, 47,  48, 49, 50,  51, 52, 53],
    //
    //            [0, 55, 56,  0, 58, 59,  0, 61, 62],
    //            [63, 64, 65,  66, 67, 68,  69, 70, 71],
    //            [72, 73, 74,  75, 76, 77,  78, 79, 80],
    //            ]

    let sudoku: [[Int]] = [
        [5, 3, 0,  0, 7, 0,  0, 0, 0],
        [6, 0, 0,  1, 9, 5,  0, 0, 0],
        [0, 9, 8,  0, 0, 0,  0, 6, 0],
        
        [8, 0, 0,  0, 6, 0,  0, 0, 3],
        [4, 0, 0,  8, 0, 3,  0, 0, 1],
        [7, 0, 0,  0, 2, 0,  0, 0, 6],
        
        [0, 6, 0,  0, 0, 0,  2, 8, 0],
        [0, 0, 0,  4, 1, 9,  0, 0, 5],
        [0, 0, 0,  0, 8, 0,  0, 7, 0],
        ]
    let sudokuSolver: [[Int]] = [
        [5, 3, 4,  6, 7, 8,  9, 1, 2],
        [6, 7, 2,  1, 9, 5,  3, 4, 8],
        [1, 9, 8,  3, 4, 2,  5, 6, 7],
        
        [8, 5, 9,  7, 6, 1,  4, 2, 3],
        [4, 2, 6,  8, 5, 3,  7, 9, 1],
        [7, 1, 3,  9, 2, 4,  8, 5, 6],
        
        [9, 6, 1,  5, 3, 7,  2, 8, 4],
        [2, 8, 7,  4, 1, 9,  6, 3, 5],
        [3, 4, 5,  2, 8, 6,  1, 7, 9],
        ]
    var tmpSudoku = Array(repeating: Array(repeating: 0, count: 9 ), count: 9)
    
}

