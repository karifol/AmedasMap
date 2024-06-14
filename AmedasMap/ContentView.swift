//
//  ContentView.swift
//  AmedasMap
//
//  Created by 堀ノ内海斗 on 2024/06/11.
//

import SwiftUI

struct ContentView: View {
    let amedasData = AmedasData()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    MapView(mapType: .satellite, amedasList: amedasData.amedasList)
                        .ignoresSafeArea()
                }
                HStack {
                    Spacer()
                    // リンク
                    VStack {
                        Link("出典：気象庁", destination: URL(string: "https://www.jma.go.jp/jma/kishou/know/amedas/kaisetsu.html")!)
                        Text("2024年6月14日取得")
                    }
                    Spacer()
                }
                    .frame(maxWidth: .infinity)
            }
            VStack {
                Text("タップで詳細表示")
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                Spacer()
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
