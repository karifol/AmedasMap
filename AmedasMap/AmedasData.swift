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
    let area: String
    let place_id: Double
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
}

// お菓子データ検索用のクラス
@Observable class AmedasData {

    // JSONのデータ構造
    typealias ResultJson = [String: Item]
    struct Item: Codable {
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
                let amedasItem = AmedasItem(
                    area: item.area,
                    place_id: item.id,
                    type: item.type,
                    name: item.name,
                    katakana: item.katakana,
                    name_info: item.name_info,
                    address: item.address,
                    lat: item.lat,
                    lon: item.lon,
                    alt: item.alt,
                    alt_wind: item.alt_wind,
                    alt_temp: item.alt_temp,
                    start: item.start,
                    comment1: item.comment1,
                    comment2: item.comment2
                )
                amedasList.append(amedasItem)
            }
        } catch {
            print("Error: \(error)")
        }
    }
}
