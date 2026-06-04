
import SwiftUI
import AuthenticationServices
import Combine

// MARK: - LoginViewModel

@MainActor
class LoginViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoggedIn: Bool = false
    @Published var resetEmailSent: Bool = false

    // MARK: - Private
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Validation

    var isEmailValid: Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$"#
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }

    var isPasswordValid: Bool {
        password.count >= 6
    }

    var isFormValid: Bool {
        isEmailValid && isPasswordValid
    }

    // MARK: - Email / Password Login

    func login() {
        guard isFormValid else {
            if !isEmailValid {
                errorMessage = "Please enter a valid email address."
            } else if !isPasswordValid {
                errorMessage = "Password must be at least 6 characters."
            }
            return
        }

        errorMessage = nil
        isLoading = true

        // --- Replace this block with your real auth call ---
        // e.g. FirebaseAuth: Auth.auth().signIn(withEmail:password:)
        // e.g. Supabase:     supabase.auth.signIn(email:password:)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.isLoading = false

            if self.email == "user@example.com" && self.password == "password" {
                self.isLoggedIn = true
            } else {
                self.errorMessage = "Incorrect email or password. Please try again."
            }
        }
        // ---------------------------------------------------
    }

    // MARK: - Sign In with Apple

    func loginWithApple(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential else {
                errorMessage = "Apple Sign In failed. Please try again."
                return
            }

            let userID    = credential.user
            let fullName  = credential.fullName
            let userEmail = credential.email

            print("Apple Sign In success:")
            print("  User ID:  \(userID)")
            print("  Name:     \(String(describing: fullName))")
            print("  Email:    \(String(describing: userEmail))")

            // --- Replace with your backend registration/login ---
            // e.g. send userID to your server to create/fetch account
            isLoggedIn = true
            // ----------------------------------------------------

        case .failure(let error):
            errorMessage = "Apple Sign In failed: \(error.localizedDescription)"
        }
    }

    // MARK: - Forgot Password

    func sendPasswordReset() {
        guard isEmailValid else {
            errorMessage = "Please enter a valid email address to reset your password."
            return
        }

        isLoading = true
        errorMessage = nil

        // --- Replace with your real password reset call ---
        // e.g. FirebaseAuth: Auth.auth().sendPasswordReset(withEmail: email)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isLoading = false
            self.resetEmailSent = true
        }
        // --------------------------------------------------
    }

    // MARK: - Helpers

    func clearForm() {
        email = ""
        password = ""
        errorMessage = nil
        isPasswordVisible = false
        resetEmailSent = false
    }

    func clearError() {
        errorMessage = nil
    }
}
