import SwiftUI

struct FirstLaunch: View {
    
    @Binding var isAActive: Bool
    @Binding var firstLaunch2: Bool
    @State var screen2: CGSize?
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color("akaruiYellow") , .pink.opacity(0.4)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
            HStack {
                Spacer().frame(height: 30)
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("【 アプリの特徴 】")
                        Spacer()
                    }
                    VStack(alignment: .leading){
                        Text("・「スタート」で計測を開始します。")
                        Spacer().frame(height: 10)
                        Text("・計測中に「リセット」を押すこと")
                        Text("　なく再度「スタート」を押すと、")
                        Text("　ゼロから計測を開始します。")
                        Spacer().frame(height: 10)
                        Text("　そのため連続した計時が可能です。")
                        
                    }.font(.system(size: (screen2?.width ?? 100) * 0.03, design: .default))
                    .frame(width: (screen2?.width ?? 100) * 0.5 , height: 250)
                    .border(Color.black, width: 2)
                    
                }.font(.title2)
                    .frame(width: (screen2?.width ?? 100) * 0.5)
                VStack{
                    Spacer().frame(height: 40)
                    VStack(alignment: .leading){
                    Text("ダウンロードありがとうございます。")
                        .font(.system(size: (screen2?.width ?? 100) * 0.025, design: .default))
                        .bold()
                    Spacer()
                    HStack{
                        Text("※右上の")
                        Image(systemName: "sun.max.fill")
                        Image(systemName: "moon.fill")
                        Text("ボタンで背景色")
                    }
                        Text(" が選べます。")
                    Spacer()
                    Text("※このアプリは横向きレイアウト")
                    Text(" 専用となっております。")
                    Spacer()
                    HStack{
                        Spacer()
                    Button(action: {
                        isAActive = false
                        firstLaunch2 = false
                    })
                    {
                        TextView4(label : "確認しました。")
                    }
                    .buttonStyle(MyButtonStyle2())
                        Spacer()
                    }}
                    Spacer()
                }.font(.title2)
                    .frame(width: (screen2?.width ?? 100) * 0.4)
                
             
                Spacer()
            }
                
                
               
                
                
                
        }
        }.onAppear {
            screen2 = UIScreen.main.bounds.size
        }
    }
}
