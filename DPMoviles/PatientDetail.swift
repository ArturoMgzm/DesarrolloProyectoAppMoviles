//
//  patientsView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 16/03/24.

import SwiftUI

@available(iOS 17, *)
struct PatientDetailView: View {
    
    @State var isEditing: Bool = false
    
    @State var isNewPatient: Bool = false

    @State var patient: Patient = Patient(name: "", gender: "", hand: "", diagnostic: "", age: 0, lastVisit: "", sessions: [])
    
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
                            NavigationLink{
                                ResultsView(patient: patient)
                                    .navigationBarBackButtonHidden(true)
                            } label: {
                                Image(systemName: "doc.text")
                                    .foregroundColor(Color("Background"))
                                    .font(.system(size:60))
                                    .padding(.trailing,40)
                            }
                            if isEditing{
                                Button{
                                    if(isNewPatient){
                                        modelContext.insert(patient)
                                        isNewPatient = false
                                    }
                                    isEditing = false
                                } label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(Color("Background"))
                                        .font(.system(size:60))
                                }
                            }
                            else{
                                Button{
                                    isEditing = true
                                } label: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(Color("Background"))
                                        .font(.system(size:60))
                                }
                            }
                            
                        }.padding(.horizontal,24)
                    }
                }.frame(height:120)
                VStack(spacing: 0){
                    if isEditing {
                        TextField("Nombre del paciente...", text: $patient.name)
                            .padding(.all,24)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .foregroundColor(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 24)
                                            .stroke(Color("Primary"),lineWidth:4)
                                    )
                            )
                            .foregroundColor(Color("Secondary"))
                            .font(.system(size:64))
                            .multilineTextAlignment(.center)
                    }
                    else {
                        Text(patient.name ?? "Name")
                            .foregroundColor(Color("Highlight"))
                            .font(.system(size:64,weight: .bold))
                            .frame(width:.infinity,alignment: .center)
                            .padding(.bottom,44)
                    }
                    HStack{
                        VStack{
                            Text("Sexo:")
                                .foregroundColor(Color("Primary"))
                                .font(.system(size:48,weight: .bold))
                                .frame(alignment: .leading)
                            if isEditing {
                                TextField("", text: $patient.gender)
                                    .padding(.all,24)
                                    .frame(width:150)
                                    .keyboardType(.decimalPad)
                                    .background(
                                        RoundedRectangle(cornerRadius: 24)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color("Primary"),lineWidth:4)
                                            )
                                    )
                                    .foregroundColor(Color("Secondary"))
                                    .font(.system(size:48))
                                    .multilineTextAlignment(.center)
                            }
                            else {
                                Text(patient.gender ?? "Indeterminado")
                                    .foregroundColor(Color("Secondary"))
                                    .font(.system(size:48,weight: .bold))
                                    .frame(alignment: .leading)
                            }
                        }
                        Spacer()
                        VStack{
                            Text("Edad:")
                                .foregroundColor(Color("Primary"))
                                .font(.system(size:48,weight: .bold))
                                .frame(alignment: .leading)
                            if isEditing {
                                TextField("", value: $patient.age, formatter: NumberFormatter())
                                    .padding(.all,24)
                                    .frame(width:150)
                                    .keyboardType(.decimalPad)
                                    .background(
                                        RoundedRectangle(cornerRadius: 24)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color("Primary"),lineWidth:4)
                                            )
                                    )
                                    .foregroundColor(Color("Secondary"))
                                    .font(.system(size:48))
                                    .multilineTextAlignment(.center)
                            }
                            else {
                                Text(String(patient.age ?? 99))
                                    .foregroundColor(Color("Secondary"))
                                    .font(.system(size:48,weight: .bold))
                                    .frame(alignment: .leading)
                            }
                        }
                        Spacer()
                        VStack{
                            Text("Mano Dominante:")
                                .foregroundColor(Color("Primary"))
                                .font(.system(size:48,weight: .bold))
                                .frame(alignment: .leading)
                            if isEditing {
                                TextField("", text: $patient.hand)
                                    .padding(.all,24)
                                    .frame(width:350)
                                    .keyboardType(.decimalPad)
                                    .background(
                                        RoundedRectangle(cornerRadius: 24)
                                            .foregroundColor(Color.white)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color("Primary"),lineWidth:4)
                                            )
                                    )
                                    .foregroundColor(Color("Secondary"))
                                    .font(.system(size:48))
                                    .multilineTextAlignment(.center)
                            }
                            else {
                                Text(patient.hand ?? "Ambidiestro")
                                    .foregroundColor(Color("Secondary"))
                                    .font(.system(size:48,weight: .bold))
                                    .frame(alignment: .leading)
                            }
                        }
                    }.padding(.bottom,24)
                    VStack{
                        HStack{
                            Text("Notas:")
                                .foregroundColor(Color("Primary"))
                                .font(.system(size:48,weight: .bold))
                                .frame(alignment: .leading)
                            Spacer()
                        }.padding(.bottom,2)
                        if isEditing {
                            TextField("Escribe las notas aqui...", text: $patient.diagnostic, axis: .vertical)
                                .padding(.all,24)
                                .frame(height: .infinity)
                                .keyboardType(.decimalPad)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .foregroundColor(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 24)
                                                .stroke(Color("Primary"),lineWidth:4)
                                        )
                                )
                                .foregroundColor(Color("Secondary"))
                                .font(.system(size:48))
                                .multilineTextAlignment(.center)
                        }
                        else {
                            GeometryReader { proxy in
                                ScrollView{
                                    Text(patient.diagnostic ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                                        .foregroundColor(Color("Primary"))
                                        .font(.system(size:42))
                                        .frame(minHeight: proxy.size.height, alignment: .leading)
                                }
                            }
                        }
                    }
                }
                .padding(.all,24)
                Spacer()
                if(!isEditing){
                    NavigationLink{
                        SetCodeView(
                            patient: patient
                        ).navigationBarBackButtonHidden(true)
                    } label: {
                        Text("Iniciar\nActividades")
                            .foregroundColor(Color("Background"))
                            .multilineTextAlignment(.center)
                            .font(.system(size:48,weight: .bold))
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color("Highlight"))
                                    .padding(.vertical,-12)
                                    .padding(.horizontal,-58)
                            )
                    }
                }
            }
        }
    }
}

import Foundation
