//
//  AuthModelView.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 02/08/1444 AH.
//



import SwiftUI
import Supabase


struct User : Codable {
   let id : String
   let userName : String
   let isProvider : Bool

    enum CodingKeys: String, CodingKey {

            case id = "id"
            case userName = "username"
            case isProvider = "isProvider"
    }
}

struct UserResponce: Codable {
    let id, username: String
    let isProvider: Bool
}

typealias UserResponceArray = [User]


class AuthViewModel : ObservableObject {
    
    @Published var user : User = .init(id: "", userName: "", isProvider: false)
    let client = SupabaseClient(supabaseURL: Constants.api_url , supabaseKey: Constants.api_key )
    @Published var isloading : Bool = false
    @Published var errorMessage : String = ""
    @Published var error : Bool = false


    init() {
        self.fetchUser()
    }
    
    func fetchUser(){
        
        guard let accessToken =  UserDefaults.standard.string(forKey: "accessToken") else { return}
        guard let refreshToken =  UserDefaults.standard.string(forKey: "refreshToken") else { return}

        Task {
          do {
              let session = try await client.auth.setSession(accessToken: accessToken, refreshToken: refreshToken)
              
              let query = client.database
                          .from("User")
                          .select() // keep it empty for all, else specify returned data
                          .match(query: ["id" : session.user.id])
                          .single()
              Task {
                  do {
                      let response: User = try await query.execute().value
                      print("### Returned User Fetch  : \(response)")
                      DispatchQueue.main.async {
                          self.user = response
                      }
                  } catch {
                      DispatchQueue.main.async {

                          print("### User Fetch Error: \(error.localizedDescription)")
                      }
                  }
              }              
          } catch {
              print("### Token Error: \(error.localizedDescription)")
          }
        }
        
    }

    
    func signUp(employeeId : String ,password : String , userName : String , isProvider : Bool = false  ){
        self.isloading = true

        Task {
          do {
              try await client.auth.signUp(phone: employeeId, password: password)
              let session = try await client.auth.session
              print("### Session Info: \(session.user.id)")
              DispatchQueue.main.async {
                  self.user = User(id: session.user.id.uuidString , userName: userName, isProvider: isProvider)
                  UserDefaults.standard.set(session.refreshToken, forKey: "refreshToken")
                  UserDefaults.standard.set(session.accessToken, forKey: "accessToken")
                  self.isloading = false
                  self.addUserToDataBase()
              }
          } catch {
              print("### Sign Up Error: \(error.localizedDescription)")
              
              DispatchQueue.main.async {
                  self.isloading = false
                  self.error = true
                  self.errorMessage = error.localizedDescription

              }
          }
        }
       
    }
    
    private func addUserToDataBase(){
        let query = client.database
                    .from("User")
                    .insert(values:  self.user,
                            returning: .representation) // you will need to add this to return the added data
                    .select(columns: "id") // specifiy which column names to be returned. Leave it empty for all columns
                    .single() // specify you want to return a single value.

        Task {
            do {
                let response: Any = try await query.execute().value
                print("### Returned: \(response)")
                
                DispatchQueue.main.async {
                    self.isloading = false

                }
            } catch {
                DispatchQueue.main.async {
                    self.isloading = false
                    self.error = true
                    self.errorMessage = "somthing went wrong !"

                }
                print("### Insert Error: \(error)")
            }
        }
    }
    
    
    func logIn(employeeId : String , password : String){
        
        isloading = true
        Task {
          do {
              try await client.auth.signIn(phone: employeeId, password: password)
              let session = try await client.auth.session
              UserDefaults.standard.set(session.refreshToken, forKey: "refreshToken")
              UserDefaults.standard.set(session.accessToken, forKey: "accessToken")
              print("### LogIn UserId : \(String(describing: session.user.phone))")
              self.fetchUser()
              DispatchQueue.main.async {
                  self.isloading = false
              }
          } catch {
              DispatchQueue.main.async {
                  self.isloading = false
                  self.error = true
                  self.errorMessage = "عفوا , يرجى ادخال بياناتك بشكل صحيح"

              }
              
              print("### Log In Error: \(error)")
              
          }
        }
    }
    
    
    func logOut() {
        print("### LogOut UserId 1 : )")
        self.user = .init(id: "", userName: "", isProvider: false)
                      UserDefaults.standard.set("", forKey: "refreshToken")
                      UserDefaults.standard.set("", forKey: "accessToken")
        self.isloading = false
        Task {
          do {
              let session = try await client.auth.session
              try await client.auth.signOut()

              print("### LogOut UserId : \(String(describing: session.user.phone))")
          } catch {
              print("### Sign out Error: \(error)")
          }
        }
    }
}
