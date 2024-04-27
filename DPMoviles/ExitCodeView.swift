//
//  ExitCodeView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 19/04/24.
//

import SwiftUI

@available(iOS 17, *)
struct ExitCodeView: View {
    
    var session: Session?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var firstDigit: String = ""
    @State private var secondDigit: String = ""
    @State private var thirdDigit: String = ""
    @State private var fourthDigit: String = ""
    
    var path = NavigationPath()
        
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            VStack{
                HStack{
                    ZStack{
                        Color("Primary")
                            .ignoresSafeArea()
                        HStack{
                            Button{
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color("Background"))
                                    .font(.system(size:60))
                            }
                            Spacer()
                            Text("Lic. Avila Rdz")
                                .foregroundColor(.white)
                                .font(.system(size:48,weight: .bold))
                            Spacer()
                        }.padding(.horizontal,26)
                    }
                }.frame(height:120)
                VStack(alignment: .leading, spacing: 0){
                    HStack(alignment: .center){
                        Spacer()
                        Text("Codigo")
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                            .frame(alignment: .leading)
                        Spacer()
                    }.padding(.bottom,44)
                }.padding(53)
                Text("Reingresa tu codigo para poder avanzar:")
                    .foregroundColor(Color("Primary"))
                    .font(.system(size:42))
                    .frame(alignment: .leading)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 100)
                    .padding(.bottom, 101)
                HStack(spacing:53){
                    Group{
                        TextField("",text:$firstDigit)
                        TextField("",text:$secondDigit)
                        TextField("",text:$thirdDigit)
                        TextField("",text:$fourthDigit)
                    }   .frame(width: 128)
                        .padding(.all,24)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .foregroundColor(Color("Secondary"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color("Primary"),lineWidth:4)
                                )
                        )
                        .font(.system(size:85))
                        .multilineTextAlignment(.center)
                }.frame(maxWidth: .infinity)
                Spacer()
            }
                VStack{
                    Spacer()
                    if( firstDigit + secondDigit + thirdDigit + fourthDigit == session!.key){
                        NavigationLink{
                            PatientsView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
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
                            .opacity(0.3)
                    }
            }
        }
    }
}

@available(iOS 17, *)
struct ExitCodeView_Previews: PreviewProvider {
    static var previews: some View {
        ExitCodeView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
    }
}
