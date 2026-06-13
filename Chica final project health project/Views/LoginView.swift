
import SwiftUI
import AuthenticationServices  //
import SwiftData

//
struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("loggedInUserId")private var loggedInUserId:String = ""
    @State private var errorMessage: String = ""
    @State private var showSignup: Bool = false
    
    @StateObject private var vm = LoginViewModel()
    @FocusState private var focusedField: Field?

    enum Field { case email, password }
 
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
//                LinearGradient(
//                    colors: [Color(.systemBackground), Color.blue.opacity(0.06)],
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .ignoresSafeArea()
                
                Image("health5")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        // MARK: Header
                        VStack(spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color.blue.opacity(0.12))
                                    .frame(width: 88, height: 88)
                                Image(systemName: "heart.text.square.fill")
                                    .font(.system(size: 40))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [.blue, .cyan],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                            }
                            
                            Text("HealthTracker")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("Sign in to continue")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 40)
                        
                        // MARK: Form Card
                        VStack(spacing: 16) {
                            
                        
                            
                            // Email field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Email")
                                    .font(.caption.weight(.semibold))
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                    .tracking(0.5)
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "envelope")
                                        .foregroundColor(.black)
                                        .frame(width: 20)
                                    TextField("name@example.com", text: $vm.email)
                                        .keyboardType(.emailAddress)
                                        .textContentType(.emailAddress)
                                        .autocapitalization(.none)
                                        .autocorrectionDisabled()
                                        .focused($focusedField, equals: .email)
                                        .submitLabel(.next)
                                        .onSubmit { focusedField = .password }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 14)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            focusedField == .email ? Color.blue : Color.clear,
                                            lineWidth: 1.5
                                        )
                                )
                            }
                            
                            // Password field
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Password")
                                    .font(.caption.weight(.semibold))
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                    .tracking(0.5)
                                
                                HStack(spacing: 10) {
                                    Image(systemName: "lock")
                                        .foregroundColor(.secondary)
                                        .frame(width: 20)
                                    
                                    Group {
                                        if vm.isPasswordVisible {
                                            TextField("••••••••", text: $vm.password)
                                        } else {
                                            SecureField("••••••••", text: $vm.password)
                                        }
                                    }
                                    .textContentType(.password)
                                    .focused($focusedField, equals: .password)
                                    .submitLabel(.go)
                                    .onSubmit { vm.login() }
                                    
                                    Button(action: { vm.isPasswordVisible.toggle() }) {
                                        Image(systemName: vm.isPasswordVisible ? "eye.slash" : "eye")
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 14)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            focusedField == .password ? Color.blue : Color.clear,
                                            lineWidth: 1.5
                                        )
                                )
                            }
                            
                            // Forgot password
                            HStack {
                                Spacer()
                                Button("Forgot password?") {
                                    // Navigate to reset flow
                                }
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            }
                            
                            // Error message
                            if let error = vm.errorMessage {
                                HStack(spacing: 8) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .foregroundColor(.red)
                                    Text(error)
                                        .font(.subheadline)
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(Color.red.opacity(0.08))
                                .cornerRadius(10)
                            }
                            
                            // Sign In button
                            Button(action: performLogin) {
                                ZStack {
                                    if vm.isLoading {
                                        ProgressView()
                                            .tint(.white)
                                    } else {
                                        Text("Sign In")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(
                                    vm.isFormValid
                                    ? LinearGradient(colors: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                                    : LinearGradient(colors: [.gray.opacity(0.4), .gray.opacity(0.4)], startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(14)
                            }
                            .disabled(!vm.isFormValid || vm.isLoading)
                            
                            // Divider
                            HStack {
                                Rectangle().fill(Color(.separator)).frame(height: 0.5)
                                Text("or")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 8)
                                Rectangle().fill(Color(.separator)).frame(height: 0.5)
                            }
                            .padding(.vertical, 4)
                            
                            // Sign in with Apple
                            SignInWithAppleButton(.signIn) { request in
                                request.requestedScopes = [.fullName, .email]
                            } onCompletion: { result in
                                vm.loginWithApple(result)
                            }
                            .signInWithAppleButtonStyle(.black)
                            .frame(height: 52)
                            .cornerRadius(14)
                        }
                        .padding(24)
                        .background(Color(.systemBackground))
                        .cornerRadius(24)
                        .shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: 4)
                        .padding(.horizontal, 20)
                        
                        // Sign up link
                        HStack(spacing: 4) {
                            Text("Don't have an account?")
                                .foregroundColor(.black)// was secondary
                            Button("Sign up") {
                                showSignup = true
                            }
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                        }
                        .font(.subheadline)
                        .padding(.top, 24)
                        .padding(.bottom, 40)
                    }
                    .padding(.horizontal, 50)
                }
                .scrollDismissesKeyboard(.interactively)
            } // zstack
            .navigationDestination(isPresented: $showSignup) {
                SignupView()
            }
        }
        // Navigate when logged in
//        .fullScreenCover(isPresented: $vm.isLoggedIn) {
//            MainView() // Replace with your main app view
//        }
    }
    
    func hideError() {
        errorMessage = ""
    }
    
    func performLogin() {
        // validations
        guard !vm.email.isEmpty else {
            errorMessage = "Email is required"
            return
        }
        
        guard vm.password.count >= 6 else {
            errorMessage = "Password must have at least 6 characters"
            return
        }
        
        // check the email
        let userEmail = vm.email
        let descriptor = FetchDescriptor<User>(
            predicate: #Predicate<User> {
                $0.email == userEmail
            }
        )
        
        guard let users = try? modelContext.fetch(descriptor), let user = users.first else {
            errorMessage = "Invalid email"
            return
        }
        
        // check the password
        let hashedPassword = User.hashPassword(vm.password)
        guard hashedPassword == user.password else {
            errorMessage = "Invalid password"
            return
        }
        
        // login
        hideError()
        loggedInUserId = user.id.uuidString
    }
}
