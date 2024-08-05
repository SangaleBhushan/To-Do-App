//
//  AuthenticationView.swift
//  To-Do App
//
//  Created by siddhatech on 01/08/24.
//

import SwiftUI

struct AuthenticationView: View {
    @ObservedObject var viewModel: TaskViewModel
       @State private var username: String = ""
       @State private var password: String = ""
       @State private var isLogin: Bool = true

       var body: some View {
           VStack {
               TextField("Username", text: $username)
                   .padding()
                   .background(Color.gray.opacity(0.2))
                   .cornerRadius(10)
               SecureField("Password", text: $password)
                   .padding()
                   .background(Color.gray.opacity(0.2))
                   .cornerRadius(10)
               Button(action: {
                   if isLogin {
                       if viewModel.login(username: username, password: password) {
                           // login successful
                       } else {
                           // login failed
                       }
                   } else {
                       viewModel.register(username: username, password: password)
                   }
               }) {
                   Text(isLogin ? "Login" : "Register")
                       .foregroundColor(.white)
                       .padding()
                       .background(Color.blue)
                       .cornerRadius(10)
               }
               .padding()
               Button(action: {
                   isLogin.toggle()
               }) {
                   Text(isLogin ? "Switch to Register" : "Switch to Login")
               }
           }
           .padding()
       }
}

