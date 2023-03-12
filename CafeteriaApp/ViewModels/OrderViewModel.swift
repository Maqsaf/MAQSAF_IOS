//
//  OrderViewModel.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 06/08/1444 AH.
//

import Foundation
import Supabase
import SwiftUI
import Realtime
enum coffeeType : String  , CaseIterable {
    
    case  nescafe = "نسكافية"
    case  amircan = "امريكية"
}

enum teaType : String , CaseIterable  {
    case  happag = "حبق"
    case  na3na3 = "نعناع"
    
}

enum OrderState : String  , CaseIterable {
    
    case  pending = "Pending"
    case  accepted = "Accepted"
    case  finished = "Finished"
    case  rejectd = "Rejected"
    
    
    var descretion : String {
        
        switch self {
        case .pending:
            return "بإنتظار مزود الخدمة"
        case .accepted:
            return "تحت التحضير"
        case .finished :
            return "تم التسليم"
        case .rejectd:
            return "تم الرفض"
        }
    }
    
}

enum  ZoonColor : String ,  CaseIterable {
    case green = "Green"
    case yellow = "Yellow"
    case blue = "Blue"
    case orange = "Orange"
    case none = "none"
    
    
    var color : Color {
        
        switch self {
        case .green:
            return .green
        case .yellow:
            return .yellow
        case .blue:
            return .blue
        case .orange:
            return .orange
            
        case .none:
            return .clear
        }
    }
    var title : String {
        
        switch self {
        case .green:
            return "المنطقة الخضراء"
        case .yellow:
            return "المنطقة الصفراء"
        case .blue:
            return "المنطقة الزرقاء"
        case .orange:
            return "المنطقة البرتقالية"
            
        case .none:
            return ""
        }
    }
}


enum  ItemType : String ,  CaseIterable {
    case tea = "Tea"
    case coffee = "Coffee"
    case water = "Water"
    
    var title : String {
        
        switch self {
        case .tea:
            return "الشاي"
        case .coffee:
            return "القهوة"
        case .water:
            return "الماء"
        }
    }
    
    var imgName : String {
        
        switch self {
        case .tea:
            return "tea"
        case .coffee:
            return "coffee"
        case .water:
            return "water"
        }
    }
    
    var apiID : String {
        
        switch self {
        case .tea:
            return "1bf93ba4-2021-4407-96b2-5b0e34bf1104"
        case .coffee:
            return "2dc49c92-c31d-4b19-b52b-40e656f941df"
        case .water:
            return "263256b9-e00b-4f1e-99f2-5d09152d5fc6"
        }
    }
    
    
    var extraAdded : [String] {
        switch self {
        case .tea:
            return teaType.allCases.map({$0.rawValue})
        case .coffee:
            return coffeeType.allCases.map({$0.rawValue})
        case .water:
            return []
        }
    }
}


struct Order {
    
    var id: String
    var orderNumber: Int
    var zoneColor : ZoonColor
    var  orderState : OrderState
    , createdAt, userID: String
    var items : [OrderDeital]
    
}

struct OrderDeital : Hashable {
    
    var item: ItemType ,
        orderID,type, itemID : String
    var withMilk: Bool
    var sugarAmount: Int
}


struct OrderEntity: Codable {
    var id: String
    let orderNumber: Int
    let zoneColor, orderState, createdAt, userID: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case zoneColor = "zone_color"
        case orderState = "order_state"
        case createdAt = "created_at"
        case userID = "user_id"
    }
}

// MARK: - Has
struct OrderDeitalEntity: Codable {
    let id, orderID, itemID, type: String
    let withMilk: Bool
    let sugarAmount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case orderID = "order_id"
        case itemID = "item_id"
        case type, withMilk
        case sugarAmount = "sugar_amount"
    }
}

typealias OrderResponce = [OrderEntity]


class OrderViewModel : ObservableObject {
    //
    @Published var order : Order = .init(id: "", orderNumber: 1, zoneColor: .none , orderState: .rejectd, createdAt: "", userID: "", items: [])
    
    
    @Published var isUserHasOrder : Bool = false

    
    let client = SupabaseClient(supabaseURL: Constants.api_url , supabaseKey: Constants.api_key )
    
    init(){
        
    }

    
    
    func fetchUserOrders(userId : String){
        

        let query2 = client.database
            .from("Order")
            .select() // keep it empty for all, else specify returned data
           .match(query: ["user_id" : userId])
        Task {
            do {
                let response: [Ticket] = try await query2.execute().value
                print("###  Selected user orders : \(response)")
                DispatchQueue.main.async {
                    
                }
            } catch {
                print("### Slecte Tickets Error: \(error)")
            }
        }
        
    }

    func addOrder(userId : String) {
        
        Task {
            do {
                
                let query = client.database
                    .from("Order")
                    .insert(values:  ["zone_color" : order.zoneColor.rawValue , "user_id" : userId ],
                            returning: .representation) // you will need to add this to return the added data
                //  .select(columns: "id") // specifiy which column names to be returned. Leave it empty for all columns
                // .single() // specify you want to return a single value.
                Task {
                    do {
                        let response: [OrderEntity] = try await query.execute().value
                        
                        
                        print("### Returned insert Order  : \(response)")
                        
                        DispatchQueue.main.async {
                            self.order.id = response[0].id
                            self.order.orderNumber = response[0].orderNumber
                            self.order.orderState = OrderState(rawValue: response[0].orderState) ?? .pending
                            self.order.userID = response[0].userID
                            self.addOrderDeitals()
                        }

                        


                    } catch {
                        print("### Insert Order  Error: \(error.localizedDescription)") }
                }
            } catch {
                print("### Token Error: \(error.localizedDescription)")
            }
        }
        
        
        
        
        
        //
        //        let query2 = client.database
        //                    .from("Order")
        //                    .select() // keep it empty for all, else specify returned data
        //                    .match(query: ["order_number" : 432])
        //                    //.single()
        //
        //        Task {
        //            do {
        //                let response: [Order] = try await query2.execute().value
        //                print("### Returned Order : \(response)")
        //            } catch {
        //                print("### Slecte Error: \(error)")
        //            }
        //        }
        
        
    }
    
    func updateOrderStatus(){
        
        
                let query2 = client.database
                            .from("Order")
                            .select() // keep it empty for all, else specify returned data
                            .match(query: ["order_number" : order.orderNumber])
                           // .single()
        
                Task {
                    do {
                        let response: [OrderEntity] = try await query2.execute().value
                        print("###  Updated Status Order : \(response)")
                        
                        DispatchQueue.main.async {
                            self.order.orderState = OrderState(rawValue: response[0].orderState) ?? .pending
                        }
                    } catch {
                        print("### Slecte Error: \(error)")
                    }
                }
        
    }
    private func addOrderDeitals(){
        
        
        
        
        for orderdetial  in order.items {
                    Task {
                        do {
        
        
                            let query = client.database
                                .from("have")
                                .insert(values:  ["order_id" : self.order.id , "item_id" : orderdetial.itemID , "type" : orderdetial.type , "withMilk" : orderdetial.withMilk.description , "sugar_amount" : orderdetial.sugarAmount.description] ,
                                        returning: .representation) // you will need to add this to return the added data
                            //                          .select(columns: "id") // specifiy which column names to be returned. Leave it empty for all columns
                            //                          .single() // specify you want to return a single value.
                            Task {
                                do {
                                    let response: Any = try await query.execute().value
                                    print("### Returned insert Order Have  : \(response)")
                                    DispatchQueue.main.async {
                                        self.isUserHasOrder = true
                                    }
                                } catch {
                                    print("### Insert Order Have Error: \(error.localizedDescription)") }
                            }
                        } catch {
                            print("### Token Error: \(error.localizedDescription)")
                        }
                    }
        
                }
    }
    
    
}
