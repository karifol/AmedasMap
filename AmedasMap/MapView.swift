//
//  MapView.swift
//  MyMap
//
//  Created by 堀ノ内海斗 on 2024/06/09.
//

import SwiftUI
import MapKit

// 画面で選択したマップの種類を示す列挙型
enum MapType {
    case standard
    case satellite
    case hybrid
}

struct MapView: View {
    // 引数
    let mapType: MapType;
    let amedasList: [AmedasItem]

    @State private var isSheetPresented = false
    @State private var selectedAmedas: AmedasItem?

    // 表示するマップの中心位置
    @State private var cameraPosition = CLLocationCoordinate2D(
        latitude: 35.681236,
        longitude: 139.767125
    )

    // AMeDASデータ
    var amedasData = AmedasData()

    // 表示するマップのスタイル
    var mapStyle: MapStyle {
        switch mapType {
        case .standard:
            return MapStyle.standard()
        case .satellite:
            return MapStyle.imagery()
        case .hybrid:
            return MapStyle.hybrid()
        }
    }

    var body: some View {
        Map(){
            ForEach(amedasList) { amedas in
                let targetCoordinate = CLLocationCoordinate2D(
                    latitude: amedas.lat,
                    longitude: amedas.lon
                )
                Annotation("Tsu-Station", coordinate: targetCoordinate, anchor: .center) {
                    VStack {
                        Text(amedas.name)
                    }
                    .padding()
                    .foregroundColor(.blue)
                    .background(in: .capsule)
                    .onTapGesture {
                        selectedAmedas = amedas
                        isSheetPresented = true
                    }
                }
            }
        }
        .mapStyle(mapStyle)
        .sheet(isPresented: $isSheetPresented) {
            if let item = selectedAmedas {
                SheetView(
                    area: item.area,
                    id: item.place_id,
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
            }
        }
    }
}
