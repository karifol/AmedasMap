//
//  ContentView.swift
//  AmedasMap
//
//  Created by 堀ノ内海斗 on 2024/06/11.
//

import SwiftUI


struct ContentView: View {

    // TextFielsdの文字を保持するための状態変数
    @State private var serchKey: String = ""
    
    let amedasData = AmedasData()
    
    var body: some View {
        VStack {
            // テキスト入力欄
//            TextField("AMeDAS地点名を入力してください", text: $serchKey)
//                .padding()
            ZStack(alignment: .bottomTrailing) {
                MapView(mapType: .hybrid, amedasList: amedasData.amedasList)

                // マップ
                Button {
                    
                } label: {
                    Image(systemName: "map.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 30)
                
                // 注釈
                Text("このデータは気象庁より取得したものです")
            }
        }
        .onAppear(){
            amedasData.getAmedas()
        }
    }
}

#Preview {
    ContentView()
}
