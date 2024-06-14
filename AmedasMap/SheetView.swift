//
//  SheetView.swift
//  AmedasMap
//
//  Created by 堀ノ内海斗 on 2024/06/12.
//

// https://www.jma.go.jp/jma/kishou/know/amedas/ame_master.pdf

import SwiftUI

struct SheetView: View {
    // 引数
    let area: String
    let id: Double
    let type: String
    let name: String
    let katakana: String
    let name_info: String
    let address: String
    let lat: Double
    let lon: Double
    let alt: Int
    let alt_wind: String
    let alt_temp: String
    let start: String
    let comment1: String
    let comment2: String

    private var machineType: String {
        if type == "四" {
            return "有線ロボット気象計"
        } else if type == "三" {
            return "有線ロボット気象計"
        } else if type == "官" {
            return "地上気象観測装置"
        } else if type == "雨" {
            return "有線ロボット雨量計"
        } else if type == "雪" {
            return "有線ロボット積雪計"
        }
        return ""
    }

    private var observeTypeList: [String] {
        if type == "四" {
            return ["降水量", "気温", "風向", "風速", "相対湿度（一部の観測所を除く）"]
        } else if type == "三" {
            return ["降水量", "気温", "風向","風速"]
        } else if type == "官" {
            return ["降水量", "気温", "風向", "風速", "日照時間", "相対湿度", "気圧（一部の観測所を除く)", "積雪の深さ（一部の観測所に限る）"]
        } else if type == "雨" {
            return ["降水量"]
        } else if type == "雪" {
            return ["積雪の深さ"]
        }
        return [""]
    }
    
    var body: some View {
        VStack {
            Text(katakana)
            Text(name)
                .font(.largeTitle)
                .padding(.bottom)
            
            VStack {
                Text("観測装置の種類")
                    .font(.title2)
                    .underline()
                Text(machineType)
            }
            .padding(.bottom)
            
            VStack {
                Text("観測種目")
                    .font(.title2)
                    .underline()
                VStack {
                    ForEach(observeTypeList, id: \.self) { observeType in
                        Text(observeType)
                    }
                }

            }
            .padding(.bottom)

            VStack {
                Text("所在地")
                    .font(.title2)
                    .underline()
                Text("住所 \(address)")
                Text("緯度 \(lat)")
                Text("経度 \(lon)")
            }
            .padding(.bottom)

            VStack {
                Text("高さ")
                    .font(.title2)
                    .underline()
                Text("海面上の高さ  \(alt)m")
                Text("風速計の地上の高さ  \(alt_wind)m")
                Text("温度計の地上の高さ  \(alt_temp)m")
            }
            .padding(.bottom)
        }
    }
}


#Preview {
    SheetView(
        area: "treset",
        id: 44046,
        type: "四",
        name: "小河内",
        katakana: "ｵｺﾞｳﾁ",
        name_info: "奥多摩町小河内",
        address: "西多摩郡奥多摩町原",
        lat: 46.2,
        lon: 134.2,
        alt: 530,
        alt_wind: "9.9",
        alt_temp: "1.5",
        start: "#昭51.12.15",
        comment1: "-",
        comment2: "-"
    )
}
