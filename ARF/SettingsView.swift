//
//  SettingsView.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI

enum Setting {
    case peopleOcclusion
    case objectOcclusion
    case lidarDebug
    case multiUser
    
    var label: String {
        get {
            switch self {
            case .peopleOcclusion, .objectOcclusion:
                return "Occlusion"
            case .lidarDebug:
                return "LiDAR"
            case .multiUser:
                return "Multiuser"
            }
        }
    }
    
    var systemIconName: String {
        get {
            switch self {
            case .peopleOcclusion:
                return "person"
            case .objectOcclusion:
                return "cube.box.fill"
            case .lidarDebug:
                return "light.min"
            case .multiUser:
                return "person.2"
            }
        }
    }
}

struct SettingsView: View {
    @Binding var showSettings: Bool
    
    var body: some View {
        NavigationView {
            SettingGrid()
                .navigationBarTitle(Text("Settings"), displayMode: .inline)
                .navigationBarItems(trailing:
                                        Button(action: {
                                            showSettings.toggle()
                                        }, label: {
                                            Image(systemName: "xmark")
                                                .padding(25)
                                                .foregroundColor(.white)
                                        })
                )
        }
    }
}


struct SettingGrid: View {
    @EnvironmentObject var sessionSettings: SessionSettings
    
    private var gridLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns:gridLayout, spacing: 25) {
                SettinngToggleButton(setting: .peopleOcclusion, isOn: $sessionSettings.isPeopleOcclusionEnabled)
                SettinngToggleButton(setting: .objectOcclusion, isOn: $sessionSettings.isObjectOcclusionEnabled)
                SettinngToggleButton(setting: .lidarDebug, isOn: $sessionSettings.isLidarDebugEnabled)
                SettinngToggleButton(setting: .multiUser, isOn: $sessionSettings.isMultiUserEnabled)
            }
        }
        .padding(.top, 5)
    }
}



struct SettinngToggleButton: View {
    let setting: Setting
    
    @Binding var isOn: Bool
    
    var body: some View {
        Button(action: {
            self.isOn.toggle()
            print("\(#file) - \(setting): \(self.isOn)")
        }, label: {
            VStack {
                Image(systemName: setting.systemIconName)
                    .font(.system(size: 35))
                    .foregroundColor(self.isOn ? .green : Color(UIColor.secondaryLabel))
                    .buttonStyle(PlainButtonStyle())
                
                Text(setting.label)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(self.isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
                    .padding(.top, 5)
            }
        })
        .frame(width: 100, height: 100)
        .background(Color(UIColor.secondarySystemFill))
        .cornerRadius(20.0)
    }
}
