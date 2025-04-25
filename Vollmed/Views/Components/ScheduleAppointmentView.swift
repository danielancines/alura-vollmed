//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by daniel.ancines on 21/04/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    @State private var errorMessage = ""
    
    let service = SpecialistsService()
    var specialist: Specialist
    
    func scheduleAppointment() async {
        do {
            if let appointment = try await service.scheduleAppointment(specialistID: specialist.id, patientID: "7712904b-31a3-4c56-b319-c011ba1993a4", date: selectedDate.convertToString()) {
                if (appointment.hasError){
                    errorMessage = appointment.message
                    isAppointmentScheduled = false
                } else {
                    isAppointmentScheduled = true
                }
                showAlert = true;
            }
        } catch {
            print("Error at schedule appointment: \(error)")
        }
    }
    
    var body: some View {
        VStack{
            Text("Selecione a data e horário da consulta")
                .font(.title3)
                .bold()
                .padding(.top)
                .multilineTextAlignment(.center)
                .foregroundStyle(.accent)
            
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button{
                Task{
                    await scheduleAppointment()
                }
            } label: {
                ButtonView(text: "Agendar consulta")
            }
        }
        .padding()
        .navigationTitle("Agendar Consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear(){
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Ocorreu um erro", isPresented: $showAlert, presenting: isAppointmentScheduled) { isScheduled in
            Button{
                
            } label: {
                Text("OK")
            }
        } message: { isScheduled in
            if (isScheduled){
                Text("Consulta agendada com sucesso")
            } else {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialist: Specialist(id: "1", name: "Daniel", crm: "123", imageUrl: "sadf", specialty: "asdf", email: "asdf", phoneNumber: "asdf"))
}
