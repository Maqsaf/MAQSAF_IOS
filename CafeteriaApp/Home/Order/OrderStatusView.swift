//
//  OrderStatusView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 08/08/1444 AH.
//

import Foundation

//
//  HomeView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 04/08/1444 AH.
//

import SwiftUI

struct OrderStatusView: View {
        @EnvironmentObject var orderViewModel : OrderViewModel
    
    
    var isAbleBackToOrder : Bool {
        return orderViewModel.order.orderState == .accepted ||  orderViewModel.order.orderState == .rejectd
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack (spacing : 50) {
                    
                    
                    HStack {
                        Spacer()
                        Text("الطلب رقم \(orderViewModel.order.orderNumber)#")
                            .font(.DinNextArabicBold(size: 27))
                            .foregroundColor(.appColor(.darkBlue))
                        
                        Spacer()
                        Spacer()
                        
                        Button {
                            orderViewModel.updateOrderStatus()
                            
                        } label: {
                            Image(systemName: "arrow.clockwise")
                                .imageScale(.large)
                                .foregroundColor(.gray)
                        }

                    }
                    
                    
                    OrderStatusProgressView()
                    
                    Image("\(orderViewModel.order.orderState.rawValue)")
                    
                    if(orderViewModel.order.orderState == .accepted) {
                        
                        HStack {
                            Spacer()
                            Text("تفاصيل الطلب")
                                .font(.DinNextArabicBold(size: 20))
                                .foregroundColor(.appColor(.darkBlue))
                            
                            Spacer()
                            
                        }
                        
                        
                        OrderTypeDitalisView()
                        
                        HStack {
                            Spacer()
                            Text("تفاصيل المكان")
                                .font(.DinNextArabicBold(size: 20))
                                .foregroundColor(.appColor(.darkBlue))
                            Spacer()
                            
                        }
                        VStack (spacing : 40) {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 70 , height: 50)
                                .foregroundColor(orderViewModel.order.zoneColor.color)
                            Text(orderViewModel.order.zoneColor.title)
                                .font(.DinNextArabicLight(size: 14))
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 100, height: 140)
                        .background(.white)
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(style: StrokeStyle(lineWidth: 2)).foregroundColor(Color.appColor(.darkBlue)))
                    }
                    
        
                        
                        Group{
                            Button {
                                orderViewModel.order  = .init(id: "", orderNumber: 1, zoneColor: .none , orderState: .rejectd, createdAt: "", userID: "", items: [])
                                
                                orderViewModel.isUserHasOrder = false
                                
                            } label: {
                                Text("العودة لقائمة الطلبات")
                                    .font(.DinNextArabicBold(size: 15))
                                    .foregroundColor(.white)
                                    .frame( maxWidth : .infinity , alignment: .center)
                                    .padding(.vertical , 14)
                                    .background(isAbleBackToOrder ? Color("ncgr-blue") : .gray )
                                    .cornerRadius(15)
                                    .padding(.horizontal ,40)
                                
                            }
                            .disabled(!isAbleBackToOrder)
                            .padding(.top , 30)
                        }
                    
                   
                    
                }
                    }
                    Spacer()
                    
                }
                .padding(30)
                .background(Color.appColor(.lightGray))
                .cornerRadius(20)
                .padding(30)
            }
        }
    
struct OrderStatusView_Previews: PreviewProvider {
    static var previews: some View {
        OrderStatusView()
            .environmentObject(OrderViewModel())
    }
}

struct OrderStatusProgressView: View {
    
    @EnvironmentObject var orderViewModel : OrderViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(height: 1)
                .offset(y: -10)
            HStack (spacing : 40) {
                VStack {
                    Circle()
                        .frame(width : 50)
                        .foregroundColor(orderViewModel.order.orderState == .pending ?  Color.appColor(.darkBlue) : .white)
                        .overlay(
                            Circle ()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .foregroundColor(Color.appColor(.darkBlue))
                            
                        )
                    Text("بإنتظار مزود الخدمة")
                        .font(.DinNextArabicMedium(size: 14))
                }
                VStack {
                    Circle ()
                        .frame(width : 50)
                        .foregroundColor(orderViewModel.order.orderState != .pending ?  Color.appColor(.darkBlue) : .white)
                    
                        .overlay(
                            Circle ()
                                .stroke(style: StrokeStyle(lineWidth: 2))
                                .foregroundColor(Color.appColor(.darkBlue))
                            
                        )
                    
                    Text("حالة الطلب")
                        .font(.DinNextArabicMedium(size: 14))
                }
                
                
                
            }
            
            
        }
    }
}

struct OrderTypeDitalisView: View {
    @EnvironmentObject var orderViewModel : OrderViewModel

    var body: some View {
        HStack(spacing : 20){
            ForEach(orderViewModel.order.items , id : \.self ){ item in
                VStack (spacing : 40) {
                    Image(item.item.imgName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    Text(item.item.title)
                }
                .frame(width: 100, height: 140)
                .background(.white)
                .cornerRadius(12)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(style: StrokeStyle(lineWidth: 2)).foregroundColor(Color.appColor(.darkBlue)))
            }
        }
    }
}
