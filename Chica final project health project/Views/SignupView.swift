import SwiftUI
import SwiftData

struct SignupView: View {
    
    @Environment(\.modelContext) private var modelContext
    @AppStorage("loggedInUserId") private var loggedInUserId: String = ""
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email:String = ""
    @State private var password: String = ""
    
    @State private var errorMessage:String = ""
    
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
                    VStack(spacing: 10) {
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
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .padding(.bottom, 30)
                    
                    // Form
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("First Name")
                            .foregroundStyle(.blue)
                        
                        TextField("First Name", text: $firstName)
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(8)
                        
                        Text("Last Name")
                            .foregroundStyle(.blue)
                        
                        TextField("Last Name", text: $lastName)
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(8)
                        
                        Text("Email")
                            .foregroundStyle(.blue)
                        
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(8)
                        
                        Text("Password")
                            .foregroundStyle(.blue)
                        
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .padding()
                            .background(.white.opacity(0.8))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 50)
                    
                    // Sign Up Button
                    Button { performSignup() } label: {
                        Text("Sign Up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundStyle(.black)
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 50)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
        }// navstack
    }
    
    
    private func hideError() {
        errorMessage = ""
    }
    
    
    func performSignup() {
        //data validations
        guard !firstName.isEmpty, !lastName.isEmpty else {
            errorMessage = "First and Last names are required"
            return
        }
        
        guard !email.isEmpty else {
            errorMessage = "Email is required"
            return
        }
        
        guard password.count >= 8 else {
            errorMessage = "Password must have at least 8 characters"
            return
        }
        
        // save the user in swift data
        hideError()
  // save the user
          let user = User(
              firstName: firstName,
              lastName: lastName,
              email: email,
              password_text: password
          )
          
          do {
              modelContext.insert(user)
              try modelContext.save()
              print("User Created!")
              
              // autologin
              loggedInUserId = user.id.uuidString
          }
          catch {
              errorMessage = "Unexpected error, please try again"
              print("Error saving user: \(error)")
          }
      }
        
    }




#Preview {
    SignupView()
}
