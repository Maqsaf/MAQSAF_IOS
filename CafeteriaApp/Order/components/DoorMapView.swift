//
//  CustomAlert.swift
//  NCGRCards
//
//  Created by Reenad gh on 14/07/1444 AH.
//

import SwiftUI




struct DoorMapView: View {
    @State var isAnimating : Bool = false
    @Binding var isApear : Bool
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing : 10){
                HStack{
                    Button {
                        withAnimation{
                            isApear = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.medium)
                    }

                    Spacer()

                }
                Image("map")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 30 )
                
                
                
            }
            .padding( 30)
            .frame(maxWidth: UIScreen.main.bounds.width - 20 )
            .background(Color.white)
            .cornerRadius(9)
            
            .scaleEffect(  isAnimating ? 1 : 0.2)
            
            
        }
        .frame(maxWidth : .infinity , maxHeight: .infinity)
        .background(Color.black.opacity( isAnimating ? 0.45 : 0))
        .onAppear{
            withAnimation(.spring()){
                isAnimating = true
            }
        }
    }
}

struct DoorMapView_Previews: PreviewProvider {
    static var previews: some View {
        DoorMapView(isApear: .constant(true))
        

        
    }
}
