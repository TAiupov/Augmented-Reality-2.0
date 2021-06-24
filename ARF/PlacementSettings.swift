//
//  PlacementSettings.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI
import Combine
import RealityKit

class PlacementSettings: ObservableObject {
    // when the user selects a model in BrowseView, this property is set.
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    // when the user taps confirm in PlacementView, the value of selectedModel is assigned to confirmedModel
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmed model")
                return
            }
            print("Setting confirmedModel to \(model.name)")
            self.recentlyPlaced.append(model)
        }
    }
    
    @Published var recentlyPlaced: [Model] = []
    
    // This property retains the cancellable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
}
