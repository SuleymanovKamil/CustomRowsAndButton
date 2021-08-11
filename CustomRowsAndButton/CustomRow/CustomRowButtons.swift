//
//  CustomRowButtons.swift
//  CustomRowsAndButton
//
//  Created by Камиль Сулейманов on 11.08.2021.
//

import SwiftUI

enum CustomRowButtons: Identifiable {
    case soundOff
    case bookmark
    case delete
  
    var id: String {
        return "\(self)"
    }
}

struct CustomRowButtonsView: View {
    let buttons: CustomRowButtons
    let buttonsHeight: CGFloat
    let buttonsWidtht: CGFloat
    var reset: () -> ()
    
    var body: some View {
        switch buttons {
        case .soundOff:
            buttonView(imageString: "speaker.slash", title: "Sounds off") {
                withAnimation{
                    reset()
                }
             
                print("Sounds off")
            }
            .background(Color.orange)
        case .bookmark:
            buttonView(imageString: "bookmark", title: "Save") {
               
                print("Save")
            }
            .background(Color.blue)
        case .delete:
            buttonView(imageString: "trash", title: "Delete") {
               
                print("Delete")
            }
            .background(Color.red)
        }
    }
    
    func buttonView(imageString: String, title: String, competion: @escaping () -> ()) -> some View {
        
        VStack (spacing: 5){
            Image(systemName: imageString)
                .font(.title2)
            
            Text(title)
                .font(.caption)
                .padding(.horizontal, 4)
        }
        .foregroundColor(.white)
        .frame(width: buttonsWidtht, height: buttonsHeight)
        .contentShape(Rectangle())
        .overlay(Rectangle().stroke(lineWidth: 0.3))
        .onTapGesture {
            withAnimation{
                reset()
            }
            competion()
        }
    }
}



