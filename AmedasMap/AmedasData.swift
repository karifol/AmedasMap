//
//  AmedasData.swift
//  AmedasMap
//
//  Created by 堀ノ内海斗 on 2024/06/11.
//

import SwiftUI

// Identifiableプロトコルを利用して、アメダス情報をまとめる構造体
struct AmedasItem: Identifiable {
    let id = UUID()
    let name: String
    let lat: Double
    let lon: Double
}

// お菓子データ検索用のクラス
@Observable class AmedasData {

    // JSONのデータ構造
    typealias ResultJson = [String: Item]
    struct Item: Codable {
        let lat: Double
        let lon: Double
        let name: String
    }

    // お菓子のリスト
    var amedasList: [AmedasItem] = []
    
    // Web API検索用メソッド　第一引数：keyword　検索したいわーそ
    func getAmedas() {
        print("getAmedas")
        // Taskは非同期で処理を実行できる
        Task {
            // ここから先は非同期で実行される
            // 非同期でお菓子を検索する
            await fetchAmedas()
        }
    }

    // 非同期でお菓子データを取得
    // @MainActorを使いメインスレッドで更新する
    @MainActor
    private func fetchAmedas() async {
        // ローカルのJSONファイルへのパスを取得
        guard let path = Bundle.main.path(forResource: "amedas_table", ofType: "json") else {
            return
        }

        do {
            // パスからデータを読み込む
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultJson.self, from: data)
            // お菓子リストを初期化
            amedasList = []
            // お菓子データを取得
            for (_, item) in result {
                let name = item.name
                let lat = item.lat
                let lon = item.lon
                let amedasItem = AmedasItem(name: name, lat: lat, lon: lon)
                amedasList.append(amedasItem)
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
