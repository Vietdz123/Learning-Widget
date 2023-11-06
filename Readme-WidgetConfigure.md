# Making a configurable widget


# I. Overview

Để giúp người dùng có thể dễ dàng truy cập thông tin phù hợp nhất, `widget` có thể cung cấp các properties có thể tùy chỉnh. `Widget` define các properties đó bằng cách sử dụng `AppIntent`. Các bước để thêm properties vào widget:
- Khai báo 1 sutrct mà comform với `WidgetConfigurationIntent`.
- Sử dụng [AppIntentTimelineProvider](https://developer.apple.com/documentation/widgetkit/appintenttimelineprovider) để cung cấp timeline
- Thêm code vào `custom app intent` để cung cấp thêm data nêys các thuộc tính đó phụ thuộc vào `dynamic datta`.

# II. Add a custom app intent to your project

Để hiển thị các thông tin của nhân vật, ta cần cung cấp cách chọn nhân vật. 

```swift
struct SelectCharacterIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Select Character"
    static var description = IntentDescription("Selects the character to display information for.")

    @Parameter(title: "Character")
    var character: CharacterDetail

    init(character: CharacterDetail) {
        self.character = character
    }

    init() {
    }

}
```

Trong ví dụ trên ta thấy propery `character` sử dụng custom `CharacterDetail` type để đại diện cho nhân vật trong game. Để custom 1 kiểu dữ liệu, kiểu dữ liệu đó phải comform `AppEntity`.

```swift
struct CharacterDetail: AppEntity {
    let id: String
    let avatar: String
    let healthLevel: Double
    let heroType: String
    let isAvailable = true
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Character"
    static var defaultQuery = CharacterQuery()
            
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(avatar) \(id)")
    }


    static let allCharacters: [CharacterDetail] = [
        CharacterDetail(id: "Power Panda", avatar: "🐼", healthLevel: 0.14, heroType: "Forest Dweller"),
        CharacterDetail(id: "Unipony", avatar: "🦄", healthLevel: 0.67, heroType: "Free Rangers"),
        CharacterDetail(id: "Spouty", avatar: "🐳", healthLevel: 0.83, heroType: "Deep Sea Goer")
    ]
}
```

Bởi vì các nhân vật có thể thay đổi từ game này sang game khác, vì vậy ta thấy intent generates the list dynamically at runtime. `WidgetKit` sử dụng thuộc tính `defaultQuery` để truy cập vào `dynamic values`.

# III. Implement a query to provide dynamic values

Một số tác vụ mà `EntityQuery` thực hiện bao gồm:
- Mapping AppEntity identifiers to the corresponding entity instances.
- `Providing a list of suggested values when a person edits a widget.`
- Specifying a default value for a parameter.

Khi người dùng edit widget với custom intent mà cần cung cấp dynamic values, hệ thống sẽ query đối tượng `suggestedEntities() method to get the list of possible choices`.

```swift
struct CharacterQuery: EntityQuery {
    func entities(for identifiers: [CharacterDetail.ID]) async throws -> [CharacterDetail] {
        CharacterDetail.allCharacters.filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() async throws -> [CharacterDetail] {
        CharacterDetail.allCharacters.filter { $0.isAvailable }
    }
    
    func defaultResult() async -> CharacterDetail? {
        try? await suggestedEntities().first
    }
}
```

`With the configuration of the custom app intent done, a person can edit the widget to select a specific character to display.` Sau khi người dùng `edits the widget` và lựa chọn 1 nhân vật, bước tiếp theo ta cần kết hợp lựa chọn đó vào `widget's display`.

# IV. Handle customized values in your widget

Để hỗ trợ việc cấu hình các thuộc tính, `widget` sử dụng [AppIntentTimelineProvider](https://developer.apple.com/documentation/widgetkit/appintenttimelineprovider). 

```swift
struct CharacterDetailWidget: Widget {
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: SelectCharacterIntent.self,
            provider: CharacterDetailProvider()) { entry in
            CharacterDetailView(entry: entry)
        }
        .configurationDisplayName("Character Details")
        .description("Displays a character's health and other details")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
```

`SelectCharacterIntent` sẽ xác định các thuộc tính có thể được custom cho widget. The configuration uses CharacterDetailProvider to manage the timeline events for the widget. For more information about timeline providers, see [Keeping a widget up to date](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date) 

- Sau khi người dùng `edits widget`, `WidgetKit` sẽ pass các customized values vào provider khi yêu cầu timeline entries. Ở ví dụ dưới đây, `provider` sử dụng `defaultQuery` để tra cứu `CharacterDetail` với `character's id` ở phần intent, và sẽ tạo mới 1 timeline mới:

```swift
struct CharacterDetailProvider: AppIntentTimelineProvider {
    func timeline(for configuration: SelectCharacterIntent, in context: Context) async -> Timeline<CharacterDetailEntry> {
        // Create the timeline and return it. The .never reload policy indicates
        // that the containing app will use WidgetCenter methods to reload the
        // widget's timeline when the details change.
        let entry = CharacterDetailEntry(date: Date(), detail: configuration.character)
        let timeline = Timeline(entries: [entry], policy: .never)
        return timeline
    }
}
```

# IV. Reference