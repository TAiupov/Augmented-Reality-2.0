//
//  SessionSettings.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI

class SessionSettings: ObservableObject {
    @Published var isPeopleOcclusionEnabled: Bool = false
    @Published var isObjectOcclusionEnabled: Bool = false
    @Published var isLidarDebugEnabled: Bool = false
    @Published var isMultiUserEnabled: Bool = false
}
