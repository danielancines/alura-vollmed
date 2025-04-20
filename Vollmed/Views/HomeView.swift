//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    @State private var specialists: [Specialist] = []
    let specialistsService = SpecialistsService()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear(){
            Task {
                await fetchSpecialists()
            }
        }
    }
    
    func fetchSpecialists() async {
        do {
            guard let specialists = try await specialistsService.getAllSpecialists() else {
                print("Error fetching specialists")
                return
            }
            self.specialists = specialists
        } catch {
            print("An error occurred: \(error)")
        }
    }
}

#Preview {
    HomeView()
}
