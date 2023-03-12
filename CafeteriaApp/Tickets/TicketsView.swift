//
//  TicketsView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 12/08/1444 AH.
//

import SwiftUI

struct TicketsView: View {
    @EnvironmentObject var  authviewModel : AuthViewModel
    @StateObject var  ticketsViewModel : TicketsViewModel = TicketsViewModel()
    @Binding var showTickitsView : Bool
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack (spacing : 40) {
                TicketsHeaderView(presentationMode: presentationMode)
            ScrollView {
         
                    Text("الشكاوى")
                        .font(.DinNextArabicBold(size: 30))
                        .foregroundColor(.appColor(.darkBlue))
                    VStack {
                    
                        if ticketsViewModel.tickets.isEmpty {
                            Image("EmptyInbox")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 320)
                        }else {
                   UserTicketsList(tickets: ticketsViewModel.tickets)
                        }
                        Group{
                            NavigationLink {
                                
                       NewTicketView()
                                
                            } label: {
                                Text("إضافة تذكرة جديدة")
                                    .font(.DinNextArabicBold(size: 17))
                                    .foregroundColor(.white)
                                    .frame( maxWidth : .infinity , alignment: .center)
                                    .padding(.vertical , 14)
                                    .background( Color("ncgr-blue") )
                                    .cornerRadius(15)
                                    .padding(.horizontal ,40)
                                
                            }
                            .padding(.top , 30)
                        }
                        
                    }
                    
                    Spacer()
                }
                
            }
            .ignoresSafeArea()
            .background(
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 230)
                    .offset(x : 80 , y : 280)
                
        )

        }
        
        .navigationBarHidden(true)
        .environmentObject(ticketsViewModel)
        .onAppear{
            ticketsViewModel.fetchUserTickets(userId: authviewModel.user.id)
        }
        .environment(\.layoutDirection, .rightToLeft)

    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView(showTickitsView: .constant(true))
            .environmentObject(AuthViewModel())
    }
}


struct TicketsHeaderView: View {
    @Binding var presentationMode: PresentationMode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                backButton(presentationMode: $presentationMode)
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

struct backButton: View {
    @Binding var presentationMode: PresentationMode
    var body: some View {
        Button {
            $presentationMode.wrappedValue.dismiss()
        } label : {
            HStack {
                Image(systemName: "arrow.right")
                    .imageScale(.large)
                    .foregroundColor(.appColor(.darkBlue))
            }
        }
    }
}


struct refreshButton: View {
    
    @EnvironmentObject var  ticketsViewModel : TicketsViewModel
    @EnvironmentObject var  authviewModel : AuthViewModel


    var body: some View {
        Button {
            ticketsViewModel.fetchUserTickets(userId: authviewModel.user.id)
        } label : {
            HStack {
                Image(systemName: "arrow.clockwise")
                    .imageScale(.large)
                    .foregroundColor(.appColor(.darkBlue))
            }
        }
    }
}

struct UserTicketsList : View {

    var tickets : [Ticket]
    var body: some View {
        VStack(spacing : 15){
            ForEach(tickets ) { ticket in
                
                VStack (alignment: .leading, spacing : 12) {
                    Text("رقم التذكرة : ")
                        .font(.DinNextArabicBold(size: 16))
                        .foregroundColor(.appColor(.darkBlue))
                    
                    Text("\(ticket.ticketNumber)#")
                        .font(.DinNextArabicMedium(size: 14))
                        .foregroundColor(.black)
                    
                    Text("حالة التذكرة :" )
                        .font(.DinNextArabicBold(size: 16))
                        .foregroundColor(.appColor(.darkBlue))
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(ticket.respond != nil ? .green : .red)
                            .imageScale(.small)
                        if ticket.respond != nil {
                            Text("تم الرد")
                                .font(.DinNextArabicMedium(size: 13))
                                .foregroundColor(.black)
                        }else {
                            Text("لم يتم الرد")
                                .font(.DinNextArabicMedium(size: 13))
                                .foregroundColor(.black)
                        }
                    }
                    
                }
                .padding(.horizontal , 30)
                .padding(.vertical , 14)
                .frame(maxWidth : .infinity , alignment: .leading)
                .background()
                .cornerRadius(12)
                .overlay(
                    NavigationLink {
                        TicketDitailView(ticket: ticket)
                    }label: {
                        Text("التفاصيل")
                            .font(.DinNextArabicMedium(size: 16))
                            .foregroundColor(.appColor(.darkBlue))
                    }
                         .padding()
                    ,
                    alignment: .bottomTrailing
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12).stroke(style: StrokeStyle(lineWidth: 2)).foregroundColor(.appColor(.darkBlue)).opacity(0.6)
                )
                .padding(.horizontal , 40)

            }
        }
    }
}
