import UserNotifications
import Foundation

@MainActor
final class NotificationService {
    private var center: UNUserNotificationCenter? {
        Bundle.main.bundlePath.hasSuffix(".app") ? UNUserNotificationCenter.current() : nil
    }

    func requestPermission() async {
        guard let center else { return }
        _ = try? await center.requestAuthorization(options: [.alert, .sound])
    }

    func checkAndNotify(usage: UsageData) async {
        guard center != nil else { return }
        guard UserDefaults.standard.bool(forKey: "notificationsEnabled") else { return }

        await checkPeriod(usage.fiveHour, periodKey: "5h")
        await checkPeriod(usage.sevenDay, periodKey: "7d")
    }

    private func checkPeriod(_ period: UsagePeriod, periodKey: String) async {
        let thresholds = [100.0, 90.0, 75.0]

        for threshold in thresholds {
            let userDefaultKey = "notify\(periodKey)At\(Int(threshold))"
            guard objectExists(forKey: userDefaultKey)
                ? UserDefaults.standard.bool(forKey: userDefaultKey)
                : true
            else { continue }

            let notificationKey = "\(periodKey)_notified_\(Int(threshold))"

            if period.utilization >= threshold {
                if !UserDefaults.standard.bool(forKey: notificationKey) {
                    fireNotification(
                        title: "Claude API Limit Alert",
                        body: "\(periodKey.uppercased()) window: \(Int(period.utilization))% utilized",
                        threshold: Int(threshold)
                    )
                    UserDefaults.standard.set(true, forKey: notificationKey)
                }
                return
            }
        }

        thresholds.forEach { t in
            UserDefaults.standard.removeObject(forKey: "\(periodKey)_notified_\(Int(t))")
        }
    }

    private func fireNotification(title: String, body: String, threshold: Int) {
        guard let center else { return }
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        center.add(request)
    }

    private func objectExists(forKey key: String) -> Bool {
        UserDefaults.standard.object(forKey: key) != nil
    }
}
