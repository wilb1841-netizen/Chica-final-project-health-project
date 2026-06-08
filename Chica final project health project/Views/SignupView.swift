import SwiftUI
struct SignupView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("health3")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.5))
                
                VStack(spacing: 20) {
                    // Header
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(.white)
                        
                        Text("Sign Up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text("Create an account")
                            .font(.subheadline)
                            .foregroundStyle(Color.white.opacity(0.7))
                    }
                    .padding(.bottom, 20)
                    
                    // Form
                    VStack(alignment: .leading, spacing: 12) {
                        Group {
                            Text("First Name")
                                .foregroundStyle(.white)
                            TextField("First Name", text: $firstName)
                                .padding()
                                .background(.white.opacity(0.7))
                                .cornerRadius(8)
                            
                            Text("Last Name")
                                .foregroundStyle(.white)
                            TextField("Last Name", text: $lastName)
                                .padding()
                                .background(.white.opacity(0.7))
                                .cornerRadius(8)
                            
                            Text("Email")
                                .foregroundStyle(.white)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .background(.white.opacity(0.7))
                                .cornerRadius(8)
                            
                            Text("Password")
                                .foregroundStyle(.white)
                            SecureField("Password", text: $password)
                                .autocapitalization(.none)
                                .padding()
                                .background(.white.opacity(0.7))
                                .cornerRadius(8)
                        }
                        .scrollContentBackground(.hidden)
                    }
                    .padding(.horizontal, 50)
                    
                    // Sign Up button
                    Button(action: {
                        print("Sign up tapped with: \(firstName) \(lastName), email: \(email)")
                    }) {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 50)
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Sign Up")
        }
    }
}

#Preview {
    SignupView()
}
