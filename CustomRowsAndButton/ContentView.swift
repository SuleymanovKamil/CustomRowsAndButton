//
//  ContentView.swift
//  CustomRowsAndButton
//
//  Created by Камиль Сулейманов on 11.08.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                
                NavigationLink("Custom Row List", destination: MainView())
                
                NavigationLink("Custom Button", destination: CustomAudioButton())
            }
            .padding(.top)
            .navigationTitle("Test")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


