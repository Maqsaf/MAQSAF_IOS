//
//  OrderView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 05/08/1444 AH.
//

import SwiftUI
import SwiftUI
struct HomeView: View {
    
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var isMapShowing : Bool = false
    @StateObject var orderViewModel : OrderViewModel = OrderViewModel()
    @State var showDeitalItem : Bool = false
    @State var showTickitsView : Bool = false
    @State var selecteditem : ItemType = .tea
    
//    var getSelectedItemIndex : Int {
//        return orderViewModel.order.items.firstIndex(where: {$0.item ==  selecteditem }) ?? -1
//    }

    var body: some View {
        
        VStack{
            Group{
                HomeHeaderView(showTickitsView: $showTickitsView)
            }
             
                VStack (spacing : 60) {
                    Group {
                        if orderViewModel.isUserHasOrder {
                            
                            OrderStatusView()
                            
                        }else {
                            ScrollView (showsIndicators: false) {
                                
                                OrderView(showDeitalItem: $showDeitalItem, selecteditem: $selecteditem, isMapShowing: $isMapShowing)
                            }
                        }
                    }
                }
            
            .fullScreenCover(isPresented: $showTickitsView , onDismiss: { showTickitsView = false}) {
                TicketsView(showTickitsView: $showTickitsView)
            }
            .animation(.easeOut(duration: 0.3))
            .padding()
            
        }
        .overlay(
            ZStack{
                if isMapShowing {
                    DoorMapView(isApear: $isMapShowing)
                }
                if orderViewModel.isLoading , !orderViewModel.isUserHasOrder {
                    NCGRProgressView()
                }
            }
            
        )
        
        .overlay(
            ZStack{
                if showDeitalItem {
                    ItemDeitalisView(itemDitals: $orderViewModel.order.items, itemType: $selecteditem, showView: $showDeitalItem)
                }
            }
            
        )
        .background(
            
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 280)
                .offset(x : 90 , y : 280)
            
            
        )
        .ignoresSafeArea()
        
        .environmentObject(orderViewModel)

        .onAppear{
            
            if let orderId = UserDefaults.standard.string(forKey: "OrderID") {
                orderViewModel.fetchOrder(orderId: orderId)
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .environmentObject(AuthViewModel())
                .environmentObject(OrderViewModel())

        }
    }
    
    struct HomeHeaderView: View {
        @Binding var showTickitsView : Bool

        var body: some View {
            
            VStack {
                
                HStack {
                    Spacer()
                    TicketsButtonView( showTickitsView: $showTickitsView)
                    Spacer()

                    Image("logo_1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    Spacer()
                    LogOutButtonView()
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
}
