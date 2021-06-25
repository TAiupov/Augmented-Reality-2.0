//
//  Model.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI
import Combine
import RealityKit

enum ModelCategory: CaseIterable {
    case table
    case chair
    case decor
    case light
    case items
    
    var label: String {
        get {
            switch self {
            case .table:
                return "Tables"
            case .chair:
                return "Chairs"
            case .decor:
                return "Decor"
            case .light:
                return "Lights"
            case .items:
                return "Items"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable : AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    //Create a method to async load modelEntity
    func asyncLoadModelEntity() {
        let fileName = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: fileName)
            .sink { loadCompletion in
                switch loadCompletion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            } receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
            }

    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //tables
        let guitar = Model(name: "fender_stratocaster", category: .items, scaleCompensation: 1.0)
        let gramophone = Model(name: "gramophone", category: .items, scaleCompensation: 1.0)
        let toyDrummer = Model(name: "toy_drummer", category: .items, scaleCompensation: 1.0)
        let toyRobot = Model(name: "toy_robot_vintage", category: .items, scaleCompensation: 1.0)
        let tvRetro = Model(name: "tv_retro", category: .items, scaleCompensation: 1.0)
        let redChair = Model(name: "redchair", category: .items, scaleCompensation: 60 / 100)
        self.all.append(contentsOf: [guitar, gramophone, toyRobot, toyDrummer,tvRetro, redChair])
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category })
    }
}
