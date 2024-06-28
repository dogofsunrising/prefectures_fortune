//
//  AsyncImageView.swift
//  prefectures_fortune
//
//  Created by 藤本皇汰 on 2024/06/29.
//

import SwiftUI

struct AsyncImageView: View {
    @State private var image: UIImage?
    let url: URL

    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = uiImage
                }
            }
        }.resume()
    }
}
