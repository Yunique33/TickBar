#!/usr/bin/env python3
"""Генерация коротких мягких звуков-колокольчиков (WAV) для Mini Stopwatch."""
import math
import os
import struct
import wave

SR = 44100


def render(path, freq, dur, partials, decay, peak=0.26):
    """partials: список (отношение_частоты, амплитуда). decay: скорость затухания."""
    n = int(SR * dur)
    attack = int(SR * 0.005)          # короткая атака, чтобы не было щелчка
    release = int(SR * 0.02)
    samples = []
    amp_sum = sum(a for _, a in partials) or 1.0
    for i in range(n):
        t = i / SR
        v = 0.0
        for ratio, a in partials:
            # высокие партиалы затухают чуть быстрее — звук «нежнее»
            v += a * math.exp(-decay * ratio * t) * math.sin(2 * math.pi * freq * ratio * t)
        v /= amp_sum
        if i < attack:
            v *= i / attack
        if i > n - release:
            v *= (n - i) / release
        samples.append(int(max(-1.0, min(1.0, v * peak)) * 32767))

    with wave.open(path, "w") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(b"".join(struct.pack("<h", s) for s in samples))
    print("->", path)


def main():
    out = os.path.join(os.path.dirname(__file__), "sounds")
    os.makedirs(out, exist_ok=True)

    # имя файла = имя для NSSound(named:)
    render(os.path.join(out, "Ding.wav"),   1568, 0.55, [(1, 1.0), (2, 0.25)], 7)
    render(os.path.join(out, "Bell.wav"),    784, 0.70, [(1, 1.0), (2.01, 0.5), (3.0, 0.2)], 5)
    render(os.path.join(out, "Drop.wav"),   1318, 0.28, [(1, 1.0)], 14)
    render(os.path.join(out, "Glassy.wav"), 2093, 0.45, [(1, 1.0), (1.5, 0.4)], 9)
    render(os.path.join(out, "Sparkle.wav"),1760, 0.35, [(1, 1.0), (1.5, 0.5), (2.0, 0.25)], 11)
    render(os.path.join(out, "Soft.wav"),    587, 0.60, [(1, 1.0), (2, 0.12)], 6)
    render(os.path.join(out, "Chime.wav"),  1046, 0.60, [(1, 1.0), (2.76, 0.3), (5.4, 0.1)], 6)


if __name__ == "__main__":
    main()
