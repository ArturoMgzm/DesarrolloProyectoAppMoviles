//
//  patientsView.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 16/03/24.

import SwiftUI
import SwiftData

@available(iOS 17, *)
struct PatientsView: View {
    
    @Query var patients: [Patient]
    @Environment(\.modelContext) var modelContext
    
    func addPatient(){
        let patient1 = Patient(name: "Arturo Manrique Garza", gender: "M", hand: "D", diagnostic: "", age: 24, lastVisit: "13/04/2024", sessions: [])
        let patient2 = Patient(name: "Jaime Cruz Aguilar", gender: "M", hand: "D", diagnostic: "", age: 21, lastVisit: "05/04/2024", sessions: [])
        
        modelContext.insert(patient1)
        modelContext.insert(patient2)
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Background")
                    .ignoresSafeArea()
                VStack{
                    HStack{
                        ZStack{
                            Color("Primary")
                                .ignoresSafeArea()
                            Text("Lic. Avila Rdz")
                                .foregroundColor(.white)
                                .font(.system(size:48,weight: .bold))
                        }
                    }.frame(height:120)
                    VStack(alignment: .leading, spacing: 0){
                        HStack(alignment: .center){
                            Text("Pacientes")
                                .foregroundColor(Color("Highlight"))
                                .font(.system(size:64,weight: .bold))
                                .frame(alignment: .leading)
                            Spacer()
                            ZStack{
                                Circle()
                                    .fill(Color("Secondary"))
                                    .frame(width:58, height:58)
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color("Highlight"))
                                    .font(.system(size:27))
                            }
                        }.padding(.bottom,44)
                        ScrollView{
                            ForEach(patients, id: \.self){ patient in
                                NavigationLink{
                                    PatientDetailView(
                                        patient: patient
                                    ).navigationBarBackButtonHidden(true)
                                } label: {
                                    VStack(alignment: .leading){
                                        Divider()
                                            .background(Color("Primary"))
                                            .padding(.bottom,24)
                                        Text(patient.name)
                                            .foregroundColor(Color("Primary"))
                                            .font(.system(size:48))
                                            .frame(alignment: .leading)
                                            .multilineTextAlignment(.leading)
                                        HStack{
                                            Text("Ultima visita:")
                                                .foregroundColor(Color("Primary"))
                                                .font(.system(size:27,weight: .semibold))
                                                .frame(alignment: .leading)
                                            Text(patient.lastVisit)
                                                .foregroundColor(Color("Secondary"))
                                                .font(.system(size:27))
                                                .frame(alignment: .leading)
                                        }
                                        Divider()
                                            .background(Color("Primary"))
                                            .padding(.top,24)
                                    }
                                }
                            }
                        }
                    }.padding(24)
                    Spacer()
                }
                VStack{
                    Spacer()
                    NavigationLink{
                        PatientDetailView(
                            isEditing: true,
                            isNewPatient: true
                        ).navigationBarBackButtonHidden(true)
                    } label: {
                        HStack{
                            Spacer()
                            ZStack{
                                Circle()
                                    .fill(Color("Highlight"))
                                    .frame(width:180, height:180)
                                Image(systemName: "plus")
                                    .foregroundColor(Color("Background"))
                                    .font(.system(size:120))
                            }
                        }.padding(.horizontal,24)
                    }
                }
            }
        }
    }
}

@available(iOS 17, *)
struct PatientsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
    }
}

import Foundation
