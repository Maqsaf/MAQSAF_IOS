//
//  ItemDeitalisView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 07/08/1444 AH.
//

import SwiftUI

struct ItemDeitalisView: View {
    @Binding var itemDitals : [OrderDeital]
    @Binding var selecteditemDital : OrderDeital
    @Binding var showView : Bool

    var extraAddedforType : [String] {
        return selecteditemDital.item.extraAdded
    }
    var body: some View {
        ZStack{
        
            VStack (alignment: .leading, spacing : 25){
                HStack {
                    Spacer()
                    Image(selecteditemDital.item.imgName)
                        .resizable()
                        .scaledToFit()
                    .frame(width: 150)
                    Spacer()
                }
                    Text("عدد ملاعق السكر")
                        .modifier(LabelOrderDitailModfire())
               
                SugarAmountView(sugarAmount: $selecteditemDital.sugarAmount)
            

                Text("إضافات مع \(selecteditemDital.item.title) : ")
                    .modifier(LabelOrderDitailModfire())
                
                ListBoolOptionCheck(isChecked: $selecteditemDital.withMilk, option: "حليب")
                
                Text(" نوع \(selecteditemDital.item.title) : ")
                    .modifier(LabelOrderDitailModfire())
                HStack {
                    ForEach(extraAddedforType , id : \.self) { option in
                        ListOptionCheck(selectedOption: $selecteditemDital.type , option: option)
                    }
                }
           
                VStack{
                    HStack{
                        Spacer()
                        Button {
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
                    Button {
                        itemDitals.removeAll(where: {$0.item == selecteditemDital.item })
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
    }
}

struct ItemDeitalisView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDeitalisView(itemDitals: .constant([]), selecteditemDital: .constant(.init(item: .coffee, orderID: "492", type: coffeeType.nescafe.rawValue, itemID: "123123", withMilk: true, sugarAmount: 3)), showView: .constant(true))
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
