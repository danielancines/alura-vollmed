//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by daniel.ancines on 21/04/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    @State private var selectedDate = Date()
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
                print(selectedDate.convertToString().dateToString(format: Formats.screenDateFormat))
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
    }
}

#Preview {
    ScheduleAppointmentView()
}
