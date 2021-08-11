//
//  CustomButton.swift
//  CustomAudioButton
//
//  Created by Камиль Сулейманов on 12.08.2021.
//

import SwiftUI
import AVFoundation

struct CustomAudioButton: View {
    let audioPlayer = AudioPlayer()
    @GestureState private var isDetectingPress = false
    
    var body: some View {
        
        Button(action: {
            //add action
        }, label: {
            Text("Hello World")
                .foregroundColor(.white)
                .padding()
                .background(isDetectingPress ? Color.gray : Color.blue)
                .cornerRadius(10)
                .gesture(LongPressGesture(minimumDuration: 0.1)
                            .sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local)).updating($isDetectingPress) { value, state, _ in
                                switch value {
                                case .second(true, nil):
                                    state = true
                                default:
                                    break
                                }
                            })
        })
        .onChange(of: isDetectingPress, perform: { pressed in
            pressed ? audioPlayer.playAudio() : audioPlayer.StopPlaying()
        })
    }
}



struct CustomAudioButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomAudioButton()
    }
}


class AudioPlayer {
    var audioPlayer: AVAudioPlayer?
    
    func playAudio() {
        if let audioURL = Bundle.main.url(forResource: "dtmf_1 ", withExtension: ".mp3") {
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOf: audioURL)
                
                audioPlayer?.play()
                
            } catch {
                print("Couldn't play audio. Error: \(error)")
            }
            
        } else {
            print("No audio file found")
        }
        
    }
    
    func StopPlaying() {
        audioPlayer?.stop()
    }
}
