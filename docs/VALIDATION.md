# Doğrulama kapsamı

Geliştirme sohbetinde macOS dosya ekleme ve oynatma, Apple Silicon/Intel paket hazırlanması kayda geçmiştir. Kaynak incelemesinde liste, karışık çalma/tekrar, HTMLAudio, Web Audio, object URL ve yerel WKWebView kaynak yükleme bulunur.

Bu aktarım önceki oynatma kontrolünü yeniden yapılmış test gibi sunmaz. Dosya seçicide listelenen OGG/FLAC dahil uzantıların her tarayıcı/WebKit sürümünde çalışması doğrulanmış değildir. Liste kalıcılığı, Winamp plugin/skin desteği ve kalıcı medya kütüphanesi yoktur.

## 1 Ekim 2026 kaynak aktarımı kontrolü

Mac uygulaması bu depodaki betikle yeniden derlendi. İkili mimarileri: **x86_64 arm64**. Yerel ad-hoc imza `codesign --verify --deep --strict` ile doğrulandı. Bu oturumda GUI işlevleri ve mobil cihaz testi yeniden yapılmadı.
