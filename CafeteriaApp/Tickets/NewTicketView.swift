//
//  NewTicketView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 14/08/1444 AH.
//

import Foundation


import SwiftUI

struct NewTicketView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var  ticketsViewModel : TicketsViewModel
    @EnvironmentObject var  authViewModel : AuthViewModel
    
    @State var ticketText : String = ""
     var isDefultHidden : Bool {
        return !ticketText.isEmpty
    }

    var body: some View {
        
        VStack (spacing : 40) {
            TicketDitailHeaderView()
            
            Text("الشكاوى")
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()

                }
                .font(.DinNextArabicBold(size: 30))
                .foregroundColor(.appColor(.darkBlue))
            VStack {
                
                VStack {
                    HStack {
                        Text("وصف المشكلة")
                            .font(.DinNextArabicBold(size: 18))
                        .foregroundColor(.appColor(.darkBlue))
                        Spacer()
                    }
                    
                    
                    TextEditor( text: $ticketText)
                            .frame(height:  200)
                            .foregroundColor(.gray)
                        .cornerRadius(20)
                        .overlay (
                            Text("الرجاء إدخال وصف المشكلة")
                                .font(.DinNextArabicBold(size: 15))
                                .foregroundColor(.gray.opacity(0.6))
                                .padding(10)
                                .hidden(isDefultHidden)
                            , alignment: .topLeading )
                        
                    
                }
                
                .padding(.horizontal , 30)
                .padding(.top , 20)

                .padding(.bottom , 30)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(20)

                .padding()
                Group {
                    Button {
                        
                        ticketsViewModel.addTicket(userId: authViewModel.user.id , desc:ticketText )
                        presentationMode.wrappedValue.dismiss()
                        
                    } label: {
                        Text("إرسال")
                            .font(.DinNextArabicBold(size: 18))
                            .foregroundColor(.white)
                            .frame( maxWidth : .infinity , alignment: .center)
                            .padding(.vertical , 14)
                            .background( ticketText.isEmpty ? .gray : Color("ncgr-blue") )
                            .cornerRadius(15)
                            .padding(.horizontal ,40)
                        
                    }
                    .disabled(ticketText.isEmpty)
                    .padding(.top , 30)
                }
                
            }
            
            Spacer()
        }
        .dismissKeyboard(on: [.drag, .tap])

        
        .ignoresSafeArea()
        .background(
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 230)
                .offset(x : 80 , y : 280)
            
        )
        
        .navigationBarHidden(true)
    }
}

struct NewTicketView_Previews: PreviewProvider {
    static var previews: some View {
        NewTicketView()
    }
}



