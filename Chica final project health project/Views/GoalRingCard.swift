import SwiftUI

// MARK: - GoalRingCard

struct GoalRingCard: View {
    let goal: DailyGoal

    // Progress clamped between 0.0 and 1.0
    private var progress: Double {
        min(goal.current / goal.target, 1.0)
    }

    // Formatted display value (removes .0 for whole numbers)
    private func formatValue(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(value))
            : String(format: "%.1f", value)
    }

    var body: some View {
        VStack(spacing: 8) {

            // MARK: Ring
            ZStack {
                // Background track
                Circle()
                    .stroke(goal.color.opacity(0.15), lineWidth: 8)
                    .frame(width: 72, height: 72)

                // Progress arc
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        goal.color,
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .frame(width: 72, height: 72)
                    .rotationEffect(.degrees(-90))
                    .animation(.spring(response: 0.8, dampingFraction: 0.7), value: progress)

                // Percentage label inside ring
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(goal.color)
            }

            // MARK: Title
            Text(goal.title)
                .font(.caption.weight(.semibold))
                .foregroundColor(.primary)

            // MARK: Current / Target
            Text("\(formatValue(goal.current)) / \(formatValue(goal.target)) \(goal.unit)")
                .font(.caption2)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(width: 100)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// MARK: - Preview

#Preview {
    HStack(spacing: 16) {
        GoalRingCard(goal: DailyGoal(
            title: "Steps",
            current: 8342,
            target: 10000,
            unit: "steps",
            color: .blue
        ))
        GoalRingCard(goal: DailyGoal(
            title: "Water",
            current: 1.6,
            target: 2.5,
            unit: "L",
            color: .cyan
        ))
        GoalRingCard(goal: DailyGoal(
            title: "Sleep",
            current: 8.0,
            target: 8.0,
            unit: "hrs",
            color: .indigo
        ))
    }
    .padding()
}
