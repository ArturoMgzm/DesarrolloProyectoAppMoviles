//
//  patientsView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 16/03/24.

import SwiftUI

@available(iOS 17, *)
struct ResultsView: View {
    
    var patient: Patient?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        ZStack{
            Color("Background")
                .ignoresSafeArea()
            VStack{
                HStack{
                    ZStack{
                        Color("Primary")
                            .ignoresSafeArea()
                        HStack(alignment: .center){
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
                        }
                    }
                }.frame(height:120)
                VStack(alignment: .leading, spacing: 0){
                    HStack(alignment: .center){
                        Spacer()
                        Text(patient!.name)
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                            .frame(alignment: .leading)
                        Spacer()
                    }.padding(.bottom,44)
                    ForEach(patient!.sessions, id: \.self){ session in
                        ForEach(session.results, id: \.self){ result in
                            VStack(alignment: .leading){
                                Divider()
                                    .background(Color("Primary"))
                                    .padding(.bottom,24)
                                HStack(spacing: 40){
                                    VStack(alignment: .leading, spacing: 11){
                                        Text(result.activity)
                                            .foregroundColor(Color("Primary"))
                                            .font(.system(size:36,weight: .bold))
                                            .frame(alignment: .leading)
                                            .multilineTextAlignment(.leading)
                                        Text(session.date)
                                            .foregroundColor(Color("Secondary"))
                                            .font(.system(size:27,weight: .bold))
                                            .frame(alignment: .leading)
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 11){
                                        HStack{
                                            Text("Aciertos:")
                                                .foregroundColor(Color("Primary"))
                                                .font(.system(size:32))
                                                .frame(alignment: .leading)
                                            Text(String(result.grade))
                                                .foregroundColor(Color("Secondary"))
                                                .font(.system(size:32, weight: .bold))
                                                .frame(alignment: .leading)
                                        }
                                        HStack{
                                            Text("Errores:")
                                                .foregroundColor(Color("Primary"))
                                                .font(.system(size:32))
                                                .frame(alignment: .leading)
                                            Text(String(result.errors))
                                                .foregroundColor(Color("Secondary"))
                                                .font(.system(size:32, weight: .bold))
                                                .frame(alignment: .leading)
                                        }
                                    }
                                    Spacer()
                                    VStack(alignment: .leading, spacing: 11){
                                        Text("Completado:")
                                            .foregroundColor(Color("Primary"))
                                            .font(.system(size:32))
                                            .frame(alignment: .leading)
                                        Text(result.completed ? "Si" : "No")
                                            .foregroundColor(Color("Secondary"))
                                            .font(.system(size:27,weight: .bold))
                                            .frame(alignment: .leading)
                                            .multilineTextAlignment(.leading)
                                    }
                                }
                                Divider()
                                    .background(Color("Primary"))
                                    .padding(.top,24)
                            }
                        }
                    }
                }.padding(24)
                Spacer()
                VStack{
                    Spacer()
                    Text("Actualizar Notas")
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
        }.onAppear{
            print(patient!.sessions)
        }
    }
}
