//
//  TicketDitailView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 19/08/1444 AH.
//

import SwiftUI

struct TicketDitailView: View {
    
    var ticket : Ticket
    var body: some View {
        VStack (spacing : 40) {
            TicketDitailHeaderView()
            
            Text("تفاصيل الشكوى")
                .font(.DinNextArabicBold(size: 26))
                .foregroundColor(.appColor(.darkBlue))
            VStack (alignment: .leading , spacing: 50){
                
                VStack (alignment: .leading, spacing : 12) {
                    Text("رقم التذكرة : ")
                        .font(.DinNextArabicBold(size: 20))
                        .foregroundColor(.appColor(.darkBlue))
                    
                    Text("\(ticket.ticketNumber)#")
                        .font(.DinNextArabicMedium(size: 16))
                        .foregroundColor(.black)
                    
                    Text("حالة التذكرة :" )
                        .font(.DinNextArabicBold(size: 20))
                        .foregroundColor(.appColor(.darkBlue))
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(ticket.respond != nil ? .green : .red)
                            .imageScale(.small)
                        if ticket.respond != nil {
                            Text("تم الرد")
                                .font(.DinNextArabicMedium(size: 16))
                                .foregroundColor(.black)
                        }else {
                            Text("لم يتم الرد")
                                .font(.DinNextArabicMedium(size: 13))
                                .foregroundColor(.black)
                        }
                    }
                    
                }

                
                VStack {
                    HStack {
                        Text("وصف المشكلة ")
                            .font(.DinNextArabicBold(size: 18))
                        .foregroundColor(.appColor(.darkBlue))
                        
                        Spacer()
                    }
                  
                    
                Text(ticket.description)
                        .font(.DinNextArabicMedium(size: 16))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                .padding()
                .frame(width: UIScreen.main.bounds.width - 50 , alignment: .leading)
                .frame(minHeight: 200 , alignment: .topLeading)
                .multilineTextAlignment(.leading)
                .background(
                    Color.appColor(.lightGray)
                        .cornerRadius(12)
  )
        
                  
                        
                }

            }
            .padding(.horizontal , 40)

            Spacer()
        }
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct TicketDitailView_Previews: PreviewProvider {
    static var previews: some View {
        TicketDitailView(ticket: .init(id: "0", userID: "", priority: "", description: "mwt hfrkfvmfkvmg rgjmnerk ", respond: nil, createdAt: "", ticketNumber: 2))
    }
}

struct TicketDitailHeaderView: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                backButton(presentationMode: presentationMode)
                Spacer()
                Image("logo_1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Spacer()
                refreshButton()
                Spacer()
                
            }
            .padding(.top , 40)
            .padding(.bottom , 10)
            .background()
            .cornerRadius(15)
            .shadow(color: .gray.opacity(0.5), radius: 20)
        }
    }
}
