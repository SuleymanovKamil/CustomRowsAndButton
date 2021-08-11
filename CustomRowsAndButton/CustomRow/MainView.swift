//
//  MainView.swift
//  CustomRowsAndButton
//
//  Created by Камиль Сулейманов on 11.08.2021.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        List  {
            Section(header: Text("Swipe right or left")) {
                ForEach(0...6, id: \.self) { row in
                    HStack {
                        Text(row.description)
                        
                        Spacer()
                    }
                    .frame(height: 70)
                    .addButtonActions(leadingButtons: [.bookmark],
                                      trailingButton:  row % 2 == 0 ? [.delete, ] : [.soundOff])
                }
            }
        } 
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}





