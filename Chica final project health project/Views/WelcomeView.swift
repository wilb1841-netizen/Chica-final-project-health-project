import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasSeenWelcome") private var hasSeenWelcome = false
    @State private var showSignup = false

    var body: some View {
        NavigationStack {
            ZStack {
                Image("health 4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                LinearGradient(
                    colors: [
                        .black.opacity(0.18),
                        .black.opacity(0.58)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {
                    Spacer()

                    VStack(alignment: .leading, spacing: 14) {
                        Image(systemName: "heart.text.square.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(.white.opacity(0.18))
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                        Text("HealthTracker")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Track your movement, sleep, nutrition, and daily goals in one calm place.")
                            .font(.title3)
                            .foregroundStyle(.white.opacity(0.88))
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    VStack(spacing: 12) {
                        Button {
                            hasSeenWelcome = true
                        } label: {
                            Label("Get Started", systemImage: "arrow.right")
                                .font(.headline)
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }

                        Button {
                            showSignup = true
                        } label: {
                            Label("Create Account", systemImage: "person.badge.plus")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 54)
                                .background(.white.opacity(0.18))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.white.opacity(0.35), lineWidth: 1)
                                )
                        }

                        Button("I already have an account") {
                            hasSeenWelcome = true
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.top, 4)
                    }
                }
                .padding(24)
            }
            .navigationDestination(isPresented: $showSignup) {
                SignupView()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
