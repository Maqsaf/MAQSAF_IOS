//
//  OrderTypeView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 07/08/1444 AH.
//

import SwiftUI

struct OrderPicker: View {
    @Binding var items : [OrderDeital]
    @Binding var showDeitalItem : Bool
    @Binding var selecteditem : ItemType
    
    var body: some View {
        VStack {
            HStack{
                OrderTitleView(title: "قم بإختيار طلبك", number: 2)
                Spacer()
            }
            HStack (spacing : 10){
                
                ForEach(ItemType.allCases , id : \.self){ order in
                    
                    OrderTypeView(orderType: order, selectedOrders: $items, showDeitalItem: $showDeitalItem, selecteditem: $selecteditem)
                    
                }
            }
        }
    }
}


struct OrderPicker_Previews: PreviewProvider {
    static var previews: some View {
        OrderPicker(items:.constant([]), showDeitalItem : .constant (true) , selecteditem : .constant(.tea))
            .environmentObject(AuthViewModel())
        
    }
}



struct OrderTypeView: View {
    var orderType : ItemType
    @Binding var selectedOrders : [OrderDeital]
    @Binding var showDeitalItem : Bool
    @Binding var selecteditem : ItemType
    
    var isSelectedOrder : Bool  {
        
        selectedOrders.filter({$0.item == orderType}).count == 1
    }
    
    var body: some View {
        VStack {
            OrderImgView(order: orderType)
            Text(orderType.title)
                .frame(width: 110 , height: 50)
                .multilineTextAlignment(.center)
                .font(.DinNextArabicMedium(size: 19))
                .foregroundColor(.appColor(.darkBlue) )
        }
        .background()
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12).stroke(style: StrokeStyle(lineWidth: isSelectedOrder ? 3 : 2))
                .foregroundColor(  isSelectedOrder ? .green : .gray)
                .opacity(isSelectedOrder ?  1 : 0.3)
        )
        .overlay(
            ZStack{
                
                if isSelectedOrder {
                    if orderType == .water {
                        
                        Button{
                            selectedOrders.removeAll(where: {$0.item == .water })
                            
                        }label:  {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .padding(1)
                                .offset(x: 4 )
                                .background()
                                .foregroundColor(.red)
                                .offset(y : -14)
                        }
                        
                    }else {
                        Button{
                            withAnimation(){
                                showDeitalItem = true
                                selecteditem = orderType
                            }
                        }label:  {
                            Image(systemName: "square.and.pencil")
                                .imageScale(.large)
                                .padding(1)
                                .background()
                                .foregroundColor(.appColor(.darkBlue))
                                .offset(x: 4 )
                                .offset(y : -14)
                        }
                    }
                }
            }
            ,alignment: .topLeading
        )
        .onTapGesture {
            
            if !isSelectedOrder && selectedOrders.count < 2 {
                
                selectedOrders.append(OrderDeital(item: orderType, orderID: "", type: "" , itemID: orderType.apiID, withMilk: false, sugarAmount: 0))
                
                if orderType != .water {
                    withAnimation(){
                        showDeitalItem = true
                        selecteditem = orderType
                    }
                }
            }
        }
        .scaleEffect( isSelectedOrder  ? 1.05 : 1)
        
        .animation(.easeOut(duration: 1))
    }
}



struct OrderTitleView: View {
    let title : String
    let number : Int
    var body: some View {
        HStack (spacing :10) {
            Image(systemName: "\(number).circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width : 30)
                .foregroundColor(Color.appColor(.darkBlue))
            
            Text(title)
                .font(.DinNextArabicBold(size: 18))
                .foregroundColor(Color("ncgr-blue"))
        }
        .padding(.leading , 30)
        
    }
}

struct OrderImgView: View {
    let order : ItemType
    var body: some View {
        ZStack {
            ZStack{
                Image(order.imgName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60 , height: 60)
                
            }
            .frame(width: 110 , height: 100)
            
        }
    }
}
