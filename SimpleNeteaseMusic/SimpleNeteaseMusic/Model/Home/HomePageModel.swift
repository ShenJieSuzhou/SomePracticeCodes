//
//  HomePageModel.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2021/5/13.
//  Copyright © 2021 shenjie. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct HomePage: Codable {
    let code: Int
    let data: DataClass
    let message: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let cursor: JSONNull?
    let blocks: [Block]
    let hasMore: Bool
    let blockUUIDs: JSONNull?
    let pageConfig: PageConfig
    let guideToast: GuideToast
}

// MARK: - Block
struct Block: Codable {
    let blockCode, showType: String
    let extInfo: EXTInfoUnion?
    let canClose: Bool
    let action: String?
    let actionType: ActionType?
    let uiElement: BlockUIElement?
    let creatives: [Creative]?
}

enum ActionType: String, Codable {
    case clientCustomized = "client_customized"
    case orpheus = "orpheus"
}

// MARK: - Creative
struct Creative: Codable {
    let creativeType: String
    let creativeID, action: String?
    let actionType: ActionType?
    let uiElement: CreativeUIElement?
    let resources: [ResourceElement]?
    let alg: String?
    let position: Int
    let code: String?
    let logInfo: String? = ""
    let creativeEXTInfoVO: CreativeEXTInfoVO?
    let source: String?

    enum CodingKeys: String, CodingKey {
        case creativeType
        case creativeID = "creativeId"
        case action, actionType, uiElement, resources, alg, position, code
        case creativeEXTInfoVO = "creativeExtInfoVO"
        case source
    }
}

// MARK: - CreativeEXTInfoVO
struct CreativeEXTInfoVO: Codable {
    let playCount: Int
}

// MARK: - ResourceElement
struct ResourceElement: Codable {
    let uiElement: ResourceUIElement
    let resourceType: String
    let resourceID: String
    let resourceURL: String?
    let resourceEXTInfo: ResourceEXTInfo?
    let action: String
    let actionType: ActionType
    let valid: Bool
    let alg: String?
    let logInfo: String? = ""

    enum CodingKeys: String, CodingKey {
        case uiElement, resourceType
        case resourceID = "resourceId"
        case resourceURL = "resourceUrl"
        case resourceEXTInfo = "resourceExtInfo"
        case action, actionType, valid, alg
    }
}


// MARK: - ResourceEXTInfo
struct ResourceEXTInfo: Codable {
    let playCount: Int?
    let highQuality: Bool?
    let artists: [ResourceEXTInfoArtist]?
    let songData: SongData?
    let songPrivilege: SongPrivilege?
    let commentSimpleData: CommentSimpleData?
    let startTime, endTime: Int?
    let subed, canSubscribe: Bool?
    let tags: [String]?
    let bigEvent: Bool?
    let eventID, eventType: String?
    let subCount: Int?
    let alias: String?
    let specialCover: Int?

    enum CodingKeys: String, CodingKey {
        case playCount, highQuality, artists, songData, songPrivilege, commentSimpleData, startTime, endTime, subed, canSubscribe, tags, bigEvent
        case eventID = "eventId"
        case eventType, subCount, alias, specialCover
    }
}

// MARK: - ResourceEXTInfoArtist
struct ResourceEXTInfoArtist: Codable {
    let name: String
    let id, picID, img1V1ID: Int
    let briefDesc: String
    let picURL, img1V1URL: String?
    let albumSize: Int
    let alias: [JSONAny]?
    let trans: String?
    let musicSize, topicPerson: Int

    enum CodingKeys: String, CodingKey {
        case name, id
        case picID = "picId"
        case img1V1ID = "img1v1Id"
        case briefDesc
        case picURL = "picUrl"
        case img1V1URL = "img1v1Url"
        case albumSize, alias, trans, musicSize, topicPerson
    }
}

// MARK: - CommentSimpleData
struct CommentSimpleData: Codable {
    let content: String
    let commentID: Int
    let threadID: String?
    let userID: Int
    let userName: String?

    enum CodingKeys: String, CodingKey {
        case content
        case commentID = "commentId"
        case threadID = "threadId"
        case userID = "userId"
        case userName
    }
}

// MARK: - SongData
struct SongData: Codable {
    let name: String
    let id, position: Int
    let alias: [String]
    let status, fee, copyrightID: Int
    let disc: String
    let no: Int
    let artists: [ResourceEXTInfoArtist]
    let album: Album
    let starred: Bool
    let popularity, score, starredNum, duration: Int
    let playedNum, dayPlays, hearTime: Int
    let ringtone: String?
    let crbt, audition: JSONNull?
    let copyFrom, commentThreadID: String
    let rtURL: JSONNull?
    let ftype: Int
    let rtUrls: [JSONAny]
    let copyright: Int
    let transName: String?
    let sign: JSONNull?
    let mark, originCoverType: Int
    let originSongSimpleData: OriginSongSimpleData?
    let single: Int
    let noCopyrightRcmd: JSONNull?
    let rtype: Int
    let rurl: JSONNull?
    let mvid: Int
    let hMusic: Music?
    let mMusic, lMusic, bMusic: Music
    let mp3URL: JSONNull?
    let transNames: [String]?

    enum CodingKeys: String, CodingKey {
        case name, id, position, alias, status, fee
        case copyrightID = "copyrightId"
        case disc, no, artists, album, starred, popularity, score, starredNum, duration, playedNum, dayPlays, hearTime, ringtone, crbt, audition, copyFrom
        case commentThreadID = "commentThreadId"
        case rtURL = "rtUrl"
        case ftype, rtUrls, copyright, transName, sign, mark, originCoverType, originSongSimpleData, single, noCopyrightRcmd, rtype, rurl, mvid, hMusic, mMusic, lMusic, bMusic
        case mp3URL = "mp3Url"
        case transNames
    }
}

// MARK: - Album
struct Album: Codable {
    let name: String
    let id: Int
    let type: TypeEnum
    let size: Int
    let picID: Double
    let blurPicURL: String
    let companyID: Int
    let pic: Double
    let picURL: String
    let publishTime: Int
    let albumDescription, tags: String
    let company: String?
    let briefDesc: String
    let artist: ResourceEXTInfoArtist
    let songs, alias: [JSONAny]
    let status, copyrightID: Int
    let commentThreadID: String
    let artists: [ResourceEXTInfoArtist]
    let subType: SubType
    let transName: String?
    let onSale: Bool
    let mark: Int
    let picIDStr: String?
    let transNames: [String]?

    enum CodingKeys: String, CodingKey {
        case name, id, type, size
        case picID = "picId"
        case blurPicURL = "blurPicUrl"
        case companyID = "companyId"
        case pic
        case picURL = "picUrl"
        case publishTime
        case albumDescription = "description"
        case tags, company, briefDesc, artist, songs, alias, status
        case copyrightID = "copyrightId"
        case commentThreadID = "commentThreadId"
        case artists, subType, transName, onSale, mark
        case picIDStr = "picId_str"
        case transNames
    }
}

enum SubType: String, Codable {
    case 录音室版 = "录音室版"
    case 现场版 = "现场版"
}

enum TypeEnum: String, Codable {
    case ep = "EP"
    case epSingle = "EP/Single"
    case single = "Single"
    case 专辑 = "专辑"
}

// MARK: - Music
struct Music: Codable {
    let name: JSONNull?
    let id, size: Int
    let musicExtension: Extension
    let sr, dfsID, bitrate, playTime: Int
    let volumeDelta: Int

    enum CodingKeys: String, CodingKey {
        case name, id, size
        case musicExtension = "extension"
        case sr
        case dfsID = "dfsId"
        case bitrate, playTime, volumeDelta
    }
}

enum Extension: String, Codable {
    case mp3 = "mp3"
}

// MARK: - OriginSongSimpleData
struct OriginSongSimpleData: Codable {
    let songID: Int
    let name: String
    let artists: [AlbumMeta]
    let albumMeta: AlbumMeta

    enum CodingKeys: String, CodingKey {
        case songID = "songId"
        case name, artists, albumMeta
    }
}

// MARK: - AlbumMeta
struct AlbumMeta: Codable {
    let id: Int
    let name: String
}

// MARK: - SongPrivilege
struct SongPrivilege: Codable {
    let id, fee, payed, realPayed: Int
    let st, pl, dl, sp: Int
    let cp, subp: Int
    let cs: Bool
    let maxbr, fl: Int
    let pc: JSONNull?
    let toast: Bool
    let flag: Int
    let paidBigBang, preSell: Bool
    let playMaxbr, downloadMaxbr: Int
    let chargeInfoList: [ChargeInfoList]
}

// MARK: - ChargeInfoList
struct ChargeInfoList: Codable {
    let rate: Int
    let chargeURL, chargeMessage: JSONNull?
    let chargeType: Int

    enum CodingKeys: String, CodingKey {
        case rate
        case chargeURL = "chargeUrl"
        case chargeMessage, chargeType
    }
}

enum ResourceType: String, Codable {
    case album = "ALBUM"
    case digitalAlbum = "digitalAlbum"
    case list = "list"
    case orpheus = "ORPHEUS"
    case resourceTypeAlbum = "album"
    case song = "song"
    case webview = "WEBVIEW"
}

// MARK: - ResourceUIElement
struct ResourceUIElement: Codable {
    let mainTitle: Title
    let image: Image
    let labelTexts: [String]?
    let subTitle: PurpleSubTitle?
}

// MARK: - Image
struct Image: Codable {
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case imageURL = "imageUrl"
    }
}

// MARK: - Title
struct Title: Codable {
    let title: String
}

// MARK: - PurpleSubTitle
struct PurpleSubTitle: Codable {
    let title: String
    let titleType: TitleType?
}

enum TitleType: String, Codable {
    case songRcmdFromComment = "songRcmdFromComment"
    case songRcmdTag = "songRcmdTag"
}

// MARK: - CreativeUIElement
struct CreativeUIElement: Codable {
    let mainTitle: Title?
    let image: Image?
    let labelTexts: [String]?
    let subTitle: Title?
    let button: Button?
}

// MARK: - Button
struct Button: Codable {
    let action: String
    let actionType: ActionType
    let text: String
    let iconURL: JSONNull?

    enum CodingKeys: String, CodingKey {
        case action, actionType, text
        case iconURL = "iconUrl"
    }
}

enum EXTInfoUnion: Codable {

    case extInfoElementArray([EXTInfoElement])
    case purpleEXTInfo(PurpleEXTInfo)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([EXTInfoElement].self) {
            self = .extInfoElementArray(x)
            return
        }
        if let x = try? container.decode(PurpleEXTInfo.self) {
            self = .purpleEXTInfo(x)
            return
        }
        throw DecodingError.typeMismatch(EXTInfoUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for EXTInfoUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .extInfoElementArray(let x):
            try container.encode(x)
        case .purpleEXTInfo(let x):
            try container.encode(x)
        }
    }
}

// MARK: - EXTInfoElement
struct EXTInfoElement: Codable {
    let id: String
    let type, mlogBaseDataType: Int
    let position: JSONNull?
    let resource: EXTInfoResource
    let alg, logInfo: String
    let reason: JSONNull?
    let matchField: Int
    let matchFieldContent: JSONNull?
    let sameCity: Bool
}

// MARK: - EXTInfoResource
struct EXTInfoResource: Codable {
    let mlogBaseData: MlogBaseData
    let mlogEXTVO: MlogEXTVO
    let userProfile: UserProfile
    let status: Int
    let shareURL: String

    enum CodingKeys: String, CodingKey {
        case mlogBaseData
        case mlogEXTVO = "mlogExtVO"
        case userProfile, status
        case shareURL = "shareUrl"
    }
}

// MARK: - MlogBaseData
struct MlogBaseData: Codable {
    let id: String
    let type: Int
    let text: String
    let interveneText: String?
    let pubTime: Int
    let coverURL: String
    let coverHeight, coverWidth, coverColor: Int
    let coverPicKey: String
    let coverDynamicURL, audio: JSONNull?
    let threadID: String
    let duration: Int

    enum CodingKeys: String, CodingKey {
        case id, type, text, interveneText, pubTime
        case coverURL = "coverUrl"
        case coverHeight, coverWidth, coverColor, coverPicKey
        case coverDynamicURL = "coverDynamicUrl"
        case audio
        case threadID = "threadId"
        case duration
    }
}

// MARK: - MlogEXTVO
struct MlogEXTVO: Codable {
    let likedCount, commentCount, playCount: Int
    let song: MlogEXTVOSong
    let algSong: JSONNull?
    let videoStartPlayTime: Int
    let canCollect: Bool
    let artistName, rcmdInfo, strongPushMark, strongPushIcon: JSONNull?
    let specialTag, channelTag: JSONNull?
    let artists: [JSONAny]
}

// MARK: - MlogEXTVOSong
struct MlogEXTVOSong: Codable {
    let id: Int
    let name: String
    let coverURL: String
    let duration: Int
    let artists: [SongArtist]
    let privilege: JSONNull?
    let albumName: String
    let startTime, endTime: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id, name
        case coverURL = "coverUrl"
        case duration, artists, privilege, albumName, startTime, endTime
    }
}

// MARK: - SongArtist
struct SongArtist: Codable {
    let artistID: Int
    let artistName: String

    enum CodingKeys: String, CodingKey {
        case artistID = "artistId"
        case artistName
    }
}

// MARK: - UserProfile
struct UserProfile: Codable {
    let userID: Int
    let nickname: String
    let avatarURL: String
    let followed: Bool
    let userType: Int
    let isAnchor: Bool
    let avatarDetail: AvatarDetail

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case nickname
        case avatarURL = "avatarUrl"
        case followed, userType, isAnchor, avatarDetail
    }
}

// MARK: - AvatarDetail
struct AvatarDetail: Codable {
    let userType, identityLevel: Int?
    let identityIconURL: String?

    enum CodingKeys: String, CodingKey {
        case userType, identityLevel
        case identityIconURL = "identityIconUrl"
    }
}

// MARK: - PurpleEXTInfo
struct PurpleEXTInfo: Codable {
    let banners: [Banner]
}

// MARK: - Banner
struct Banner: Codable {
    let adLocation, monitorImpress: JSONNull?
    let bannerID: String
    let extMonitor, pid: JSONNull?
    let pic: String
    let program, video, adurlV2, adDispatchJSON: JSONNull?
    let dynamicVideoData, monitorType, adid: JSONNull?
    let titleColor: TitleColor
    let requestID: String
    let exclusive: Bool
    let scm: String
    let event, alg: JSONNull?
    let song: BannerSong?
    let targetID: Int
    let showAdTag: Bool
    let adSource, showContext: JSONNull?
    let targetType: Int
    let typeTitle: String
    let url: String?
    let encodeID: String
    let extMonitorInfo, monitorClick, monitorImpressList, monitorBlackList: JSONNull?
    let monitorClickList: JSONNull?

    enum CodingKeys: String, CodingKey {
        case adLocation, monitorImpress
        case bannerID = "bannerId"
        case extMonitor, pid, pic, program, video, adurlV2
        case adDispatchJSON = "adDispatchJson"
        case dynamicVideoData, monitorType, adid, titleColor
        case requestID = "requestId"
        case exclusive, scm, event, alg, song
        case targetID = "targetId"
        case showAdTag, adSource, showContext, targetType, typeTitle, url
        case encodeID = "encodeId"
        case extMonitorInfo, monitorClick, monitorImpressList, monitorBlackList, monitorClickList
    }
}

// MARK: - BannerSong
struct BannerSong: Codable {
    let name: String
    let id, pst, t: Int
    let ar: [Ar]
    let alia: [String]
    let pop, st: Int
    let rt: String
    let fee, v: Int
    let crbt: JSONNull?
    let cf: String
    let al: Al
    let dt: Int
    let h, m, l: H
    let a: JSONNull?
    let cd: String
    let no: Int
    let rtURL: JSONNull?
    let ftype: Int
    let rtUrls: [JSONAny]
    let djID, copyright, sID, mark: Int
    let originCoverType: Int
    let originSongSimpleData: JSONNull?
    let single: Int
    let noCopyrightRcmd: JSONNull?
    let rtype: Int
    let rurl: JSONNull?
    let mst, cp, mv, publishTime: Int
    let videoInfo: VideoInfo

    enum CodingKeys: String, CodingKey {
        case name, id, pst, t, ar, alia, pop, st, rt, fee, v, crbt, cf, al, dt, h, m, l, a, cd, no
        case rtURL = "rtUrl"
        case ftype, rtUrls
        case djID = "djId"
        case copyright
        case sID = "s_id"
        case mark, originCoverType, originSongSimpleData, single, noCopyrightRcmd, rtype, rurl, mst, cp, mv, publishTime, videoInfo
    }
}

// MARK: - Al
struct Al: Codable {
    let id: Int
    let name: String
    let picURL: String
    let tns: [JSONAny]
    let picStr: String
    let pic: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case picURL = "picUrl"
        case tns
        case picStr = "pic_str"
        case pic
    }
}

// MARK: - Ar
struct Ar: Codable {
    let id: Int
    let name: String
    let tns, alias: [JSONAny]
}

// MARK: - H
struct H: Codable {
    let br, fid, size, vd: Int
}

// MARK: - VideoInfo
struct VideoInfo: Codable {
    let moreThanOne: Bool
    let video: Video?
}

// MARK: - Video
struct Video: Codable {
    let vid: String
    let type: Int
    let title: String
    let playTime: Int
    let coverURL: String
    let publishTime: Int
    let artists, alias: JSONNull?

    enum CodingKeys: String, CodingKey {
        case vid, type, title, playTime
        case coverURL = "coverUrl"
        case publishTime, artists, alias
    }
}

enum TitleColor: String, Codable {
    case blue = "blue"
    case red = "red"
}

// MARK: - BlockUIElement
struct BlockUIElement: Codable {
    let subTitle: FluffySubTitle?
    let button: Button?
}

// MARK: - FluffySubTitle
struct FluffySubTitle: Codable {
    let title: String
    let titleImgURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case titleImgURL = "titleImgUrl"
    }
}

// MARK: - GuideToast
struct GuideToast: Codable {
    let hasGuideToast: Bool
    let toastList: [JSONAny]
}

// MARK: - PageConfig
struct PageConfig: Codable {
    let refreshToast, nodataToast: String
    let refreshInterval: Int
    let title: JSONNull?
    let fullscreen: Bool
    let abtest, songLabelMarkPriority: [String]
    let songLabelMarkLimit: Int
    let homepageMode: String
    let showModeEntry: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

struct Menus: Codable {
    let code: Int
    let data: [Datum]
    let message: String
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name: String
    let iconURL: String
    let url: String
    let skinSupport: Bool
    let homepageMode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case iconURL = "iconUrl"
        case url, skinSupport, homepageMode
    }
}
