//
//  CustomSwipeableRow.swift
//  CustomRowsAndButton
//
//  Created by Камиль Сулейманов on 11.08.2021.
//

import SwiftUI

struct CustomSwipeableRow: ViewModifier  {
    
    enum buttonVisibleState {
        case none
        case swipeLeft
        case swipeRight
    }
    
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButtons: buttonVisibleState = .none
    let leadingButtons: [CustomRowButtons]
    let trailingButton: [CustomRowButtons]
    @State var maxLeadingOffset: CGFloat = 0
    @State var minTrailingOffset: CGFloat = 0
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .offset(x: offset)
            
            GeometryReader { geo in
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(leadingButtons) { buttonsData in
                            CustomRowButtonsView(buttons: buttonsData, buttonsHeight: geo.size.height, buttonsWidtht: geo.size.height > 150 ? geo.size.height / 2 : geo.size.height , reset: reset)
                        }
                    }
                    .offset(x: -maxLeadingOffset + offset)
                    
                    Spacer()
                    
                }
                .onAppear{
                    maxLeadingOffset = CGFloat(leadingButtons.count) * geo.size.width
                }
            }
            
            GeometryReader { geo in
                HStack(spacing: 0) {
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        ForEach(trailingButton) { buttonsData in
                            CustomRowButtonsView(buttons: buttonsData, buttonsHeight: geo.size.height, buttonsWidtht: geo.size.height > 150 ? geo.size.height / 2 : geo.size.height, reset: reset)
                        }
                    }
                    .offset(x: minTrailingOffset + offset)
                }
                .onAppear{
                    minTrailingOffset = geo.size.width * CGFloat(trailingButton.count)
                }
            }
        }
        .contentShape(Rectangle())
        .gesture(DragGesture()
                    .onChanged { value in
                        let totalSwipeRange = value.translation.width + oldOffset
                        withAnimation{
                            offset = totalSwipeRange
                        }
                    }
                    .onEnded { value in
                        withAnimation {
                            if visibleButtons == .swipeLeft && value.translation.width < -20 {
                                reset()
                            } else if  visibleButtons == .swipeRight && value.translation.width > 20 {
                                reset()
                            } else if offset > 25 || offset < -25 {
                                if offset > 0 {
                                    visibleButtons = .swipeLeft
                                    offset = maxLeadingOffset
                                } else {
                                    visibleButtons = .swipeRight
                                    offset = -minTrailingOffset
                                }
                                oldOffset = offset
                            } else {
                                reset()
                            }
                        }
                    })
        
    }
    
    func reset() {
        visibleButtons = .none
        offset = 0
        oldOffset = 0
    }
}
