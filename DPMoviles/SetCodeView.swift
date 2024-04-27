//
//  SetCodeView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 16/03/24.

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content{
        build()
    }
}

@available(iOS 17, *)
struct SetCodeView: View {
    
    var patient: Patient?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var firstDigit: String = ""
    @State private var secondDigit: String = ""
    @State private var thirdDigit: String = ""
    @State private var fourthDigit: String = ""
    
    @State private var isExiting: Bool = false
    
    @State var newSession: Session?

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
                Text("Escribe el codigo que usaras para poder salir de la seccion de actividades")
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
                    NavigationLink(destination:
                        NavigationLazyView(ActivityView(
                            session: newSession!
                        )).navigationBarBackButtonHidden(true),
                        isActive: $isExiting,
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
                ).onChange(of: isExiting) { oldValue, newValue in
                    if newValue{
                        newSession!.key = firstDigit + secondDigit + thirdDigit + fourthDigit
                        patient?.lastVisit = newSession!.date
                        modelContext.insert(newSession!)
                        patient?.sessions.append(newSession!)
                    }
                }
            }
        }.onAppear{
            newSession = Session(date: String(Date.now.formatted(date: .abbreviated, time: .omitted)), key: "", patient: self.patient, results: [])
        }
    }
}

@available(iOS 17, *)
struct SetCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SetCodeView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
    }
}
