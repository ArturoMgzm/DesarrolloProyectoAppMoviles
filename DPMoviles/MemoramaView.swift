//
//  MemoramaView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 20/04/24.

import SwiftUI

struct memoramaPiece{
    var color: Color
    var active: Bool = false
    var completed: Bool = false
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        }
        else {
            self
        }
    }
}

@available(iOS 17, *)
struct MemoramaView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State var session: Session?
    
    @State var newResult: TestResult?
    
    @State var pendingPieces: Int = 16
    @State var activePieces: Int = 0

    @State var piece1: Int = 0
    @State var piece2: Int = 0
    
    @State var block: Bool = false
    
    @State var memoramaPieces = [
        memoramaPiece(color: Color.red),
        memoramaPiece(color: Color.red),

        memoramaPiece(color: Color.green),
        memoramaPiece(color: Color.green),

        memoramaPiece(color: Color.blue),
        memoramaPiece(color: Color.blue),

        memoramaPiece(color: Color.yellow),
        memoramaPiece(color: Color.yellow),

        memoramaPiece(color: Color.indigo),
        memoramaPiece(color: Color.indigo),

        memoramaPiece(color: Color.brown),
        memoramaPiece(color: Color.brown),

        memoramaPiece(color: Color.mint),
        memoramaPiece(color: Color.mint),

        memoramaPiece(color: Color.cyan),
        memoramaPiece(color: Color.cyan),

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
                        }
                        Spacer()
                        Text("Completa el memorama:")
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                        Spacer()
                    }.padding(.horizontal,26)
                }.frame(height:120)
                Grid(horizontalSpacing: 24, verticalSpacing: 24){
                    GridRow{
                        ForEach(0...3, id: \.self){ i in
                            Button{
                                if(!memoramaPieces[i].completed && !block){
                                    if(activePieces == 0){
                                        piece1 = i
                                        memoramaPieces[i].active = true
                                        activePieces+=1
                                    }
                                    else{
                                        if(piece1 != i){
                                            piece2 = i
                                            memoramaPieces[piece2].active = true
                                            block = true
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                if(memoramaPieces[piece1].color == memoramaPieces[piece2].color){
                                                    memoramaPieces[piece1].completed = true
                                                    memoramaPieces[piece1].active = false
                                                    
                                                    memoramaPieces[piece2].completed = true
                                                    memoramaPieces[piece2].active = false
                                                    pendingPieces -= 2
                                                    newResult?.grade += 1
                                                    if(pendingPieces == 0){
                                                        newResult?.completed = true
                                                        modelContext.insert(newResult!)
                                                        session?.results.append(newResult!)
                                                        dismiss()
                                                    }
                                                }
                                                else{
                                                    memoramaPieces[piece1].active = false
                                                    memoramaPieces[piece2].active = false
                                                    
                                                    newResult?.errors += 1
                                                    
                                                }
                                                block = false
                                                activePieces-=1
                                            }
                                        }
                                    }
                                    
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.white)
                                    .if(memoramaPieces[i].active){ view in
                                        view.fill(memoramaPieces[i].color)
                                    }
                                    .if(memoramaPieces[i].completed){ view in
                                        view.opacity(0.0)
                                    }
                                    .aspectRatio(1.0, contentMode: .fit)
                            }
                        }
                        
                    }
                    GridRow{
                        ForEach(4...7, id: \.self){ i in
                            Button{
                                if(!memoramaPieces[i].completed && !block){
                                    if(activePieces == 0){
                                        piece1 = i
                                        memoramaPieces[i].active = true
                                        activePieces+=1
                                    }
                                    else{
                                        if(piece1 != i){
                                            piece2 = i
                                            memoramaPieces[piece2].active = true
                                            block = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                if(memoramaPieces[piece1].color == memoramaPieces[piece2].color){
                                                    memoramaPieces[piece1].completed = true
                                                    memoramaPieces[piece1].active = false
                                                    
                                                    memoramaPieces[piece2].completed = true
                                                    memoramaPieces[piece2].active = false
                                                    pendingPieces -= 2
                                                    newResult?.grade += 1
                                                    if(pendingPieces == 0){
                                                        newResult?.completed = true
                                                        modelContext.insert(newResult!)
                                                        session?.results.append(newResult!)
                                                        dismiss()
                                                    }
                                                }
                                                else{
                                                    memoramaPieces[piece1].active = false
                                                    memoramaPieces[piece2].active = false
                                                    
                                                    newResult?.errors += 1
                                                    
                                                }
                                                block = false
                                                activePieces-=1
                                            }
                                        }
                                    }
                                    
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.white)
                                    .if(memoramaPieces[i].active){ view in
                                        view.fill(memoramaPieces[i].color)
                                    }
                                    .if(memoramaPieces[i].completed){ view in
                                        view.opacity(0.0)
                                    }
                                    .aspectRatio(1.0, contentMode: .fit)

                            }
                        }
                    }
                    GridRow{
                        ForEach(8...11, id: \.self){ i in
                            Button{
                                if(!memoramaPieces[i].completed && !block){
                                    if(activePieces == 0){
                                        piece1 = i
                                        memoramaPieces[i].active = true
                                        activePieces+=1
                                    }
                                    else{
                                        if(piece1 != i){
                                            piece2 = i
                                            memoramaPieces[piece2].active = true
                                            block = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                if(memoramaPieces[piece1].color == memoramaPieces[piece2].color){
                                                    memoramaPieces[piece1].completed = true
                                                    memoramaPieces[piece1].active = false
                                                    
                                                    memoramaPieces[piece2].completed = true
                                                    memoramaPieces[piece2].active = false
                                                    pendingPieces -= 2
                                                    newResult?.grade += 1
                                                    if(pendingPieces == 0){
                                                        newResult?.completed = true
                                                        modelContext.insert(newResult!)
                                                        session?.results.append(newResult!)
                                                        dismiss()
                                                    }
                                                }
                                                else{
                                                    memoramaPieces[piece1].active = false
                                                    memoramaPieces[piece2].active = false
                                                    
                                                    newResult?.errors += 1
                                                    
                                                }
                                                block = false
                                                activePieces-=1
                                            }
                                        }
                                    }
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.white)
                                    .if(memoramaPieces[i].active){ view in
                                        view.fill(memoramaPieces[i].color)
                                    }
                                    .if(memoramaPieces[i].completed){ view in
                                        view.opacity(0.0)
                                    }
                                    .aspectRatio(1.0, contentMode: .fit)

                            }
                        }
                    }
                    GridRow{
                        ForEach(12...15, id: \.self){ i in
                            Button{
                                if(!memoramaPieces[i].completed && !block){
                                    if(activePieces == 0){
                                        piece1 = i
                                        memoramaPieces[i].active = true
                                        activePieces+=1
                                    }
                                    else{
                                        if(piece1 != i){
                                            piece2 = i
                                            memoramaPieces[piece2].active = true
                                            block = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                                if(memoramaPieces[piece1].color == memoramaPieces[piece2].color){
                                                    memoramaPieces[piece1].completed = true
                                                    memoramaPieces[piece1].active = false
                                                    
                                                    memoramaPieces[piece2].completed = true
                                                    memoramaPieces[piece2].active = false
                                                    pendingPieces -= 2
                                                    newResult?.grade += 1
                                                    if(pendingPieces == 0){
                                                        newResult?.completed = true
                                                        modelContext.insert(newResult!)
                                                        session?.results.append(newResult!)
                                                        dismiss()
                                                    }
                                                }
                                                else{
                                                    memoramaPieces[piece1].active = false
                                                    memoramaPieces[piece2].active = false
                                                    
                                                    newResult?.errors += 1
                                                    
                                                }
                                                block = false
                                                activePieces-=1
                                            }
                                        }
                                    }
                                    
                                }
                            } label: {
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .fill(Color.white)
                                    .if(memoramaPieces[i].active){ view in
                                        view.fill(memoramaPieces[i].color)
                                    }
                                    .if(memoramaPieces[i].completed){ view in
                                        view.opacity(0.0)
                                    }
                                    .aspectRatio(1.0, contentMode: .fit)
                            }
                        }
                    }
                }.padding(.all, 24)
                Spacer()
            }
        }.onAppear{
            newResult = TestResult(activity: "Memorama",completed: false, grade: 0, time: "", errors: 0, session: session!)
            memoramaPieces.shuffle()
        }
    }
}
