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
}
