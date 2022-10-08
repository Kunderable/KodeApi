//
//  Network.swift
//  Kode
//
//  Created by Илья Сутормин on 07.10.2022.
//

import UIKit

class Networking {
    static func arrayUser(url: String, comletion: @escaping ([Item]) -> ()) {
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return}

            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(Kode.self, from: data).items
                comletion(user)
            } catch {
                print("Не получилось")
            }
        }.resume()
    }
}
