//
//  CustomTextFiledValidation.swift
//  CafeteriaApp
//
//  Created by Reenad gh on 04/08/1444 AH.
//

import SwiftUI


struct UserNameTextFiledValidation: View {
    @Binding var text : String
    @State var borderColor : Color = .gray

    @State var isEditing: Bool = false {
        didSet {
            borderColor =  isValidEntring ? .green : .red
        }
    }
    
    @Binding var isValidInfo : Bool

    var  userNameValidations : [Validation] {
        
        return LogInValidation.init(userName: text ).userNameValidations
    }
    
    var isValidEntring : Bool {
        
        return LogInValidation.init(userName: text ).userNameValidations.filter({$0.state == .failure}).isEmpty
        
            
    }
    
    
     
    
    var body: some View {
        
        
        VStack {
            VStack (alignment: .leading , spacing : 10) {
                
                Text("إسم المستخدم")
                    .font(.DinNextArabicBold(size: 16))
                    .foregroundColor(Color("ncgr-blue"))
                
                HStack (spacing : 20){
                 
                    
                    TextField("اسم المستخدم", text: $text, onEditingChanged: {
                            isEditing = $0
                        
                    })

                    
                    .foregroundColor(Color("ncgr-purple"))
                    Spacer()
                    
                    
                }
                .padding(.horizontal , 20)
                .padding(.vertical , 15)
                .background(.white)
                .cornerRadius(20)
                .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor( isValidEntring ? .green :  borderColor).opacity(0.5)
                         
                )
                if isEditing {
                    VStack (alignment: .leading){
                        ForEach(userNameValidations) { validation in
                            if  validation.requirementType.displayedErrorMessage != "" {
                                HStack {
                                    Image(systemName: validation.state == .failure ?"xmark.circle.fill" : "checkmark.circle.fill")
                                        .foregroundColor(validation.state == .failure ? .red : .green)
                                    Text(validation.requirementType.displayedErrorMessage)
                                        .foregroundColor(validation.state == .failure ? .red : .green)
                                        .font(.DinNextArabicLight(size: 13))
                                }
                            }
                        }
                        .animation(.spring())

                    }
                    
                    .padding(.leading)
                }
          
            }
        }
        .padding(.horizontal , 25)

        
        
        
        
        
    }
}


struct UserNameTextFiledValidation_Previews: PreviewProvider {
    static var previews: some View {
        UserNameTextFiledValidation(text: .constant(""), isValidInfo: .constant(true))
    }
}


struct EmployeeIdTextFiledValidation: View {
    @Binding var text : String
    
    @State var borderColor : Color = .gray

    @State var isEditing: Bool = false {
        didSet {
            borderColor =  isValidEntring ? .green : .red
        }
    }

    @Binding var isValidInfo : Bool

    var employeeIdValidations : [Validation] {
        
        return LogInValidation.init(employeeId: text).employeeIdValidations
    }
    
    var isValidEntring : Bool {
        
        return LogInValidation.init(employeeId: text).employeeIdValidations.filter({$0.state == .failure}).isEmpty
    }
    
    
    var body: some View {
        
        
        VStack {
            
            VStack (alignment: .leading) {
                Text("الرقم الوظيفي")
                    .font(.DinNextArabicBold(size: 16))
                    .foregroundColor(Color("ncgr-blue"))
                HStack (spacing : 20){
                  
                    
                    TextField("الرقم الوظيفي", text: $text.max(6), onEditingChanged: {
                            isEditing = $0
                        
                    })
                    .keyboardType(.asciiCapableNumberPad)

                    
                    .foregroundColor(Color("ncgr-purple"))
                    Spacer()
                    
                    
                }
                .padding(.horizontal , 20)
                .padding(.vertical , 15)
                .background(.white)
                .cornerRadius(20)
                .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor(  isValidEntring ? .green :  borderColor ).opacity(0.5)
                         
                )
                if isEditing {
                    VStack (alignment: .leading){
                        ForEach(employeeIdValidations) { validation in
                            if  validation.requirementType.displayedErrorMessage != "" {
                                HStack {
                                    Image(systemName: validation.state == .failure ?"xmark.circle.fill" : "checkmark.circle.fill")
                                        .foregroundColor(validation.state == .failure ? .red : .green)
                                    Text(validation.requirementType.displayedErrorMessage)
                                        .foregroundColor(validation.state == .failure ? .red : .green)
                                        .font(.DinNextArabicLight(size: 13))
                                }
                            }
                        }
                    }

                    .padding(.leading)
                    .animation(.spring())
                }
          
            }
        }
        .padding(.horizontal , 25)

        
        
        
        
        
    }
}


struct PasswordTextFiledValidation: View {
    @Binding var text : String
    
    @State var borderColor : Color = .gray

    @State var isEditing: Bool = false {
        didSet {
            borderColor =  isValidEntring ? .green : .red
        }
    }
    @Binding var isValidInfo : Bool

    var passwordValidations : [Validation] {
        
        return LogInValidation.init(password: text).passwordValidations
    }
    
    var isValidEntring : Bool {
        
        return  LogInValidation.init(password: text).passwordValidations.filter({$0.state == .failure}).isEmpty
        
    
    }
    
    
    
//    var borderColor : Color {
//        
//        
//        
//        if (isEditing && isValidEntring) || isValidEntring {
//           
//        }else if isEditing && !isValidEntring {
//            return .red
//        }else {
//            return .gray
//        }
//    }
    
    var body: some View {
        
        
        VStack (alignment: .leading ){
            Text("الرقم السري")
                .font(.DinNextArabicBold(size: 16))
                .foregroundColor(Color("ncgr-blue"))
            VStack (alignment: .leading) {
                HStack (spacing : 20){
                    
                    ZStack {
                        SecureField("الرقم السري", text: $text)
                        
                        TextField("", text: $text, onEditingChanged: {
                            isEditing = $0

                        })
                           .foregroundColor(.clear)
                           .disableAutocorrection(true)
                           .keyboardType(.asciiCapable)
                        
                    }
                    
                    .foregroundColor(Color("ncgr-purple"))
                    Spacer()
                    
                    
                }
                .padding(.horizontal , 20)
                .padding(.vertical , 15)
                .background(.white)
                .cornerRadius(20)
                .shadow(color : Color.black.opacity(0.05) , radius: 1 , x: 0 , y : 6)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke().foregroundColor( isValidEntring ? .green :  borderColor).opacity(0.5)
                         
                )
                if isEditing {
                    VStack (alignment: .leading){
                        ForEach(passwordValidations) { validation in
                            if  validation.requirementType.displayedErrorMessage != "" {
                                HStack {
                                    Image(systemName: validation.state == .failure ?"xmark.circle.fill" : "checkmark.circle.fill")
                                        .foregroundColor(validation.state == .failure ? .red : .green)
                                    Text(validation.requirementType.displayedErrorMessage)
                                        .foregroundColor(validation.state == .failure ? .red : .green)
                                        .font(.DinNextArabicLight(size: 13))
                                }
                            }
                        }
                    }
                    .padding(.bottom , 180)
                    
                    .padding(.leading)
                }
          
            }
        }
        .padding(.horizontal , 25)

        
        
        
        
        
    }
}
