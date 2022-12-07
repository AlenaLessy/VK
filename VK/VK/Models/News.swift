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
    let post: String?
    /// Название фотографий в посте
    let postImageName: FriendNews?
    /// Тип поста
    let postType: NewsType
    /// Количество лайков
    let likesCount: Int
    /// Количество комментариев
    let commentsCount: Int
    /// Количество репостов
    let repostsCount: Int
    /// Количество просмотров
    let viewsCount: Int

    static func createNews() -> [News] {
        let newsDataCourse: [News] = [
            News(
                userImageName: "mi1",
                userName: "Потап Михалыч",
                date: "12.05.2022",
                post: "Все виды медведей невероятно умны. Эти животные очень любознательны",
                postImageName: nil,
                postType: .post,
                likesCount: 1855,
                commentsCount: 4,
                repostsCount: 1,
                viewsCount: 4920
            ),
            News(
                userImageName: "mi2",
                userName: "Топотун Бурый",
                date: "13.05.2022",
                post: nil,
                postImageName: FriendNews(name: "Топотун Бурый", imageNames: ["m2"]),
                postType: .image,
                likesCount: 13,
                commentsCount: 1,
                repostsCount: 0,
                viewsCount: 29
            ),
            News(
                userImageName: "mi3",
                userName: "Медведь Гризли",
                date: "14.05.2022",
                post: """
                У всех медведей два слоя шерсти. \
                Один слой легкий и пушистый для тепла, второй тяжелый и непромокаемый
                """,
                postImageName: FriendNews(name: "Медведь Гризли", imageNames: ["m3"]),
                postType: .imageAndPost,
                likesCount: 8,
                commentsCount: 0,
                repostsCount: 1,
                viewsCount: 10
            ),
            News(
                userImageName: "mi4",
                userName: "Белый Медвежуля",
                date: "15.05.2022",
                post: "Медведей принято считать косолапыми, но это совсем не так.",
                postImageName: FriendNews(name: "Белый Медвежуля", imageNames: ["m4"]),
                postType: .imageAndPost,
                likesCount: 155,
                commentsCount: 42,
                repostsCount: 13,
                viewsCount: 1420
            ),
        ]
        return newsDataCourse
    }
}
