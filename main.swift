import Cocoa
import WebKit

class AppDelegate : NSObject, NSApplicationDelegate {
    let window: NSWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 
640, height: 480), styleMask: [.titled, .resizable, .closable, 
.miniaturizable], backing: .buffered, defer: true)
    let view: WKWebView = WKWebView()
    
    func applicationWillFinishLaunching(_ notification: Notification) {
        window.contentView = view
        URLSession.shared.dataTask(with: URL(string: 
"https://game.maj-soul.com/1/icon.png")!) { data, response, error in
            if let data = data {
                DispatchQueue.main.sync {
                    NSApp.applicationIconImage = NSImage(data: data)
                }
            }
        }.resume()
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        window.makeKeyAndOrderFront(self)
        view.load(URLRequest(url: URL(string: 
"https://game.maj-soul.com/1/")!))
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: 
NSApplication) -> Bool {
        return true
    }
}

let app = NSApplication.shared
let appDelegate = AppDelegate()
app.delegate = appDelegate
var psn = ProcessSerialNumber(highLongOfPSN: 0, lowLongOfPSN: 
UInt32(kCurrentProcess))
TransformProcessType(&psn, 
ProcessApplicationTransformState(kProcessTransformToForegroundApplication))
NSApp.activate(ignoringOtherApps: true)
app.run()

