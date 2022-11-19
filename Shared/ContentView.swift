import SwiftUI
import GoogleMobileAds
import AppTrackingTransparency


struct AdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
//        banner.adUnitID = "ca-app-pub-1023155372875273/8634824522"
        
        // 以下は、バナー広告向けのテスト専用広告ユニットIDです。自身の広告ユニットIDと置き換えてください。
                banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}

struct ContentView: View {
    
    @State private var isActive = false
    @AppStorage("FirstLaunch") var firstLaunch = true
    @State var lap234Purchase : String = "false"

    @State var isDark = false
    @State var screen: CGSize?
    @State var currentTime = Time(sec: 15, min: 10, hour: 10)
    @ObservedObject var stopWatchManeger = StopWatchManeger()

    
    var receiver = Timer.publish(every: 1, on: .current, in: .default)
        .autoconnect()
    
    var body: some View {
        HStack{
            Spacer().frame(width: 25)

        VStack {
            Spacer()
            clockFace(isDark: $isDark, currentTime: $currentTime)
            Spacer()
            Text(getTime())
                Text(String(format: "%02d:%02d.%02d",currentTime.hour, currentTime.min, currentTime.sec))      // HH:mm:ssで表示する
                        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .heavy)))   //等幅フォントを指定（時刻変化でサイズが変わらないように
                        .foregroundColor(Color("Colormoji"))
        }
//        .border(Color.gray, width: 3)
            VStack{

                if lap234Purchase == "false"
                {
                    Spacer()
                    .frame(height: 5)
                    HStack{
                        AdView()
                        .frame(height: 50)
                        Spacer()
                        Appearance(isDark: $isDark)
                            .preferredColorScheme(isDark ? .dark : .light)
                        }.frame(width: (screen?.width ?? 100) * 0.60)
//                    .border(Color.pink, width: 3)
                }
                if lap234Purchase == "true"
                {
                    Spacer()
                    .frame(height: 50)
                    HStack{
                        Spacer()
                        .frame(height: 50)
                    Appearance(isDark: $isDark)
                        .preferredColorScheme(isDark ? .dark : .light)
                    }.frame(width: (screen?.width ?? 100) * 0.60)
                }
                Spacer()
                HStack{
                if stopWatchManeger.hour > 9 {
                    Text(String(format: "%02d:%02d:%02d.%02d", stopWatchManeger.hour, stopWatchManeger.minutes, stopWatchManeger.second, stopWatchManeger.milliSecond))
                        .font(Font.custom("HiraginoSans-W3", size: (screen?.width ?? 100) * 0.10))
                        .font(.system(size: 60, design: .monospaced))
                        .foregroundColor(Color("Colormoji"))

                } else if stopWatchManeger.hour > 0 {
                    Text(String(format: "%01d:%02d:%02d.%02d", stopWatchManeger.hour, stopWatchManeger.minutes, stopWatchManeger.second, stopWatchManeger.milliSecond))
                        .font(Font.custom("HiraginoSans-W3", size: (screen?.width ?? 100) * 0.11))
                        .font(.system(size: 65, design: .monospaced))
                        .foregroundColor(Color("Colormoji"))

                } else {
                    Text(String(format: "%02d:%02d.%02d", stopWatchManeger.minutes, stopWatchManeger.second, stopWatchManeger.milliSecond))
                        .font(Font.custom("HiraginoSans-W3", size: (screen?.width ?? 100) * 0.13))
                        .font(.system(size: 0, design: .monospaced))
                        .foregroundColor(Color("Colormoji"))

                }
                }.frame(width: (screen?.width ?? 100) * 0.60)
//                .border(Color.pink, width: 3)
                    Spacer()
                    .frame(height: (screen?.height ?? 100) * 0.08)

                HStack {
                    if stopWatchManeger.mode == .stop{
                        HStack{
                            Button(action: {
                                self.stopWatchManeger.start()
                            }){
                                TextView(label : "スタート")
                            }
                            Spacer().frame(width: 15)
                            Button(action: {

                            }){
                                TextView(label : "一時停止")
                            }

                            Spacer().frame(width: 15)
                            Button(action: {
                                stopWatchManeger.hour = 00
                                stopWatchManeger.minutes = 00
                                stopWatchManeger.second = 00
                                stopWatchManeger.milliSecond = 00
                                self.stopWatchManeger.stop()
                            }){
                                TextView(label : "リセット")
                            }
                        }
                    }
                    if stopWatchManeger.mode == .start{
                        HStack{
                            Button(action: {
                                self.stopWatchManeger.stop()
                                self.stopWatchManeger.start()
                            }){
                                TextView2(label : "スタート")
                            }
                            Spacer().frame(width: 15)
                            Button(action: {
                                self.stopWatchManeger.pause()
                            }){
                                TextView(label : "一時停止")
                            }
                            Spacer().frame(width: 15)
                            Button(action: {
                                stopWatchManeger.hour = 00
                                stopWatchManeger.minutes = 00
                                stopWatchManeger.second = 00
                                stopWatchManeger.milliSecond = 00
                                self.stopWatchManeger.stop()
                            }){
                                TextView(label : "リセット")
                            }
                        }
                    }
                    
                    if stopWatchManeger.mode == .pause{
                        HStack{
                            Button(action: {
                                self.stopWatchManeger.start()
                            }){
                                TextView(label : "再開")
                            }
                            Spacer().frame(width: 15)
                            
                            Button(action: {
                                self.stopWatchManeger.start()
                            }){
                                TextView2(label : "一時停止")
                            }.disabled(true)
                            Spacer().frame(width: 15)
                            Button(action: {
                                stopWatchManeger.hour = 00
                                stopWatchManeger.minutes = 00
                                stopWatchManeger.second = 00
                                stopWatchManeger.milliSecond = 00
                                self.stopWatchManeger.stop()
                            }){
                                TextView(label : "リセット")
                            }
                        }
                    }
                }
                Spacer()
            }
//            .border(Color.pink, width: 3)
            Spacer().frame(width: 25)
        }.ignoresSafeArea(edges: [.bottom])
//        .border(Color.blue, width: 3)
        .onAppear(perform: {
            screen = UIScreen.main.bounds.size
            getTimeComponents()
        })
        .onReceive(receiver) { _ in
            getTimeComponents()
        }
    }
    
    private func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "yyyy年MM月dd日(E)"
        return format.string(from: Date())
    }
    
    private func getTimeComponents() {
        let calender = Calendar.current
        let sec = calender.component(.second, from: Date())
        let min = calender.component(.minute, from: Date())
        let hour = calender.component(.hour, from: Date())
        withAnimation(Animation.linear(duration: 0.01)) {
            currentTime = Time(sec: sec, min: min, hour: hour)
        }
    }
}

struct clockFace: View {
    
    @State var screen: CGSize?
    @Binding var isDark: Bool
    @Binding var currentTime: Time
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(isDark ? .white : .black))
                .opacity(0.1)
            ForEach(0..<60) { second in
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (second % 5) == 0 ? 16 : 6)
                    .offset(y: (height - 150) / 2)
                    .rotationEffect(.init(degrees: Double(second) * 6))
            }
            
            Rectangle()
                .fill(Color.primary)
                .frame(width: 4, height: (height - 200) / 2)
                .offset(y: -(height - 260) / 4)
                .rotationEffect(.init(degrees: Double(currentTime.hour * 30 + Int(Double(currentTime.min) * 0.5))))
            
            Rectangle()
                .fill(Color.primary)
                .frame(width: 3, height: (height - 145) / 2)
                .offset(y: -(height - 195) / 4)
                .rotationEffect(.init(degrees: Double(currentTime.min * 6 + Int(Double(currentTime.sec) * 0.1))))

            Rectangle()
                .fill(Color.red)
                .frame(width: 2, height: (height - 120) / 2)
                .offset(y: -(height - 190) / 4)
                .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
            
            Circle()
                .fill(Color.primary)
                .frame(width: 15, height: 15)
        }
        .frame(width: (screen?.height ?? 100) * 2.6, height: (screen?.height ?? 100) * 2.6)
//        .border(Color.green, width: 3)
    }
}

struct Time {
    var sec: Int
    var min: Int
    var hour: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Appearance: View {
    
    @Binding var isDark: Bool
    var body: some View {
        Button(action: { isDark.toggle() }) {
            Image(systemName: isDark ? "sun.max.fill" : "moon.fill")
                .font(.system(size: 15))
                .foregroundColor(isDark ? .black : .white)
                .padding()
                .background(Color.primary)
                .clipShape(Circle())
        }
    }
}
