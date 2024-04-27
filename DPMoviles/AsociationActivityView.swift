//
//  AsociationActivityView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 20/04/24.
//

import SwiftUI

@available(iOS 17, *)
struct AsociationActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var session: Session?
    
    @State var newResult: TestResult?
    
    @State var guessing: Bool = false
    
    @State var memory: [Color] = [Color.red, Color.green, Color.blue]

    @State var option1: [Color] = [Color.indigo, Color.orange, Color.gray]
    @State var option2: [Color] = [Color.purple, Color.teal, Color.brown]
    @State var option3: [Color] = [Color.mint, Color.pink, Color.yellow]
    
    @State var currentSelection: [Color] = [Color.white, Color.white, Color.white]
    @State var selected: [Bool] = [false, false, false]

    
    @State var results: [Int] = [Int.random(in: 0..<3),Int.random(in: 0..<3),Int.random(in: 0..<3)]
    
    @State var currentGuess: Int = 0


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
                        }
                        Spacer()
                        Text("Recuerda los pares:")
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                        Spacer()
                    }.padding(.horizontal,26)
                }.frame(height:120)
                if(!guessing){
                    Grid(horizontalSpacing: 24, verticalSpacing: 24){
                        GridRow{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(memory[0])
                                .aspectRatio(1.0, contentMode: .fit)
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(option1[results[0]])
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                        GridRow{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(memory[1])
                                .aspectRatio(1.0, contentMode: .fit)
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(option2[results[1]])
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                        GridRow{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(memory[2])
                                .aspectRatio(1.0, contentMode: .fit)
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(option3[results[2]])
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                    }.padding(.all, 24)
                    Button{
                        currentSelection = option1
                        guessing = true
                    }
                    label: {
                        Text("Avanzar")
                            .foregroundColor(Color("Background"))
                            .multilineTextAlignment(.center)
                            .font(.system(size:48,weight: .bold))
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color("Highlight"))
                                    .padding(.vertical,-38)
                                    .padding(.horizontal,-58)
                            )
                            .frame(height: 120)
                    }
                }
                else{
                    Grid(horizontalSpacing: 24, verticalSpacing: 24){
                        GridRow{
                            Spacer()
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(memory[currentGuess])
                                .aspectRatio(1.0, contentMode: .fit)
                            Spacer()

                        }
                        Spacer()
                        GridRow{
                            Button{
                                if(!selected[0]){
                                    if(results[currentGuess] == 0){
                                        newResult?.grade += 1
                                        selected = [false,false,false]
                                        if(currentGuess == 0){
                                            currentSelection = option2
                                            currentGuess += 1
                                        }
                                        else if(currentGuess == 1){
                                            currentSelection = option3
                                            currentGuess += 1
                                        }
                                        else{
                                            newResult?.completed = true
                                            modelContext.insert(newResult!)
                                            session?.results.append(newResult!)
                                            dismiss()
                                        }
                                    }
                                    else{
                                        newResult?.errors += 1
                                        selected[0] = true
                                    }
                                }
                            }
                        label:{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(currentSelection[0])
                                .aspectRatio(1.0, contentMode: .fit)
                                .if(selected[0]){ view in
                                    view.opacity(0.0)
                                }
                            }
                            Button{
                                if(!selected[1]){
                                    if(results[currentGuess] == 1){
                                        newResult?.grade += 1
                                        selected = [false,false,false]
                                        if(currentGuess == 0){
                                            currentSelection = option2
                                            currentGuess += 1
                                        }
                                        else if(currentGuess == 1){
                                            currentSelection = option3
                                            currentGuess += 1
                                        }
                                        else{
                                            newResult?.completed = true
                                            modelContext.insert(newResult!)
                                            session?.results.append(newResult!)
                                            dismiss()
                                        }

                                    }
                                    else{
                                        newResult?.errors += 1
                                        selected[1] = true
                                    }
                                }
                            }
                        label:{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(currentSelection[1])
                                .aspectRatio(1.0, contentMode: .fit)
                                .if(selected[1]){ view in
                                    view.opacity(0.0)
                                }
                            }
                            Button{
                                if(!selected[2]){
                                    if(results[currentGuess] == 2){
                                        newResult?.grade += 1
                                        selected = [false,false,false]
                                        if(currentGuess == 0){
                                            currentSelection = option2
                                            currentGuess += 1
                                        }
                                        else if(currentGuess == 1){
                                            currentSelection = option3
                                            currentGuess += 1
                                        }
                                        else{
                                            newResult?.completed = true
                                            modelContext.insert(newResult!)
                                            session?.results.append(newResult!)
                                            dismiss()
                                        }
                                    }
                                    else{
                                        newResult?.errors += 1
                                        selected[2] = true
                                    }
                                }
                            }
                        label:{
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                .fill(currentSelection[2])
                                .aspectRatio(1.0, contentMode: .fit)
                                .if(selected[2]){ view in
                                    view.opacity(0.0)
                                }
                            }
                        }
                    }.padding(.all, 24)
                }
                Spacer()
            }
        }.onAppear{
            newResult = TestResult(activity: "Agrupacion",completed: false, grade: 0, time: "", errors: 0, session: session!)
            memory.shuffle()
            option1.shuffle()
            option2.shuffle()
            option3.shuffle()

        }
    }
}
