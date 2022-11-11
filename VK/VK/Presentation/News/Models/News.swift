//
//  News.swift
//  VK
//
//  Created by Алена Панченко on 09.11.2022.
//

import Foundation

/// Новости
struct News {
    let userImageName: String
    let userName: String
    let date: String
    let post: String
    let postImageName: Friend

    static func newsDataCourse() -> [News] {
        let newsDataCourse: [News] = [
            News(
                userImageName: "mi1",
                userName: "Потап Михалыч",
                date: "12.05.2022",
                post: "Все виды медведей невероятно умны. Эти животные очень любознательны",
                postImageName: Friend(name: "Потап Михалыч", imageNames: ["mi1"])
            ),
            News(
                userImageName: "mi2",
                userName: "Топотун Бурый",
                date: "13.05.2022",
                post: "Самый крупный медведь - полярный. Вес взрослого самца доходит до 500 кг.",
                postImageName: Friend(name: "Топотун Бурый", imageNames: ["m2"])
            ),
            News(
                userImageName: "mi3",
                userName: "Медведь Гризли",
                date: "14.05.2022",
                post: """
                У всех медведей два слоя шерсти. \
                Один слой легкий и пушистый для тепла, второй тяжелый и непромокаемый
                """,
                postImageName: Friend(name: "Медведь Гризли", imageNames: ["m3"])
            ),
            News(
                userImageName: "mi4",
                userName: "Белый Медвежуля",
                date: "15.05.2022",
                post: "Медведей принято считать косолапыми, но это совсем не так.",
                postImageName: Friend(name: "Белый Медвежуля", imageNames: ["m4"])
            ),
        ]
        return newsDataCourse
    }
}
