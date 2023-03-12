//
//  HomeView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 04/08/1444 AH.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var orderViewModel : OrderViewModel
    
    @Binding var showDeitalItem : Bool
    @Binding var selecteditem : ItemType
    @Binding var isMapShowing : Bool
    
    var getSelectedItemIndex : Int
    var isOrderReady : Bool {
        return orderViewModel.order.zoneColor != .none && !orderViewModel.order.items.isEmpty
    }
    
    var body: some View {

        VStack (spacing : 60) {

            Group{
                ColorZonePicker( selectedZoon: $orderViewModel.order.zoneColor , isMapShowing: $isMapShowing)
                
            }
            Group{
                OrderPicker(items: $orderViewModel.order.items, showDeitalItem: $showDeitalItem, selecteditem: $selecteditem)
            }
            Group{
                Button {
                    
                    orderViewModel.addOrder(userId : authViewModel.user.id)
                    
                } label: {
                    Text("تأكيد الطلب")
                        .font(.DinNextArabicBold(size: 17))
                        .foregroundColor(.white)
                        .frame( maxWidth : .infinity , alignment: .center)
                        .padding(.vertical , 14)
                        .background(isOrderReady ? Color("ncgr-blue") : .gray )
                        .cornerRadius(15)
                        .padding(.horizontal ,40)
                    
                }
                .disabled(!isOrderReady)
                .padding(.top , 30)
            }
            Spacer()
            
        }
        
        
  
        
        
    }
    
}
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            OrderView(showDeitalItem: .constant(false), selecteditem: .constant(.tea), isMapShowing: .constant(false), getSelectedItemIndex: 1)
                .environmentObject(AuthViewModel())
                .environmentObject(OrderViewModel())
        }
    }
    
    
    
    
    
    struct MapButtonView: View {
        @Binding  var isMapShowing : Bool
        var body: some View {
            
            
            Button {
                isMapShowing = true
            } label: {
                Image(systemName: "map")
                    .resizable()
                    .scaledToFit()
                    .frame(width : 20)
                    .foregroundColor(Color.appColor(.darkBlue))
                
            }
        }
    }
    
    

    



struct LogOutButtonView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        Button {
            authViewModel.logOut()
        } label : {
            HStack {
                Image(systemName: "ipad.and.arrow.forward")
                    .imageScale(.large)
                    .foregroundColor(.appColor(.darkBlue))
            }
        }
    }
}

struct TicketsButtonView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    @Binding var showTickitsView : Bool
    var body: some View {
        Button {
            showTickitsView = true
        } label : {
            HStack {
                Image(systemName: "exclamationmark.square")
                    .imageScale(.large)
                    .foregroundColor(.appColor(.darkBlue))
            }
        }
    }
}
