//
//  PlacementView.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI

struct PlacementView: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    var body: some View {
        HStack {
            Spacer()
            PlacementButton(systemIcon: "xmark.circle.fill") {
                print("cancel button pressed")
                self.placementSettings.selectedModel = nil
            }
            Spacer()
            PlacementButton(systemIcon: "checkmark.circle.fill") {
                print("Confirm placement button pressed")
                self.placementSettings.confirmedModel = self.placementSettings.selectedModel
                
                self.placementSettings.selectedModel = nil
            }
            Spacer()
        }
        .padding(30)
    }
}

struct PlacementButton: View {
    let systemIcon: String
    let action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Image(systemName: systemIcon)
                .font(.system(size: 50, weight: .light, design: .default))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        })
        .frame(width: 75, height: 75)
    }
}
