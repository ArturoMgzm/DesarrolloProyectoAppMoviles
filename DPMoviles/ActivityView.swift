import SwiftUI

@available(iOS 17, *)
struct ActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var session: Session?

    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            VStack{
                HStack{
                    HStack{
                        NavigationLink{
                            ExitCodeView(session: session)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color("Highlight"))
                                .font(.system(size:60))
                        }
                        Spacer()
                        Text("Selecciona la actividad:")
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                        Spacer()
                    }.padding(.horizontal,26)
                }.frame(height:120)
                VStack(alignment: .leading, spacing: 70){
                    if(session!.results.contains(where: {$0.activity == "Memorama"} )){
                        Text("Memorama")
                            .font(.system(size:86,weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight:.infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color("Secondary"))
                                    .frame(maxWidth: .infinity)
                            )
                    }
                    else{
                        NavigationLink{
                            MemoramaView(session: session!)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Memorama")
                                .font(.system(size:86,weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color("Primary"))
                                        .frame(maxWidth: .infinity)
                                )
                        }
                    }
                    if(session!.results.contains(where: {$0.activity == "Sudoku"} )){
                        Text("Sudoku")
                            .font(.system(size:86,weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight:.infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color("Secondary"))
                                    .frame(maxWidth: .infinity)
                            )
                    }
                    else{
                        NavigationLink{
                            SudokuView(session: session!)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Sudoku")
                                .font(.system(size:86,weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color("Primary"))
                                        .frame(maxWidth: .infinity)
                                )
                        }
                    }
                    if(session!.results.contains(where: {$0.activity == "Agrupacion"} )){
                        Text("Agrupacion")
                            .font(.system(size:86,weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, maxHeight:.infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color("Secondary"))
                                    .frame(maxWidth: .infinity)
                            )
                    }
                    else{
                        NavigationLink{
                            AsociationActivityView(session: session!)
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Agrupacion")
                                .font(.system(size:86,weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight:.infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color("Primary"))
                                        .frame(maxWidth: .infinity)
                                )
                        }
                    }
                }.padding(53)
                Spacer()
            }
        }
    }
}
