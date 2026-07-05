import Cocoa

let size = 1024
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: size, pixelsHigh: size,
                           bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true,
                           isPlanar: false, colorSpaceName: .deviceRGB,
                           bytesPerRow: 0, bitsPerPixel: 0)!

NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)

let S = CGFloat(size)

// Background: rounded square with a gradient
let pad: CGFloat = 76
let bgRect = NSRect(x: pad, y: pad, width: S - 2*pad, height: S - 2*pad)
let bgPath = NSBezierPath(roundedRect: bgRect, xRadius: 185, yRadius: 185)
let grad = NSGradient(starting: NSColor(srgbRed: 0.16, green: 0.18, blue: 0.22, alpha: 1),
                      ending:   NSColor(srgbRed: 0.06, green: 0.07, blue: 0.09, alpha: 1))!
grad.draw(in: bgPath, angle: -90)

let cx = S / 2
let cy = S / 2 - 28
let r: CGFloat = 268

// Top button (stem) of the stopwatch
NSColor.white.setFill()
NSBezierPath(roundedRect: NSRect(x: cx - 30, y: cy + r + 4, width: 60, height: 86),
             xRadius: 22, yRadius: 22).fill()
NSBezierPath(roundedRect: NSRect(x: cx - 92, y: cy + r + 70, width: 184, height: 58),
             xRadius: 28, yRadius: 28).fill()

// Body — white ring
NSColor.white.setStroke()
let body = NSBezierPath(ovalIn: NSRect(x: cx - r, y: cy - r, width: 2*r, height: 2*r))
body.lineWidth = 50
body.stroke()

// Hand — green
NSColor.systemGreen.setStroke()
let hand = NSBezierPath()
hand.move(to: NSPoint(x: cx, y: cy))
hand.line(to: NSPoint(x: cx + 118, y: cy + 158))
hand.lineWidth = 36
hand.lineCapStyle = .round
hand.stroke()

// Center dot
let dotR: CGFloat = 30
NSColor.systemGreen.setFill()
NSBezierPath(ovalIn: NSRect(x: cx - dotR, y: cy - dotR, width: 2*dotR, height: 2*dotR)).fill()

NSGraphicsContext.restoreGraphicsState()

let outPath = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "icon_1024.png"
let data = rep.representation(using: .png, properties: [:])!
try! data.write(to: URL(fileURLWithPath: outPath))
print("icon -> \(outPath)")
