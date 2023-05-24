//
//  mapSwiftui.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 18/10/1444 AH.
//

import SwiftUI

struct PinView: View {
    @State var position: CGPoint
    @Binding var selectedCoordinate: CGPoint?
    
    var body: some View {
        Circle()
            .fill(selectedCoordinate == position ? Color.blue : Color.red)
            .frame(width: 20, height: 20)
            .position(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.location
                    }
                    .onEnded { value in
                        selectedCoordinate = position
                    }
            )
    }
}

struct FloorMapView: View {
    @State var selectedCoordinate: CGPoint? = nil
    
    var body: some View {
        Image("map-kit")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                ZStack {
                    PinView(position: CGPoint(x: 100, y: 200), selectedCoordinate: $selectedCoordinate)
                    // add more pins as needed
                }
            )
            .navigationBarItems(
                trailing: Button("Save") {
                    if let selectedCoordinate = selectedCoordinate {
                        // save the selected coordinate to UserDefaults or your preferred storage method
                    }
                }
                .disabled(selectedCoordinate == nil)
            )
    }
}
struct mapSwiftui_Previews: PreviewProvider {
    static var previews: some View {
        FloorMapView()
    }
}
