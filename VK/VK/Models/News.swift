// News.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Новости
struct News {
    /// Название аватарки пользователя
    let userImageName: String
    /// Имя пользователя
    let userName: String
    /// Дата поста
    let date: String
    /// Текст поста
    let post: String
    /// Название фотографий в посте
    let postImageName: FriendNews

    static func createNews() -> [News] {
        let newsDataCourse: [News] = [
            News(
                userImageName: "mi1",
                userName: "Потап Михалыч",
                date: "12.05.2022",
                post: "Все виды медведей невероятно умны. Эти животные очень любознательны",
                postImageName: FriendNews(name: "Потап Михалыч", imageNames: ["mi1"])
            ),
            News(
                userImageName: "mi2",
                userName: "Топотун Бурый",
                date: "13.05.2022",
                post: "Самый крупный медведь - полярный. Вес взрослого самца доходит до 500 кг.",
                postImageName: FriendNews(name: "Топотун Бурый", imageNames: ["m2"])
            ),
            News(
                userImageName: "mi3",
                userName: "Медведь Гризли",
                date: "14.05.2022",
                post: """
                У всех медведей два слоя шерсти. \
                Один слой легкий и пушистый для тепла, второй тяжелый и непромокаемый
                """,
                postImageName: FriendNews(name: "Медведь Гризли", imageNames: ["m3"])
            ),
            News(
                userImageName: "mi4",
                userName: "Белый Медвежуля",
                date: "15.05.2022",
                post: "Медведей принято считать косолапыми, но это совсем не так.",
                postImageName: FriendNews(name: "Белый Медвежуля", imageNames: ["m4"])
            ),
        ]
        return newsDataCourse
    }
}
