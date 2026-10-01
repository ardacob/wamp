import AppKit
import WebKit

final class PlayerWindow: NSWindow {
    override func keyDown(with event: NSEvent) {
        if event.keyCode == 53 { // Escape
            makeFirstResponder(contentView)
            return
        }
        super.keyDown(with: event)
    }
}

final class AppDelegate: NSObject, NSApplicationDelegate, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    private var window: NSWindow!
    private var webView: WKWebView!

    func applicationDidFinishLaunching(_ notification: Notification) {
        let config = WKWebViewConfiguration()
        config.mediaTypesRequiringUserActionForPlayback = []
        config.userContentController.add(self, name: "window")
        config.userContentController.addUserScript(WKUserScript(source: """
            document.getElementById('minimize').onclick = () => window.webkit.messageHandlers.window.postMessage('minimize');
            document.getElementById('close').onclick = () => window.webkit.messageHandlers.window.postMessage('close');
            """, injectionTime: .atDocumentEnd, forMainFrameOnly: true))

        webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.underPageBackgroundColor = NSColor(calibratedRed: 0.07, green: 0.09, blue: 0.12, alpha: 1)

        window = PlayerWindow(
            contentRect: NSRect(x: 0, y: 0, width: 960, height: 720),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "WAMP — MP3 Player"
        window.minSize = NSSize(width: 520, height: 520)
        window.center()
        window.contentView = webView
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)

        guard let page = Bundle.main.url(forResource: "player", withExtension: "html") else {
            let alert = NSAlert()
            alert.messageText = "Oynatıcı açılamadı"
            alert.informativeText = "Uygulama dosyaları eksik. WAMP uygulamasını yeniden indirin."
            alert.runModal()
            NSApp.terminate(nil)
            return
        }
        webView.loadFileURL(page, allowingReadAccessTo: page.deletingLastPathComponent())
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }

    func userContentController(_ userContentController: WKUserContentController,
                               didReceive message: WKScriptMessage) {
        guard let command = message.body as? String else { return }
        switch command {
        case "minimize": window.miniaturize(nil)
        case "close": window.close()
        default: break
        }
    }

    func webView(_ webView: WKWebView,
                 runOpenPanelWith parameters: WKOpenPanelParameters,
                 initiatedByFrame frame: WKFrameInfo,
                 completionHandler: @escaping ([URL]?) -> Void) {
        let panel = NSOpenPanel()
        panel.title = "Müzik dosyaları ekle"
        panel.prompt = "Ekle"
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowsMultipleSelection = true
        panel.beginSheetModal(for: window) { result in
            completionHandler(result == .OK ? panel.urls : nil)
        }
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.isFileURL == true || navigationAction.request.url?.scheme == "about" {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }
}

let application = NSApplication.shared
application.setActivationPolicy(.regular)
let appDelegate = AppDelegate()
application.delegate = appDelegate
application.run()
