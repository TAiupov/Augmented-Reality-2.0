//
//  ControlView.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI

struct ControlView: View {
    @Binding var isControlVisible: Bool
    @Binding var showBrowse: Bool
    @Binding var showSettings: Bool
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    
    var body: some View {
        VStack {
            controlVisibilityButton
            Spacer()
            
            if isControlVisible {
                controlButtonBar
            }
            
        }
    }
}

extension ControlView {
    
    private var controlVisibilityButton: some View {
        HStack {
            Spacer()
            
            ZStack {
                Color.black.opacity(0.25)
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        isControlVisible.toggle()
                    }
                    
                }, label: {
                    Image(systemName: isControlVisible ? "rectangle" : "slider.horizontal.below.square.fill.and.square")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                        .buttonStyle(PlainButtonStyle())
                })
            }
            .frame(width: 50, height: 50)
            .cornerRadius(8.0)
            
        }
        .padding(.top, 45)
        .padding(.trailing, 20)
    }
    
    private var controlButtonBar: some View {
        HStack {
            MostRecentlyPlacedButton()
                .hidden(self.placementSettings.recentlyPlaced.isEmpty)
            Spacer()
            ControlButton(systemIcon: "square.grid.2x2") {
                showBrowse.toggle()
            }
            .sheet(isPresented: $showBrowse, content: {
                BrowseView(showBrowse: $showBrowse)
            })
            Spacer()
            
            
            ControlButton(systemIcon: "slider.horizontal.3") {
                print("Settings Button pressed")
                self.showSettings.toggle()
            }
            .sheet(isPresented: $showSettings, content: {
                SettingsView(showSettings: $showSettings)
            })
        }
        .transition(.move(edge: .bottom))
        .frame(maxWidth: 500)
        .padding(30)
        .background(
            Color.black.opacity(0.25)
        )
    }
    
}


struct ControlButton: View {
    let systemIcon: String
    let action: () -> Void
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Image(systemName: systemIcon)
                .font(.system(size: 35))
                .foregroundColor(.white)
                .buttonStyle(PlainButtonStyle())
        })
        .frame(width: 50)
    }
}


struct MostRecentlyPlacedButton: View {
    @EnvironmentObject var placementSettings: PlacementSettings

    var body: some View {
        
        
        
        Button(action: {
            self.placementSettings.selectedModel = self.placementSettings.recentlyPlaced.last
        }, label: {
            if let mostRecentlyPlacedModel = self.placementSettings.recentlyPlaced.last {
                Image(uiImage: mostRecentlyPlacedModel.thumbnail)
                    .resizable()
                    .frame(width: 46)
                    .aspectRatio(1/1, contentMode: .fit)
            } else {
                Image(systemName: "clock.fill")
                    .font(.system(size: 35))
                    .foregroundColor(.white)
                    .buttonStyle(PlainButtonStyle())
            }
            
        })
        .frame(width: 50, height: 50)
        .background(Color.white)
        .cornerRadius(8.0)
    }
}
