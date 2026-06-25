import SwiftUI

struct PaymentPlanView: View {
    @AppStorage("selectedPaymentPlan") private var selectedPaymentPlan: String = PaymentPlan.starter.id
    @State private var billingCycle: BillingCycle = .monthly

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 22) {
                    header
                    billingPicker

                    VStack(spacing: 14) {
                        ForEach(PaymentPlan.allCases) { plan in
                            PaymentPlanCard(
                                plan: plan,
                                billingCycle: billingCycle,
                                isSelected: selectedPaymentPlan == plan.id
                            ) {
                                selectedPaymentPlan = plan.id
                            }
                        }
                    }

                    paymentMethod
                    planNote
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Payment Plan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "creditcard.fill")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 2) {
                    Text("Choose your plan")
                        .font(.title2.bold())
                    Text("Upgrade your health tracking when you need more support.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    private var billingPicker: some View {
        Picker("Billing Cycle", selection: $billingCycle) {
            ForEach(BillingCycle.allCases) { cycle in
                Text(cycle.title).tag(cycle)
            }
        }
        .pickerStyle(.segmented)
    }

    private var paymentMethod: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Payment Method")

            HStack(spacing: 12) {
                Image(systemName: "wallet.pass.fill")
                    .foregroundStyle(.blue)
                    .frame(width: 34, height: 34)
                    .background(Color.blue.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 2) {
                    Text("Apple Pay")
                        .font(.headline)
                    Text("Fast checkout with your saved payment method.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }

    private var planNote: some View {
        Text("Plan selection is saved on this device. Connect StoreKit or your payment provider before accepting real payments.")
            .font(.footnote)
            .foregroundStyle(.secondary)
            .padding(.bottom, 8)
    }
}

private struct PaymentPlanCard: View {
    let plan: PaymentPlan
    let billingCycle: BillingCycle
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack(spacing: 8) {
                        Text(plan.title)
                            .font(.title3.bold())

                        if plan.isPopular {
                            Text("Popular")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green)
                                .clipShape(Capsule())
                        }
                    }

                    Text(plan.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text(plan.price(for: billingCycle))
                        .font(.title2.bold())
                    Text(billingCycle.priceSuffix)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                ForEach(plan.features, id: \.self) { feature in
                    Label(feature, systemImage: "checkmark.circle.fill")
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                        .labelStyle(.titleAndIcon)
                }
            }

            Button(action: action) {
                HStack {
                    Image(systemName: isSelected ? "checkmark" : "plus")
                    Text(isSelected ? "Current Plan" : "Choose Plan")
                }
                .font(.headline)
                .foregroundStyle(isSelected ? .white : .blue)
                .frame(maxWidth: .infinity)
                .frame(height: 46)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
        )
    }
}

private enum BillingCycle: String, CaseIterable, Identifiable {
    case monthly
    case yearly

    var id: String { rawValue }

    var title: String {
        switch self {
        case .monthly: return "Monthly"
        case .yearly: return "Yearly"
        }
    }

    var priceSuffix: String {
        switch self {
        case .monthly: return "per month"
        case .yearly: return "per year"
        }
    }
}

private enum PaymentPlan: String, CaseIterable, Identifiable {
    case starter
    case plus
    case premium

    var id: String { rawValue }

    var title: String {
        switch self {
        case .starter: return "Starter"
        case .plus: return "Plus"
        case .premium: return "Premium"
        }
    }

    var subtitle: String {
        switch self {
        case .starter: return "For basic personal tracking"
        case .plus: return "For building healthier routines"
        case .premium: return "For coaching and deeper insights"
        }
    }

    var features: [String] {
        switch self {
        case .starter:
            return ["Daily goals", "Activity tracking", "Sleep log"]
        case .plus:
            return ["Everything in Starter", "Weekly progress reports", "Nutrition insights"]
        case .premium:
            return ["Everything in Plus", "Personal health coaching", "Priority support"]
        }
    }

    var isPopular: Bool {
        self == .plus
    }

    func price(for billingCycle: BillingCycle) -> String {
        switch (self, billingCycle) {
        case (.starter, _): return "$0"
        case (.plus, .monthly): return "$7.99"
        case (.plus, .yearly): return "$79.99"
        case (.premium, .monthly): return "$14.99"
        case (.premium, .yearly): return "$149.99"
        }
    }
}

#Preview {
    PaymentPlanView()
}
