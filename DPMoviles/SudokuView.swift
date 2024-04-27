//
//  SudokuView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 26/04/24.

//Para la logica relacionada a la creacion y resolucion de sudokus me apoye de la herramienta de ChatGPT
//Sin embargo el codigo ha sido modificado ampleamente con mi propio intelecto para satisfacer los requerimientos de la interfaz deseada y el formato de resultado deseado

import SwiftUI

@available(iOS 17, *)
struct SudokuView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State var session: Session?
    @State var newResult: TestResult?

    @State private var puzzle: [[Int]] = [
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9],
        [-1,-2,-3,-4,-5,-6,-7,-8,-9]
    ]
    
    @State private var display: [[(Int, Bool)]] = [
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
        [(-1,true),(-2,true),(-3,true),(-4,true),(-5,true),(-6,true),(-7,true),(-8,true),(-9,true)],
    ]
    
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            VStack{
                HStack{
                    HStack{
                        Button{
                            modelContext.insert(newResult!)
                            session?.results.append(newResult!)
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color("Highlight"))
                                .font(.system(size:60))
                        }.padding(.leading,100)
                        Spacer()
                        Text("Completa el sudoku:")
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                            .padding(.leading,-100)
                        Spacer()
                    }.padding(.horizontal,26)
                }.frame(height:120)
                VStack {
                    Grid(horizontalSpacing: 12, verticalSpacing: 12){
                        ForEach(0..<9) { row in
                            GridRow{
                                ForEach(0..<9) { column in
                                    if(display[row][column].1){
                                        TextField("", value:$display[row][column].0, formatter: NumberFormatter())
                                            .multilineTextAlignment(.center)
                                            .background(
                                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                                    .foregroundColor(Color("Secondary"))
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 24)
                                                            .stroke(Color("Primary"),lineWidth:4)
                                                    )
                                                    .aspectRatio(1.0, contentMode: .fit)
                                            )
                                            .font(.system(size:60))
                                            .onChange(of:display[row][column].0){
                                                newResult?.errors += 1
                                                if(display[row][column].0 > 9){
                                                    display[row][column].0 = display[row][column].0 % 10
                                                }
                                                puzzle[row][column] = display[row][column].0
                                                if(isSudokuSolved(puzzle)){
                                                    newResult?.grade = newResult!.errors - 15
                                                    newResult?.completed = true
                                                    modelContext.insert(newResult!)
                                                    session?.results.append(newResult!)
                                                    dismiss()
                                                }
                                            }
                                    }
                                    else{
                                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color("Primary"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color("Secondary"),lineWidth:4)
                                                    .overlay(
                                                        Text(self.cellText(row: row, column: column))
                                                            .font(.system(size:60))
                                                            .foregroundColor(Color.white)
                                                    )
                                            )
                                            .aspectRatio(1.0, contentMode: .fit)
                                    }
                                    if(column == 2 || column == 5){
                                        Rectangle()
                                            .fill(Color("Primary"))
                                            .frame(width: 10, height: .infinity)
                                            .padding(.vertical,-12)
                                    }
                                }
                                
                            }
                            if(row == 2 || row == 5){
                                Rectangle()
                                    .fill(Color("Primary"))
                                    .frame(width: .infinity, height: 10)
                            }
                        }
                    }.padding(.all, 100)
                }.onAppear{
                    newResult = TestResult(activity: "Sudoku",completed: false, grade: 0, time: "", errors: 0, session: session!)
                    generateNewPuzzle()
                }
                Spacer()
            }
        }
    }
    
    private func cellText(row: Int, column: Int) -> String {
        return "\(puzzle[row][column])"
    }
    
    private func generateNewPuzzle() {
        // Initialize an empty 9x9 grid
        var grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        
        // Generate a valid Sudoku puzzle using backtracking
        if solveSudoku(&grid) {
            // Randomly remove some numbers to create a puzzle
            removeNumbers(&grid)
            
            // Update the puzzle state
            puzzle = grid
            
            for row in 0..<9 {
                for col in 0..<9 {
                    if(puzzle[row][col] == 0){
                        display[row][col].0 = 0
                        display[row][col].1 = true
                    }
                    else{
                        display[row][col].0 = puzzle[row][col]
                        display[row][col].1 = false
                    }
                }
            }
            
        } else {
            // Failed to generate a puzzle
            print("Failed to generate a Sudoku puzzle.")
        }
    }

    private func solveSudoku(_ grid: inout [[Int]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    for num in 1...9 {
                        if isSafe(grid, row, col, num) {
                            grid[row][col] = num
                            
                            if solveSudoku(&grid) {
                                return true
                            } else {
                                grid[row][col] = 0
                            }
                        }
                    }
                    return false
                }
            }
        }
        return true
    }

    private func isSafe(_ grid: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        // Check if the number is already present in the current row, column, or 3x3 subgrid
        return !usedInRow(grid, row, num) &&
               !usedInCol(grid, col, num) &&
               !usedInBox(grid, row - row % 3, col - col % 3, num)
    }

    private func usedInRow(_ grid: [[Int]], _ row: Int, _ num: Int) -> Bool {
        return grid[row].contains(num)
    }

    private func usedInCol(_ grid: [[Int]], _ col: Int, _ num: Int) -> Bool {
        for row in 0..<9 {
            if grid[row][col] == num {
                return true
            }
        }
        return false
    }

    private func usedInBox(_ grid: [[Int]], _ startRow: Int, _ startCol: Int, _ num: Int) -> Bool {
        for row in 0..<3 {
            for col in 0..<3 {
                if grid[row + startRow][col + startCol] == num {
                    return true
                }
            }
        }
        return false
    }
    
    func isSudokuSolved(_ grid: [[Int]]) -> Bool {
        // Check if there are any empty cells
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    return false
                }
            }
        }
        
        // Check rows and columns for duplicates
        for i in 0..<9 {
            var rowSet = Set<Int>()
            var colSet = Set<Int>()
            for j in 0..<9 {
                // Check rows
                if rowSet.contains(grid[i][j]) {
                    return false
                }
                rowSet.insert(grid[i][j])
                
                // Check columns
                if colSet.contains(grid[j][i]) {
                    return false
                }
                colSet.insert(grid[j][i])
            }
        }
        
        // Check 3x3 subgrids for duplicates
        for row in stride(from: 0, to: 9, by: 3) {
            for col in stride(from: 0, to: 9, by: 3) {
                var subgridSet = Set<Int>()
                for i in row..<(row + 3) {
                    for j in col..<(col + 3) {
                        if subgridSet.contains(grid[i][j]) {
                            return false
                        }
                        subgridSet.insert(grid[i][j])
                    }
                }
            }
        }
        
        return true
    }

    private func removeNumbers(_ grid: inout [[Int]]) {
        // Randomly remove some numbers to create a puzzle
        let numberOfCellsToRemove = Int.random(in: 16..<17) // Adjust as needed
        
        for _ in 0..<numberOfCellsToRemove {
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            grid[row][col] = 0
        }
    }
}
