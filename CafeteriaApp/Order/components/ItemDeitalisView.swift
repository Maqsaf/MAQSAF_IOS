//
//  ItemDeitalisView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 07/08/1444 AH.
//

import SwiftUI

struct ItemDeitalisView: View {
    @Binding var itemDitals : [OrderDeital]
    @Binding var itemType : ItemType
    @State var newIteam : OrderDeital = .init(item: .coffee, orderID: "", type: "" , itemID: "", withMilk: false, sugarAmount: 0)
    @Binding var showView : Bool

    var extraAddedforType : [String] {
        return itemType.extraAdded
    }
    
    var getSelectedItemIndex : Int {
        return itemDitals.firstIndex(where: {$0.item ==  itemType }) ?? -1
    }
    var isNewOrder : Bool {
        return !itemDitals.contains(where: {$0.item == self.itemType})
    }
    
    var body: some View {
        ZStack{
        
            VStack(alignment: .leading, spacing : 25){
                HStack {
                    Spacer()
                    Image(itemType.imgName)
                        .resizable()
                        .scaledToFit()
                    .frame(width: 150)
                    Spacer()
                }
                    Text("عدد ملاعق السكر")
                        .modifier(LabelOrderDitailModfire())
               
                SugarAmountView(sugarAmount: $newIteam.sugarAmount)
            

                Text("إضافات مع \(itemType.title) : ")
                    .modifier(LabelOrderDitailModfire())
                
                ListBoolOptionCheck(isChecked: $newIteam.withMilk, option: "حليب")
                
                Text(" نوع \(newIteam.item.title) : ")
                    .modifier(LabelOrderDitailModfire())
                HStack {
                    ForEach(extraAddedforType , id : \.self) { option in
                        ListOptionCheck(selectedOption: $newIteam.type , option: option)
                    }
                }
           
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            
                            if itemDitals.contains(where: {$0.item == self.itemType}) {
                                itemDitals[getSelectedItemIndex] = newIteam
                            }else {
                                itemDitals.append(newIteam)
                            }
                            showView = false

                        } label: {
                            Text("حفظ الطلب")
                                .foregroundColor(.white)
                                .font(.DinNextArabicMedium(size: 14))
                                .padding(.horizontal , 70)
                                .padding(.vertical , 8)

                                .background(Color.appColor(.darkBlue))
                                .cornerRadius(12)
                        }
                        Spacer()

                    }
                    
                    if !isNewOrder {
                        Button {
                            itemDitals.removeAll(where: {$0.item == newIteam.item })
                            showView = false
                        } label: {
                            Text("حذف الطلب")
                                .foregroundColor(.white)
                                .font(.DinNextArabicMedium(size: 14))
                                .padding(.horizontal , 70)
                                .padding(.vertical , 8)
                                .background(Color.red)
                                .cornerRadius(12)
                            
                        }
                    }
                }
                
                
            }
               .padding(20)
                .frame(width: UIScreen.main.bounds.width - 60)
                .frame(height: UIScreen.main.bounds.height -  UIScreen.main.bounds.height/6)
               .background()
               .cornerRadius(30)
               .overlay(
                
                Button{
                    showView = false
                }label: {
                   Image(systemName: "xmark")
                        .imageScale(.large)
                        .foregroundColor(.appColor(.darkBlue))
                        .padding(30)
                        
                    
                }
                ,alignment: .topTrailing
)
        }
        .frame(maxWidth : .infinity , maxHeight: .infinity)
        .background(Color.black.opacity(0.4))
        .onAppear {
            
            newIteam.item = itemType
            newIteam.itemID = itemType.apiID
            
            if !isNewOrder {
                newIteam = itemDitals[getSelectedItemIndex]
            }else {
                if itemType == .coffee {
                    newIteam.type = ItemType.coffee.extraAdded[1]
                }
            }
        }
    
    }
    
    
}

struct ItemDeitalisView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDeitalisView(itemDitals: .constant([]), itemType: .constant(.coffee), showView: .constant(true))
    }
}


struct LabelOrderDitailModfire: ViewModifier {
  // 2
  func body(content: Content) -> some View {
    content
      // 3
          .font(.DinNextArabicMedium(size: 17))
          .foregroundColor(Color("ncgr-blue"))
  }
}

struct SugarAmountView: View {
    
    @Binding var sugarAmount : Int
    
    func addSuger() {

        if self.sugarAmount < 5 {
            self.sugarAmount += 1
        }
    }
    func minSuger() {

        if self.sugarAmount > 0 {
            self.sugarAmount -= 1
        }
    }
    
    var body: some View {
        
        HStack (spacing: 15 ){
            Button {
                addSuger()
            } label: {
                Image(systemName: "plus")
                    .frame(width: 35 , height: 35)
                
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(style: StrokeStyle(lineWidth: 2)))
                    .foregroundColor(.appColor(.darkBlue))
            }
            Text("\(sugarAmount)")
            .font(.title3)
            .foregroundColor(.appColor(.darkBlue))
            Button {
                minSuger()
            } label: {
                Image(systemName: "minus")
                    .frame(width: 35 , height: 35)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(style: StrokeStyle(lineWidth: 2)))
                    .foregroundColor(.appColor(.darkBlue))
            }

        }
    }
}





struct  ListOptionCheck: View {
    
    @Binding var selectedOption : String
     let option : String

    var body: some View {
        
        HStack(spacing: 10 ){
            Image(systemName: selectedOption == option ? "circle.fill" : "circle")
                .foregroundColor(.appColor(.darkBlue))
            Text(option)
                .foregroundColor(.appColor(.darkBlue))
                .font(.DinNextArabicLight(size: 15))
        }
        .onTapGesture {
            selectedOption = option
        }
        .onAppear{
        
        }
    }
}


struct  ListBoolOptionCheck: View {
    
    @Binding var isChecked : Bool
    let option : String
    var body: some View {
        
        HStack(spacing: 10 ){
            Image(systemName: isChecked ? "circle.fill" : "circle")
                .foregroundColor(.appColor(.darkBlue))
            Text(option)
                .foregroundColor(.appColor(.darkBlue))
                .font(.DinNextArabicLight(size: 15))
        }
        .onTapGesture {
            isChecked.toggle()
        }
    }
}
