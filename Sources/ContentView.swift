import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var isCalling = false
    @State private var countdown = 3
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            if isCalling {
                VStack(spacing: 40) {
                    Text("Входящий вызов")
                        .font(.title)
                        .foregroundColor(.white)
                    Text("Алексей")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(.white)
                    HStack(spacing: 80) {
                        Button(action: endCall) {
                            Image(systemName: "phone.down.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                                .padding(28)
                                .background(Color.red)
                                .clipShape(Circle())
                        }
                        Button(action: endCall) {
                            Image(systemName: "phone.fill")
                                .font(.system(size: 36))
                                .foregroundColor(.white)
                                .padding(28)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                    }
                }
            } else {
                VStack(spacing: 24) {
                    Text("Fake Call")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Button("Начать фейковый звонок") {
                        startFakeCall()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
        }
        .onAppear {
            try? AVAudioSession.sharedInstance().setCategory(.playback)
            try? AVAudioSession.sharedInstance().setActive(true)
        }
    }

    func startFakeCall() {
        countdown = 3
        isCalling = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
            if countdown > 1 {
                countdown -= 1
            } else {
                t.invalidate()
                isCalling = true
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
                    if isCalling {
                        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    }
                }
            }
        }
    }

    func endCall() {
        isCalling = false
        timer?.invalidate()
    }
}