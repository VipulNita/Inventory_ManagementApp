//
//  ContentView.swift
//  InventoryManagementApp
//
//  Created by vipul kumar on 22/08/24.
//
import SwiftUI

struct ContentView: View {
    @State private var shopName: String = ""
    @State private var ownerName: String = ""
    @State private var password: String = ""
    @State private var isSignedIn: Bool = false
    @State private var isLoginMode: Bool = true
    @State private var loginError: String? = nil

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(alignment: .center, spacing: 20) {
                    Text(isLoginMode ? "Login" : "Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    if !isLoginMode {
                        TextField("Enter Shop Name", text: $shopName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    TextField("Enter Owner's Name", text: $ownerName)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    SecureField("Enter Password", text: $password)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    if let error = loginError {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    }

                    NavigationLink(
                        destination: InventoryHomeView(shopName: shopName),
                        isActive: $isSignedIn
                    ) {
                        EmptyView()
                    }

                    Button(action: {
                        if isLoginMode {
                            login()
                        } else {
                            signUp()
                        }
                    }) {
                        Text(isLoginMode ? "Login" : "Sign Up")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                    .disabled(ownerName.isEmpty || password.isEmpty || (!isLoginMode && shopName.isEmpty))

                    Button(action: {
                        isLoginMode.toggle()
                        loginError = nil
                    }) {
                        Text(isLoginMode ? "Need an account? Sign Up" : "Have an account? Login")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .ignoresSafeArea()
        }
    }

    func signUp() {
        // Store credentials in UserDefaults
        UserDefaults.standard.set(shopName, forKey: "shopName")
        UserDefaults.standard.set(ownerName, forKey: "ownerName")
        UserDefaults.standard.set(password, forKey: "password")
        isSignedIn = true
    }

    func login() {
        // Retrieve credentials from UserDefaults
        let storedShopName = UserDefaults.standard.string(forKey: "shopName") ?? ""
        let storedOwnerName = UserDefaults.standard.string(forKey: "ownerName") ?? ""
        let storedPassword = UserDefaults.standard.string(forKey: "password") ?? ""

        if ownerName == storedOwnerName && password == storedPassword && shopName == storedShopName {
            isSignedIn = true
        } else {
            loginError = "Invalid credentials. Please try again."
        }
    }
}

#Preview {
    ContentView()
}



//import SwiftUI
//
//struct ContentView: View {
//    @State private var shopName: String = "" // State variable to store the shop name
//       
//    var body: some View {
//        VStack {
//            Image(systemName: "cart.fill")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Check Your Inventory !")
//        }
//        VStack {
//                   TextField("Enter shop name", text: $shopName) // Input field for shop name
//                       .padding()
//                       .textFieldStyle(RoundedBorderTextFieldStyle()) // Style for the input field
//                   
//                   Text("Shop Name: \(shopName)") // Display the entered shop name
//                       .font(.title)
//                       .padding()
//                   
//                   Spacer()
//               }
//        .padding()
//        .background(Color.yellow) // Set background color here
//                .ignoresSafeArea()
//    }
//}
//
//#Preview {
//    ContentView()
//}
