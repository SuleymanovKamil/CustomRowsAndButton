//
//  extensions.swift
//  CustomRowsAndButton
//
//  Created by Камиль Сулейманов on 11.08.2021.
//

import SwiftUI

extension View {
    func addButtonActions(leadingButtons: [CustomRowButtons], trailingButton: [CustomRowButtons]) -> some View {
        self.modifier(CustomSwipeableRow(leadingButtons: leadingButtons, trailingButton: trailingButton))
    }
}


