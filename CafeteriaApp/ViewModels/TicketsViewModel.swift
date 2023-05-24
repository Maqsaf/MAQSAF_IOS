//
//  TicketsViewModel.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 14/08/1444 AH.
//

import Foundation


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

struct Ticket: Codable  , Identifiable{
    let id, userID, priority, description: String
    let respond: String?
    let createdAt: String
    let ticketNumber: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case priority, description, respond
        case createdAt = "created_at"
        case ticketNumber = "ticket_number"
    }
}

class TicketsViewModel : ObservableObject {

    @Published var tickets : [Ticket] =  []
    @Published var error : Bool =  false
    @Published var isSessfulyAdded : Bool =  false

    
    var isUserHasTickets : Bool {
        return !tickets.isEmpty
    }
    
    var realTimeclient = RealtimeClient(endPoint:  Constants.api_url.description, params: ["apikey": Constants.api_key])

    let client = SupabaseClient(supabaseURL: Constants.api_url , supabaseKey: Constants.api_key )
    
    
    func addTicket(userId : String , desc : String) {
        
        guard !desc.isEmpty else { return }
        Task {
            do {
                    
                let query = client.database
                    .from("Ticket")
                    .insert(values:  ["user_id" : userId , "description" : desc ],
                            returning: .representation) // you will need to add this to return the added data
                  .select() // specifiy which column names to be returned. Leave it empty for all columns
                   .single() // specify you want to return a single value.
                Task {
                    do {
                        let response: Ticket = try await query.execute().value
                        print("### Returned insert Ticket  : \(response)")
                        DispatchQueue.main.async {
                            self.tickets.append(response)
                            self.isSessfulyAdded = true
                        }
                    } catch {
                        print("### Insert Ticket  Error: \(error.localizedDescription)") }
                    DispatchQueue.main.async {
                        self.error = true
                    }
                }
            }
        }
    }
    
    func fetchUserTickets(userId : String){
        

        let query2 = client.database
            .from("Ticket")
            .select() // keep it empty for all, else specify returned data
           .match(query: ["user_id" : userId])
        Task {
            do {
                let response: [Ticket] = try await query2.execute().value
                print("###  Selected user Tickts : \(response)")
                DispatchQueue.main.async {
                    self.tickets = response
                    
                }
            } catch {
                print("### Slecte Tickets Error: \(error)")
            }
        }
        
    }
 
}
