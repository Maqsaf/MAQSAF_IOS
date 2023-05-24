//
//  ColorZoonPicker.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 07/08/1444 AH.
//

import SwiftUI

struct ColorZonePicker: View {
    @Binding var selectedZoon : ZoonColor
    @Binding var isMapShowing : Bool

    var body: some View {
        VStack {
            
            HStack (){


                OrderTitleView(title: "قم بإختيار لون مكتبك على الخريطة:", number: 1)

                MapButtonView(isMapShowing: $isMapShowing)
                Spacer()

            }
            HStack (spacing : 13) {

                ForEach(ZoonColor.allCases , id : \.self){ seat in

                    if seat != .none {
                           ZoneView(seat: seat, selectedZoon: $selectedZoon)
                    }
                }
            }
            
        }
    }
}


struct ColorZonePicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorZonePicker(selectedZoon: .constant(.green), isMapShowing: .constant(false))
        .environmentObject(OrderViewModel())
    }
}


struct ZoneView: View {
     var seat : ZoonColor
    @Binding var selectedZoon : ZoonColor

    var body: some View {
        VStack {

            RoundedRectangle(cornerRadius: 10)
                    .frame(width: 50 , height: 40)
                    .foregroundColor(seat.color)
                    .padding(.top)
            Text(seat.title)
                .frame(width: 75 , height: 60)
                .multilineTextAlignment(.center)
                .font(.DinNextArabicMedium(size: 16))
                .foregroundColor(.appColor(.darkBlue) )
        }
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(style: StrokeStyle(lineWidth: 2))
                .foregroundColor(selectedZoon == seat ? seat.color : .appColor(.darkBlue))
                .opacity(0.5)
        )
        .onTapGesture {
            selectedZoon = seat
            UserDefaults.standard.set(selectedZoon.rawValue, forKey: "UserZone")
        }
        .scaleEffect( selectedZoon == seat  ? 1.13 : 1)
        .animation(.easeOut(duration: 1))
        
        .onAppear{
            
            if let userZone =  UserDefaults.standard.string(forKey: "UserZone") {
                selectedZoon = ZoonColor(rawValue: userZone) ?? .none
            }
        }
    }
}


