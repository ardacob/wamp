# WAMP

**Winamp'tan esinlenen yerel müzik oynatıcı.** Arda Çobanoğlu tarafından Codex ile geliştirilir. Koyu metalik görünüm, yeşil ekran ve klasik oynatma kontrollerini macOS uygulamasında ve tarayıcıda sunar.

[Web oynatıcı](https://wamp-klasik-mp3-calar.sykenix.chatgpt.site)

## Platform ve mimari

| Sürüm | Altyapı | Kullanım |
| --- | --- | --- |
| Web / çevrimdışı HTML | HTML, CSS, JavaScript; HTMLAudio ve Web Audio | `web/index.html` dosyasını tarayıcıda açın |
| macOS | Swift/AppKit uygulaması içinde WKWebView | macOS 12+, Apple Silicon ve Intel |

macOS paketi oynatıcı HTML'sini uygulama içinde taşır; çevrimiçi siteyi açan bir kısayol değildir. Mevcut uygulama metadata'sı **1.0 / Build 1**'dir.

## Özellikler

- Çoklu yerel ses dosyası ekleme ve çalma listesi.
- Web sürümünde sürükleyip bırakma.
- Oynat/duraklat, durdur, önceki/sonraki parça.
- Parça konum çubuğu ve ses düzeyi denetimi.
- **SHUF** ile karışık çalma, **REP** ile liste tekrarı.
- Parça seçme ve çalma listesini temizleme.
- Web Audio tabanlı spektrum görselleştirmesi.
- Klavyede **Space** ile oynat/duraklat; sol/sağ oklarla 5 saniye gezinme.
- macOS'ta yerel dosya seçme paneli, pencere küçültme ve kapatma.

## Dosyalar ve gizlilik

Dosyalar HTMLAudio tarafından yerel olarak açılır; oynatıcı medya dosyalarını bir sunucuya yüklemez. Parçalara geçici object URL'ler ile erişilir. macOS kabuğu dosya ve `about:` dışındaki gezinmeleri engeller.

Çalma listesi uygulama oturumunun belleğinde tutulur; kalıcı medya kütüphanesi veya yeniden açıldığında listeyi geri yükleme yoktur. Listeyi temizlemek kaynak dosyaları diskten silmez.

## Biçim kapsamı

Dosya seçimi `audio/*`, MP3, M4A, WAV, OGG ve FLAC uzantılarını kabul eder. **Bir dosyanın seçilebilmesi, oynatılabileceği anlamına gelmez:** gerçek çözümleme desteği tarayıcıya veya macOS WebKit'e bağlıdır. Winamp eklentileri, skin yükleme ve tam Winamp özellik uyumluluğu bulunmaz.

## Kullanım

1. **+ EKLE** ile dosyaları seçin veya web penceresine bırakın.
2. Listeden parçayı seçin; oynatma ve ses düzeyi kontrollerini kullanın.
3. Gerekirse karışık çalma/liste tekrarını açın.
4. **Temizle** ile mevcut oturum listesini kaldırın.

## macOS derleme

Xcode Command Line Tools kurulu bir Mac'te:

```sh
bash scripts/build-macos.sh
open outputs/WAMP.app
```

Betik macOS 12 hedefli arm64 ve x86_64 ikililerini birleştirir, HTML ve simgeyi pakete ekler ve ad-hoc imza uygular. Apple Developer dağıtım imzası/notarization yapmaz.

## Depo yapısı

- `web/index.html`: bağımsız oynatıcı arayüzü ve JavaScript mantığı.
- `macos/WAMP.swift`: pencere, WKWebView, dosya seçimi ve yerel pencere komutları.
- `macos/Info.plist`: uygulama metadata'sı.
- `assets/WAMP.icns`: uygulama simgesi.
- `scripts/build-macos.sh`: evrensel macOS geliştirme paketi.
- `docs/`: sohbetlerden derlenen gelişim geçmişi ve doğrulama kapsamı.

[Geliştirme geçmişi](docs/DEVELOPMENT-HISTORY.md) · [Doğrulama kaydı](docs/VALIDATION.md)

## Lisans ve marka

Bu aktarımda açık kaynak lisansı seçilmemiştir. WAMP bağımsız bir projedir; Winamp ile resmi bağlantı veya tam özellik uyumluluğu iddia etmez.
