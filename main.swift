import Cocoa

// MARK: - Локализация

enum L10n {
    // (код, родное название) — порядок отображения в меню
    static let languages: [(code: String, name: String)] = [
        ("en", "English"),
        ("ru", "Русский"),
        ("uk", "Українська"),
        ("tr", "Türkçe"),
        ("es", "Español"),
        ("de", "Deutsch"),
        ("fr", "Français"),
        ("crh", "Qırımtatarca"),
        ("crh-Cyrl", "Къырымтатарджа"),
    ]

    static var current: String {
        if let saved = UserDefaults.standard.string(forKey: "sw.lang"),
           languages.contains(where: { $0.code == saved }) {
            return saved
        }
        // по умолчанию — системный язык, иначе английский
        let pref = Locale.preferredLanguages.first?.prefix(2).lowercased() ?? "en"
        return languages.contains(where: { $0.code == pref }) ? pref : "en"
    }

    static func set(_ code: String) {
        UserDefaults.standard.set(code, forKey: "sw.lang")
    }

    // ключ -> (язык -> текст). en присутствует всегда (фолбэк).
    private static let table: [String: [String: String]] = [
        "reset": ["en": "Reset", "ru": "Сброс", "uk": "Скинути", "tr": "Sıfırla",
                  "es": "Reiniciar", "de": "Zurücksetzen", "fr": "Réinitialiser", "crh": "Sıfırla", "crh-Cyrl": "Сыфырла"],
        "change_time": ["en": "Adjust time", "ru": "Изменить время", "uk": "Змінити час", "tr": "Zamanı değiştir",
                        "es": "Ajustar tiempo", "de": "Zeit anpassen", "fr": "Ajuster le temps", "crh": "Vaqıtnı deñiştir", "crh-Cyrl": "Вакъытны денъиштир"],
        "sound": ["en": "Sound", "ru": "Звук", "uk": "Звук", "tr": "Ses",
                  "es": "Sonido", "de": "Ton", "fr": "Son", "crh": "Ses", "crh-Cyrl": "Сес"],
        "language": ["en": "Language", "ru": "Язык", "uk": "Мова", "tr": "Dil",
                     "es": "Idioma", "de": "Sprache", "fr": "Langue", "crh": "Til", "crh-Cyrl": "Тиль"],
        "launch_login": ["en": "Launch at login", "ru": "Запускать при входе", "uk": "Запускати під час входу", "tr": "Girişte başlat",
                         "es": "Iniciar al arrancar", "de": "Beim Anmelden starten", "fr": "Lancer à l’ouverture", "crh": "Kirişte başlat", "crh-Cyrl": "Кириште башлат"],
        "quit": ["en": "Quit", "ru": "Выход", "uk": "Вихід", "tr": "Çıkış",
                 "es": "Salir", "de": "Beenden", "fr": "Quitter", "crh": "Çıqış", "crh-Cyrl": "Чыкъыш"],
        "system": ["en": "system", "ru": "системный", "uk": "системний", "tr": "sistem",
                   "es": "sistema", "de": "System", "fr": "système", "crh": "sistem", "crh-Cyrl": "систем"],
        "min": ["en": "min", "ru": "мин", "uk": "хв", "tr": "dk",
                "es": "min", "de": "Min", "fr": "min", "crh": "daqqa", "crh-Cyrl": "дакъкъа"],
        "hour": ["en": "h", "ru": "ч", "uk": "год", "tr": "sa",
                 "es": "h", "de": "Std", "fr": "h", "crh": "saat", "crh-Cyrl": "саат"],
        // названия звуков
        "no_sound": ["en": "No sound", "ru": "Без звука", "uk": "Без звуку", "tr": "Sessiz",
                     "es": "Sin sonido", "de": "Kein Ton", "fr": "Aucun son", "crh": "Sessiz", "crh-Cyrl": "Сессиз"],
        "drop": ["en": "Drop", "ru": "Капля", "uk": "Крапля", "tr": "Damla",
                 "es": "Gota", "de": "Tropfen", "fr": "Goutte", "crh": "Tamçı", "crh-Cyrl": "Тамчы"],
        "ding": ["en": "Ding", "ru": "Дзинь", "uk": "Дзень", "tr": "Çın",
                 "es": "Tintín", "de": "Kling", "fr": "Ding", "crh": "Çıñ", "crh-Cyrl": "Чынъ"],
        "bell": ["en": "Bell", "ru": "Колокольчик", "uk": "Дзвіночок", "tr": "Zil",
                 "es": "Campana", "de": "Glocke", "fr": "Cloche", "crh": "Qoñğıraw", "crh-Cyrl": "Къонъгъырав"],
        "glassy": ["en": "Glass", "ru": "Стекло", "uk": "Скло", "tr": "Cam",
                   "es": "Cristal", "de": "Glas", "fr": "Verre", "crh": "Cam", "crh-Cyrl": "Джам"],
        "sparkle": ["en": "Sparkle", "ru": "Звёздочка", "uk": "Зірочка", "tr": "Parıltı",
                    "es": "Destello", "de": "Funkeln", "fr": "Étincelle", "crh": "Yıldızçıq", "crh-Cyrl": "Йылдызчыкъ"],
        "chime": ["en": "Chime", "ru": "Перезвон", "uk": "Передзвін", "tr": "Çıngırak",
                  "es": "Carillón", "de": "Glockenspiel", "fr": "Carillon", "crh": "Çañ", "crh-Cyrl": "Чанъ"],
        "soft": ["en": "Soft", "ru": "Мягкий", "uk": "М’який", "tr": "Yumuşak",
                 "es": "Suave", "de": "Sanft", "fr": "Doux", "crh": "Yımşaq", "crh-Cyrl": "Йымшакъ"],
    ]

    static func t(_ key: String) -> String {
        let row = table[key]
        return row?[current] ?? row?["en"] ?? key
    }
}

func t(_ key: String) -> String { L10n.t(key) }

// MARK: - Автозапуск при входе в систему (LaunchAgent)

enum LoginItem {
    static let label = "bar.tick.tickbar"

    static var plistURL: URL {
        FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/LaunchAgents/\(label).plist")
    }

    static var isEnabled: Bool {
        FileManager.default.fileExists(atPath: plistURL.path)
    }

    static func setEnabled(_ on: Bool) {
        let fm = FileManager.default
        try? fm.createDirectory(at: plistURL.deletingLastPathComponent(),
                                withIntermediateDirectories: true)
        if on {
            guard let exec = Bundle.main.executablePath else { return }
            let dict: [String: Any] = [
                "Label": label,
                "ProgramArguments": [exec],
                "RunAtLoad": true,
            ]
            if let data = try? PropertyListSerialization.data(
                fromPropertyList: dict, format: .xml, options: 0) {
                try? data.write(to: plistURL)
            }
        } else {
            try? fm.removeItem(at: plistURL)
            // если уже загружен в текущей сессии — выгрузить
            let p = Process()
            p.launchPath = "/bin/launchctl"
            p.arguments = ["bootout", "gui/\(getuid())/\(label)"]
            try? p.run(); p.waitUntilExit()
        }
    }
}

// MARK: - Модель секундомера с сохранением состояния

final class StopwatchModel {
    private let kAccumulated = "sw.accumulated"   // накопленное время (сек) вне текущего сегмента
    private let kIsRunning   = "sw.isRunning"     // шёл ли отсчёт на момент выхода

    private(set) var accumulated: TimeInterval = 0
    private(set) var startDate: Date?           // != nil => идёт отсчёт

    var isRunning: Bool { startDate != nil }

    init() {
        let d = UserDefaults.standard
        accumulated = d.double(forKey: kAccumulated)
        // если был запущен — продолжаем отсчёт с текущего момента
        if d.bool(forKey: kIsRunning) {
            startDate = Date()
        }
    }

    var elapsed: TimeInterval {
        let segment = startDate.map { Date().timeIntervalSince($0) } ?? 0
        return max(0, accumulated + segment)
    }

    func toggle() {
        if let s = startDate {
            accumulated += Date().timeIntervalSince(s)
            startDate = nil
        } else {
            startDate = Date()
        }
        save()
    }

    func reset() {
        accumulated = 0
        startDate = nil
        save()
    }

    /// Сдвинуть показания на delta секунд (может быть отрицательным), не уходя ниже нуля.
    func adjust(_ delta: TimeInterval) {
        let segment = startDate.map { Date().timeIntervalSince($0) } ?? 0
        var total = accumulated + segment + delta
        if total < 0 { total = 0 }
        accumulated = total - segment
        save()
    }

    func save() {
        let d = UserDefaults.standard
        // храним суммарное время, чтобы при падении/выходе не потерять текущий сегмент
        let segment = startDate.map { Date().timeIntervalSince($0) } ?? 0
        if isRunning {
            // фиксируем накопленное + текущий сегмент, рестартуем точку отсчёта
            accumulated += segment
            startDate = Date()
        }
        d.set(accumulated, forKey: kAccumulated)
        d.set(isRunning, forKey: kIsRunning)
    }
}

// MARK: - Приложение

final class AppDelegate: NSObject, NSApplicationDelegate {
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    private let model = StopwatchModel()
    private var timer: Timer?
    private lazy var contextMenu = buildMenu()

    private var flashUntil: Date?                       // момент окончания вспышки
    // (ключ перевода, имя файла/системного звука для NSSound; "" — без звука)
    private let sounds: [(key: String, name: String)] = [
        ("no_sound", ""),
        ("drop", "Drop"),
        ("ding", "Ding"),
        ("bell", "Bell"),
        ("glassy", "Glassy"),
        ("sparkle", "Sparkle"),
        ("chime", "Chime"),
        ("soft", "Soft"),
        ("sys_pop", "Pop"),
        ("sys_glass", "Glass"),
        ("sys_tink", "Tink"),
    ]
    private func soundLabel(_ s: (key: String, name: String)) -> String {
        s.key.hasPrefix("sys_") ? "\(s.name) (\(t("system")))" : t(s.key)
    }
    private var currentSound = UserDefaults.standard.string(forKey: "sw.sound") ?? "Drop"

    private func playStartSound() {
        guard !currentSound.isEmpty else { return }
        let snd = NSSound(named: NSSound.Name(currentSound))
        snd?.stop()
        snd?.play()
    }

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        if let button = statusItem.button {
            button.font = NSFont.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
            button.target = self
            button.action = #selector(statusClicked)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }

        var tick = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.render()
            // автосохранение каждые ~3 c во время работы — на случай нештатного закрытия
            tick += 1
            if tick % 12 == 0 && self.model.isRunning {
                self.model.save()
            }
        }
        if let timer { RunLoop.main.add(timer, forMode: .common) }

        // подстраховка: сохранить, если приложение завершают/усыпляют
        NotificationCenter.default.addObserver(
            forName: NSApplication.willResignActiveNotification, object: nil, queue: .main
        ) { [weak self] _ in self?.model.save() }

        render()
    }

    func applicationWillTerminate(_ notification: Notification) {
        model.save()
    }

    // MARK: Отрисовка

    private func render() {
        guard let button = statusItem.button else { return }
        button.title = ""
        button.image = makeImage()
        button.imagePosition = .imageOnly
    }

    /// Рисуем содержимое статус-бара вручную: рамка + (иконка при работе) + время.
    private func makeImage() -> NSImage {
        let e = Int(model.elapsed)
        let h = e / 3600, m = (e % 3600) / 60, s = e % 60
        let text = h > 0
            ? String(format: "%d:%02d:%02d", h, m, s)
            : String(format: "%02d:%02d", m, s)

        let running = model.isRunning
        let flashing = flashUntil.map { Date() < $0 } ?? false
        // цифры всегда белые; акцент (рамка + иконка) светло-зелёный во время работы
        let accent = NSColor.white
        let lightGreen = NSColor(srgbRed: 0.20, green: 1.0, blue: 0.40, alpha: 1)

        // шрифт всегда одинаковый — размер и насыщенность не меняются
        let font = NSFont.monospacedDigitSystemFont(ofSize: NSFont.systemFontSize - 0.75, weight: .regular)
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: accent]
        let textSize = (text as NSString).size(withAttributes: attrs)

        let iconSize: CGFloat = running ? 14 : 0
        let iconGap: CGFloat  = running ? 3  : 0
        let hPad: CGFloat = 6
        let height = NSStatusBar.system.thickness
        let width  = ceil(iconSize + iconGap + textSize.width + hPad * 2)

        let img = NSImage(size: NSSize(width: width, height: height))
        img.lockFocus()

        // Рамка со скруглёнными углами
        let inset: CGFloat = 1.5
        let rect = NSRect(x: inset, y: inset, width: width - 2*inset, height: height - 2*inset)
        let border = NSBezierPath(roundedRect: rect, xRadius: 5, yRadius: 5)
        if flashing {
            (running ? lightGreen : .white).withAlphaComponent(0.22).setFill()
            border.fill()
        }
        border.lineWidth = 1.4
        if running {
            lightGreen.withAlphaComponent(0.95).setStroke()
        } else {
            NSColor.white.withAlphaComponent(0.45).setStroke()
        }
        border.stroke()

        var x = hPad
        // Иконка секундомера — только когда идёт отсчёт
        if running, let sym = NSImage(systemSymbolName: "stopwatch.fill", accessibilityDescription: nil) {
            let cfg = NSImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
            let base = sym.withSymbolConfiguration(cfg) ?? sym
            let icon = tinted(base, lightGreen)
            let iy = (height - iconSize) / 2
            icon.draw(in: NSRect(x: x, y: iy, width: iconSize, height: iconSize))
            x += iconSize + iconGap
        }

        let ty = (height - textSize.height) / 2
        (text as NSString).draw(at: NSPoint(x: x, y: ty), withAttributes: attrs)

        img.unlockFocus()
        img.isTemplate = false
        return img
    }

    private func tinted(_ image: NSImage, _ color: NSColor) -> NSImage {
        let copy = image.copy() as! NSImage
        copy.lockFocus()
        color.set()
        NSRect(origin: .zero, size: copy.size).fill(using: .sourceAtop)
        copy.unlockFocus()
        copy.isTemplate = false
        return copy
    }

    // MARK: Клики по иконке

    @objc private func statusClicked() {
        let event = NSApp.currentEvent
        let isRight = event?.type == .rightMouseUp
            || event?.modifierFlags.contains(.control) == true
        if isRight {
            statusItem.menu = contextMenu
            statusItem.button?.performClick(nil)   // показать меню
            statusItem.menu = nil                  // вернуть обработку кликов
        } else {
            model.toggle()
            if model.isRunning {                // звук только при включении
                playStartSound()
            }
            flashUntil = Date().addingTimeInterval(0.18)
            render()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.19) { [weak self] in self?.render() }
        }
    }

    // MARK: Меню

    private func buildMenu() -> NSMenu {
        let menu = NSMenu()

        menu.addItem(withTitle: t("reset"), action: #selector(doReset), keyEquivalent: "").target = self

        menu.addItem(.separator())

        let header = NSMenuItem(title: t("change_time"), action: nil, keyEquivalent: "")
        header.isEnabled = false
        menu.addItem(header)

        let adjItem = NSMenuItem()
        adjItem.view = makeAdjustView()
        menu.addItem(adjItem)

        menu.addItem(.separator())

        let sound = NSMenuItem(title: t("sound"), action: nil, keyEquivalent: "")
        let soundSub = NSMenu()
        for (i, s) in sounds.enumerated() {
            let it = soundSub.addItem(withTitle: soundLabel(s), action: #selector(selectSound(_:)), keyEquivalent: "")
            it.target = self
            it.tag = i
            it.state = (s.name == currentSound) ? .on : .off
        }
        sound.submenu = soundSub
        menu.addItem(sound)

        let lang = NSMenuItem(title: t("language"), action: nil, keyEquivalent: "")
        let langSub = NSMenu()
        for (i, l) in L10n.languages.enumerated() {
            let it = langSub.addItem(withTitle: l.name, action: #selector(selectLanguage(_:)), keyEquivalent: "")
            it.target = self
            it.tag = i
            it.state = (l.code == L10n.current) ? .on : .off
        }
        lang.submenu = langSub
        menu.addItem(lang)

        menu.addItem(.separator())

        let login = menu.addItem(withTitle: t("launch_login"), action: #selector(toggleLogin(_:)), keyEquivalent: "")
        login.target = self
        login.state = LoginItem.isEnabled ? .on : .off

        menu.addItem(.separator())
        menu.addItem(withTitle: t("quit"), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        return menu
    }

    @objc private func selectSound(_ sender: NSMenuItem) {
        currentSound = sounds[sender.tag].name
        UserDefaults.standard.set(currentSound, forKey: "sw.sound")
        sender.menu?.items.forEach { $0.state = ($0 == sender) ? .on : .off }
        if !currentSound.isEmpty {
            NSSound(named: NSSound.Name(currentSound))?.play()   // прослушать выбор
        }
    }

    @objc private func toggleLogin(_ sender: NSMenuItem) {
        LoginItem.setEnabled(!LoginItem.isEnabled)
        sender.state = LoginItem.isEnabled ? .on : .off
    }

    @objc private func selectLanguage(_ sender: NSMenuItem) {
        L10n.set(L10n.languages[sender.tag].code)
        contextMenu = buildMenu()   // перестроить меню на новом языке
    }

    @objc private func doReset() { model.reset(); render() }

    // MARK: Панель изменения времени (остаётся открытой при кликах)

    private func makeAdjustView() -> NSView {
        let incs: [(String, Int)] = [
            ("1 \(t("min"))", 60), ("5 \(t("min"))", 300),
            ("15 \(t("min"))", 900), ("1 \(t("hour"))", 3600),
        ]
        let rowH: CGFloat = 30
        let w: CGFloat = 200
        let topPad: CGFloat = 2
        let container = NSView(frame: NSRect(x: 0, y: 0, width: w, height: rowH * CGFloat(incs.count) + topPad))

        for (i, inc) in incs.enumerated() {
            let y = container.frame.height - topPad - rowH * CGFloat(i + 1)

            let label = NSTextField(labelWithString: inc.0)
            label.font = NSFont.menuFont(ofSize: 13)
            label.frame = NSRect(x: 18, y: y + 6, width: 70, height: 18)
            container.addSubview(label)

            let minus = NSButton(title: "−", target: self, action: #selector(stepMinus(_:)))
            minus.bezelStyle = .rounded
            minus.tag = inc.1
            minus.frame = NSRect(x: 96, y: y + 2, width: 44, height: rowH - 6)
            container.addSubview(minus)

            let plus = NSButton(title: "+", target: self, action: #selector(stepPlus(_:)))
            plus.bezelStyle = .rounded
            plus.tag = inc.1
            plus.frame = NSRect(x: 144, y: y + 2, width: 44, height: rowH - 6)
            container.addSubview(plus)
        }
        return container
    }

    @objc private func stepPlus(_ sender: NSButton)  { model.adjust(TimeInterval(sender.tag));  render() }
    @objc private func stepMinus(_ sender: NSButton) { model.adjust(-TimeInterval(sender.tag)); render() }
}

let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
