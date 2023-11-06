# WidgetConfigurationIntent

# I. Overview

Ở bài `ReadMe-OverviewWidget`, ta đã nói về tổng quát của `Widget`, ở phần body của `Widget`, ta có truyền 1 parameter `intent` đó là `ConfigurationAppIntent.self`, ở bài này ta sẽ đi sâu hơn về phần đó, bạn hãy nhìn ảnh dươí đây:

<a name="">

![](widgets/widget_configure.png)

Ta thấy ở phần này liệt kê các Option cho User lựa chọn, thì thằng `ConfigurationAppIntent` có nhiệm vụ chính là tạo phần đó. Ta thấy ở ảnh trên có 3 option, ta có thể tương tác và lựa chọn các option đó. Càn chú ý ở hơn phần `Background - Red đỏ`, ở đây ta có thể lựa chọn các màu `xanh, đỏ, cam, ...`. Đọc phần code dưới đây

```swift
struct ConfigurationAppIntent: WidgetConfigurationIntent {
    
    static var title: LocalizedStringResource = "Configuration viet123"
    static var description = IntentDescription("This is an viet widget.")

    // An example configurable parameter.
    @Parameter(title: "Backgroud color", default: BgColor.blue)
    var backgroudColor: BgColor
    
    @Parameter(title: "Backgroud color", default: "Hello")
    var name: String
    
    @Parameter(title: "Backgroud Siuuuu", default: "qq")
    var siu: String
}

enum BgColor: String, CaseIterable, AppEnum {
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "TypeDisplayRepresentation BgColor"
    
    static var caseDisplayRepresentations: [BgColor : DisplayRepresentation] = [
        .blue: "Blue xanh",
        .green: "Green xanh lá",
        .red: "Red đỏ",
        .orange: "Cam orange"
    ]
    
    case blue
    case green
    case red
    case orange
    
    var color: Color {
        switch self {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .red:
            return Color.red
        case .orange:
            return Color.orange
        }
    }
}
```

# II. Providing your app’s capabilities to system services

Để người dùng có thể tương tác với app từ bên ngoài như các `system service` như Siri, Spotlight,... `Apple` cung cấp cho ta một giải pháp đó là sử dụng `Intents`. `Intents` hoạt động như là cầu nối giữa code chúng ta và các ứng dụng dịch vụ đó. Mỗi `intent` đóng gói 1 action được lựa chọn vào app. 

## 2.1 Create an intent that provides a single app actionin page link

- Mỗi `intent` cung cấp thông tin mô tả về nó mà có thể được `Siri` và `Shourtcuts` có thể được sử dụng và thông báo. Để cung cấp một hành động ứng dụng cụ thể cho các dịch vụ hệ thống như Siri và ShortCuts, ta sẽ khai báo 1 struct và comform với `AppIntent`. Trong struct, ta sẽ khiển 2 thuộc tinhs bắt buộc đó là `title`, `title` sẽ cung cấp thông tin tới `Shortcuts`. Kèm theo đó ta cũng có thể implêmnt optional `description` để cung cấp behavior của `intent`. `ShortCut` là cái kiểu ảnh bên trên ý.

```swift
struct ExportAllTransactionsIntent: AppIntent {
    static var title: LocalizedStringResource = "Export all transactions"
    
    static var description =
        IntentDescription("Exports your transaction history as CSV data.")

    @Parameter(title: "Date")
    var date: Date?
}
```

## 2.2 Perform the action for your intentin page link

Để cung cấp tình năng cho `intent`, ta sẽ triển khai phương thức `perform()`. Hệ thống sẽ gọi tới function này.

```swift
func perform() async throws -> some IntentResult & ReturnsValue {
    let transactions = try await BudgetManager.shared
        .prepareExportOfTransactions(after: date, for: merchant)
        
    return .result(value: transactions)
}
```




# III. Reference

1. [Providing your app’s capabilities to system services](https://developer.apple.com/documentation/appintents/providing-your-app-s-capabilities-to-system-services)