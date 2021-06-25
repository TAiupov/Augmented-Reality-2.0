//
//  BrowseView.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI
import Combine
import RealityKit

struct BrowseView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showBrowse: Bool
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                RecentsGrid(showBrowse: $showBrowse)
                ModelsByCategory(showBrowse: $showBrowse)
            }
            .navigationBarTitle(Text("Browse"))
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "xmark")
                                            .padding(25)
                                            .foregroundColor(.white)
                                    })
            )
        }
    }
}

struct RecentsGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    
    var body: some View {
        if !self.placementSettings.recentlyPlaced.isEmpty {
            ItemsGrid(showBrowse: $showBrowse, title: "Recents", items: getRecentsUniqueOrdered(), scrollType: .horizontal)
        }

    }
    func getRecentsUniqueOrdered() -> [Model] {
        var recentUniqueOrderedArray: [Model] = []
        var modelNameSet: Set<String> = []
        
        for model in self.placementSettings.recentlyPlaced.reversed() {
            if !modelNameSet.contains(model.name) {
                recentUniqueOrderedArray.append(model)
                modelNameSet.insert(model.name)
            }
        }
        return recentUniqueOrderedArray
    }
}


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView(showBrowse: .constant(true))
    }
}

struct ModelsByCategory: View {
    @Binding var showBrowse: Bool
    let models = Models()
    
    var body: some View {
        VStack {
            ForEach(ModelCategory.allCases, id:\.self) { category in
                if let modelsByCategory = models.get(category: category),
                   !modelsByCategory.isEmpty
                   {
                    ItemsGrid(showBrowse: $showBrowse, title: category.label, items: modelsByCategory)
                }
            }
        }
    }
}

struct ItemsGrid: View {
    @EnvironmentObject var placementSettings: PlacementSettings
    @Binding var showBrowse: Bool
    
    var title: String
    var items: [Model]
    var scrollType: Axis.Set = .vertical
    private let gridItemLayout = [GridItem(.fixed(150)), GridItem(.fixed(150))]
    var body: some View {
        VStack(alignment: .leading) {
            Separator()
            Text(title)
                .font(.title2).bold()
                .padding(.leading, 22)
                .padding(.top, 10)
            ScrollView(scrollType, showsIndicators: false) {
                LazyVGrid(columns: gridItemLayout, spacing: 30) {
                    ForEach(0 ..< items.count) { index in
                       let model = items[index]
                        ItemButton(showBrowse: $showBrowse, model: model) {
                            model.asyncLoadModelEntity()
                            self.placementSettings.selectedModel = model
                        }
                    }
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
            }
        }
    }
}

struct ItemButton: View {
    @Binding var showBrowse: Bool
    let model : Model
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            self.action()
        }, label: {
            Image(uiImage: self.model.thumbnail)
                .resizable()
                .frame(height: 150)
                .aspectRatio(1/1, contentMode: .fit)
                .background(Color(UIColor.secondarySystemFill))
                .cornerRadius(8.0)
        })
    }
}

struct Separator: View {
    var body: some View {
        Divider()
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
