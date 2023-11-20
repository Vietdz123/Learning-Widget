# Deeplink with Widget

You can connect to content deep inside your app with universal links. Users open your app in a specified context, allowing them to accomplish their goals efficiently.

When users tap or click a universal link, the system redirects the link directly to your app without routing through Safari or your website. In addition, because universal links are standard HTTP or HTTPS links, one URL works for both your website and your app. If the user has not installed your app, the system opens the URL in Safari, allowing your website to handle it.

When users install your app, the system checks a file stored on your web server to verify that your website allows your app to open URLs on its behalf. Only you can store this file on your server, securing the association of your website and your app.

# I. Open Instagram from App

Khá đơn giản:

```swift
struct InstagramView: View {
    var body: some View {
        Button(action: {
            let instagramHooks = "instagram://user"
            let instagramUrl = URL(string: instagramHooks)
            if UIApplication.shared.canOpenURL(instagramUrl!) {
              UIApplication.shared.open(instagramUrl!)
            } else {
              //redirect to safari because the user doesn't have Instagram
              UIApplication.shared.open(URL(string: "http://instagram.com/")!)
            }
        }, label: {
            Text("Open instagram")
        })
    }
}
```

# II. Open Instagram from Widget

Để có thể open 1 app từ `Widget`, ta sẽ sử dụng như sau:

```swift
struct Wallpaper_GifWidgetEntryView : View {
    var entry: ProviderLock.Entry

    var nameButton: String {
        
        return GifWidgetViewModel.shared.playGif ? "Pause" : "Play"
        
    }
    
    var body: some View {
        ZStack {

            
            Image(uiImage: entry.image)
                .resizable()
                .frame(maxWidth: entry.size.width, maxHeight: entry.size.height)
    
            HStack(alignment: .center, spacing: 8) {
                Button(intent: PlayButtonIntent(id_name: "haha")) {
                    Text("\(nameButton)")
                        .foregroundColor(.red)
                }
                
                Link(destination: URL(string: "instagram://user")!,
                     label: {
                    Text("Open Instagram")
                })
            }
            

        }

    }
}
```

Ở đây ta có 1 `Text` được link với Instagram thông qua `Link()`, giờ ở bên `App` ta sẽ triển khai như sau:

```swift
@main
struct WallPaper_CoreDataApp: App {
    
    var body: some Scene {
        WindowGroup {
            InstagramView()
                .onOpenURL { instagramUrl in
                    DispatchQueue.main.async {
                        print("DEBUG: siuuu123")
                        if UIApplication.shared.canOpenURL(instagramUrl) {
                          UIApplication.shared.open(instagramUrl)
                        } else {
                          //redirect to safari because the user doesn't have Instagram
                          UIApplication.shared.open(URL(string: "http://instagram.com/")!)
                        }
                    }
      
                }
        }
    }
}
```

Lúc này khi nhấn vào `Link`, nó sẽ chuyển tới App thông qua `onOpenURL`, giờ ta chỉ cần open nó là được.

# V. Reference

1. [Allowing apps and websites to link to your content - Apple Docs](https://developer.apple.com/documentation/xcode/allowing-apps-and-websites-to-link-to-your-content?preferredLanguage=occ)
