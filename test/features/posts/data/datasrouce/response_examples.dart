const String listOfPosts = """{
                          "data": [
                              {
                                  "id": "60d21b4b67d0d8992e610c94",
                                  "image": "https://img.dummyapi.io/photo-1552915212-139b695d4a2a.jpg",
                                  "likes": 75,
                                  "tags": [
                                      "dog",
                                      "animal",
                                      "pet"
                                  ],
                                  "text": "You can follow this cutie at doofus_the_golden in ...",
                                  "publishDate": "2019-11-07T18:05:00.318Z",
                                  "owner": {
                                      "id": "60d0fe4f5311236168a10a1c",
                                      "title": "miss",
                                      "firstName": "Abigail",
                                      "lastName": "Liu",
                                      "picture": "https://randomuser.me/api/portraits/med/women/83.jpg"
                                  }
                              },
                              {
                                  "id": "60d21aed67d0d8992e610b7f",
                                  "image": "https://img.dummyapi.io/photo-1582490738676-9ea599096c68.jpg",
                                  "likes": 13,
                                  "tags": [
                                      "animal",
                                      "dog",
                                      "canine"
                                  ],
                                  "text": "Dog giving a high five white and black long coat s...",
                                  "publishDate": "2019-11-07T16:42:30.296Z",
                                  "owner": {
                                      "id": "60d0fe4f5311236168a109ff",
                                      "title": "mrs",
                                      "firstName": "Josefina",
                                      "lastName": "Calvo",
                                      "picture": "https://randomuser.me/api/portraits/med/women/3.jpg"
                                  }
                              },
                              {
                                  "id": "60d21b5e67d0d8992e610cce",
                                  "image": "https://img.dummyapi.io/photo-1546081090-940623d25f4d.jpg",
                                  "likes": 8,
                                  "tags": [
                                      "black-and-white",
                                      "dog",
                                      "new york city"
                                  ],
                                  "text": "Pug grayscale photo of pug sits beside wall",
                                  "publishDate": "2019-11-07T05:43:56.795Z",
                                  "owner": {
                                      "id": "60d0fe4f5311236168a10a27",
                                      "title": "mr",
                                      "firstName": "Tomothy",
                                      "lastName": "Hawkins",
                                      "picture": "https://randomuser.me/api/portraits/med/men/48.jpg"
                                  }
                              }
                          ],
                          "total": 873,
                          "page": 87,
                          "limit": 10
                      }""";

const String singlePost = """{
    "id": "60d21aed67d0d8992e610b7f",
    "image": "https://img.dummyapi.io/photo-1582490738676-9ea599096c68.jpg",
    "likes": 13,
    "link": "https://www.discover194.com/",
    "tags": [
        "animal",
        "dog",
        "canine"
    ],
    "text": "Dog giving a high five white and black long coat small dog",
    "publishDate": "2019-11-07T16:42:30.296Z",
    "owner": {
        "id": "60d0fe4f5311236168a109ff",
        "title": "mrs",
        "firstName": "Josefina",
        "lastName": "Calvo",
        "picture": "https://randomuser.me/api/portraits/med/women/3.jpg"
    }
}""";

const String emptyResponse = """{
    "data": [],
    "total": 873,
    "page": 872,
    "limit": 10
}""";

const String errorResponse = """
{
    "error": "PARAMS_NOT_VALID"
}
""";
