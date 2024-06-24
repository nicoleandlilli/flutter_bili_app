
import 'dart:core';

///API查看地址：https://github.com/SocialSisterYi/bilibili-API-collect?tab=readme-ov-file
///请求地址：https://api.bilibili.com/x/web-interface/ranking/v2
class HomeMo {
  String? note;
  List<VideoMo>? list;

  HomeMo({this.note, this.list});

  HomeMo.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    if (json['list'] != null) {
      list = <VideoMo>[];
      json['list'].forEach((v) {
        list!.add(VideoMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoMo {
  int? aid;
  int? videos;
  int? tid;
  String? tname;
  String? url;
  int? copyright;
  String? pic;
  String? title;
  int? pubdate;
  int? ctime;
  String? desc;
  int? state;
  int? duration;
  Rights? rights;
  Owner? owner;
  Stat? stat;
  // String? dynamic;
  int? cid;
  Dimension? dimension;
  String? shortLinkV2;
  String? firstFrame;
  String? pubLocation;
  String? cover43;
  String? bvid;
  int? score;
  List<Others>? others;
  int? enableVt;
  int? missionId;
  int? upFromV2;
  int? seasonId;

  VideoMo(
      {this.aid,
        this.videos,
        this.tid,
        this.tname,
        this.url,
        this.copyright,
        this.pic,
        this.title,
        this.pubdate,
        this.ctime,
        this.desc,
        this.state,
        this.duration,
        this.rights,
        this.owner,
        this.stat,
        // this.dynamic,
        this.cid,
        this.dimension,
        this.shortLinkV2,
        this.firstFrame,
        this.pubLocation,
        this.cover43,
        this.bvid,
        this.score,
        this.others,
        this.enableVt,
        this.missionId,
        this.upFromV2,
        this.seasonId});


  VideoMo.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    videos = json['videos'];
    tid = json['tid'];
    tname = json['tname'];
    copyright = json['copyright'];
    pic = json['pic'];
    title = json['title'];
    pubdate = json['pubdate'];
    ctime = json['ctime'];
    desc = json['desc'];
    state = json['state'];
    duration = json['duration'];
    rights =
    json['rights'] != null ? Rights.fromJson(json['rights']) : null;
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
    stat = json['stat'] != null ? Stat.fromJson(json['stat']) : null;
    // dynamic = json['dynamic'];
    cid = json['cid'];
    dimension = json['dimension'] != null
        ? new Dimension.fromJson(json['dimension'])
        : null;
    shortLinkV2 = json['short_link_v2'];
    firstFrame = json['first_frame'];
    pubLocation = json['pub_location'];
    cover43 = json['cover43'];
    bvid = json['bvid'];
    score = json['score'];
    if (json['others'] != null) {
      others = <Others>[];
      json['others'].forEach((v) {
        others!.add(Others.fromJson(v));
      });
    }
    enableVt = json['enable_vt'];
    missionId = json['mission_id'];
    upFromV2 = json['up_from_v2'];
    seasonId = json['season_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aid'] = this.aid;
    data['videos'] = this.videos;
    data['tid'] = this.tid;
    data['tname'] = this.tname;
    data['copyright'] = this.copyright;
    data['pic'] = this.pic;
    data['title'] = this.title;
    data['pubdate'] = this.pubdate;
    data['ctime'] = this.ctime;
    data['desc'] = this.desc;
    data['state'] = this.state;
    data['duration'] = this.duration;
    if (rights != null) {
      data['rights'] = this.rights!.toJson();
    }
    if (owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    // data['dynamic'] = this.dynamic;
    data['cid'] = this.cid;
    if (dimension != null) {
      data['dimension'] = this.dimension!.toJson();
    }
    data['short_link_v2'] = this.shortLinkV2;
    data['first_frame'] = this.firstFrame;
    data['pub_location'] = this.pubLocation;
    data['cover43'] = this.cover43;
    data['bvid'] = this.bvid;
    data['score'] = this.score;
    if (others != null) {
      data['others'] = this.others!.map((v) => v.toJson()).toList();
    }
    data['enable_vt'] = this.enableVt;
    data['mission_id'] = this.missionId;
    data['up_from_v2'] = this.upFromV2;
    data['season_id'] = this.seasonId;
    return data;
  }
}

class Rights {
  int? bp;
  int? elec;
  int? download;
  int? movie;
  int? pay;
  int? hd5;
  int? noReprint;
  int? autoplay;
  int? ugcPay;
  int? isCooperation;
  int? ugcPayPreview;
  int? noBackground;
  int? arcPay;
  int? payFreeWatch;

  Rights(
      {this.bp,
        this.elec,
        this.download,
        this.movie,
        this.pay,
        this.hd5,
        this.noReprint,
        this.autoplay,
        this.ugcPay,
        this.isCooperation,
        this.ugcPayPreview,
        this.noBackground,
        this.arcPay,
        this.payFreeWatch});

  Rights.fromJson(Map<String, dynamic> json) {
    bp = json['bp'];
    elec = json['elec'];
    download = json['download'];
    movie = json['movie'];
    pay = json['pay'];
    hd5 = json['hd5'];
    noReprint = json['no_reprint'];
    autoplay = json['autoplay'];
    ugcPay = json['ugc_pay'];
    isCooperation = json['is_cooperation'];
    ugcPayPreview = json['ugc_pay_preview'];
    noBackground = json['no_background'];
    arcPay = json['arc_pay'];
    payFreeWatch = json['pay_free_watch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bp'] = bp;
    data['elec'] = elec;
    data['download'] = download;
    data['movie'] = movie;
    data['pay'] = pay;
    data['hd5'] = hd5;
    data['no_reprint'] = noReprint;
    data['autoplay'] = autoplay;
    data['ugc_pay'] = ugcPay;
    data['is_cooperation'] = isCooperation;
    data['ugc_pay_preview'] = ugcPayPreview;
    data['no_background'] = noBackground;
    data['arc_pay'] = arcPay;
    data['pay_free_watch'] = payFreeWatch;
    return data;
  }
}

class Owner {
  int? mid;
  String? name;
  String? face;

  Owner({this.mid, this.name, this.face});

  Owner.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    name = json['name'];
    face = json['face'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mid'] = this.mid;
    data['name'] = this.name;
    data['face'] = this.face;
    return data;
  }
}

class Stat {
  int? aid;
  int? view;
  int? danmaku;
  int? reply;
  int? favorite;
  int? coin;
  int? share;
  int? nowRank;
  int? hisRank;
  int? like;
  int? dislike;
  int? vt;
  int? vv;

  Stat(
      {this.aid,
        this.view,
        this.danmaku,
        this.reply,
        this.favorite,
        this.coin,
        this.share,
        this.nowRank,
        this.hisRank,
        this.like,
        this.dislike,
        this.vt,
        this.vv});

  Stat.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    view = json['view'];
    danmaku = json['danmaku'];
    reply = json['reply'];
    favorite = json['favorite'];
    coin = json['coin'];
    share = json['share'];
    nowRank = json['now_rank'];
    hisRank = json['his_rank'];
    like = json['like'];
    dislike = json['dislike'];
    vt = json['vt'];
    vv = json['vv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aid'] = this.aid;
    data['view'] = this.view;
    data['danmaku'] = this.danmaku;
    data['reply'] = this.reply;
    data['favorite'] = this.favorite;
    data['coin'] = this.coin;
    data['share'] = this.share;
    data['now_rank'] = this.nowRank;
    data['his_rank'] = this.hisRank;
    data['like'] = this.like;
    data['dislike'] = this.dislike;
    data['vt'] = this.vt;
    data['vv'] = this.vv;
    return data;
  }
}

class Dimension {
  int? width;
  int? height;
  int? rotate;

  Dimension({this.width, this.height, this.rotate});

  Dimension.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    rotate = json['rotate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['rotate'] = this.rotate;
    return data;
  }
}

class Others {
  int? aid;
  int? videos;
  int? tid;
  String? tname;
  int? copyright;
  String? pic;
  String? title;
  int? pubdate;
  int? ctime;
  String? desc;
  int? state;
  int? attribute;
  int? duration;
  Rights? rights;
  Owner? owner;
  Stat? stat;
  // String? dynamic;
  int? cid;
  Dimension? dimension;
  int? attributeV2;
  String? shortLinkV2;
  String? firstFrame;
  String? pubLocation;
  String? cover43;
  String? bvid;
  int? score;
  int? enableVt;
  int? missionId;
  int? upFromV2;

  Others(
      {this.aid,
        this.videos,
        this.tid,
        this.tname,
        this.copyright,
        this.pic,
        this.title,
        this.pubdate,
        this.ctime,
        this.desc,
        this.state,
        this.attribute,
        this.duration,
        this.rights,
        this.owner,
        this.stat,
        // this.dynamic,
        this.cid,
        this.dimension,
        this.attributeV2,
        this.shortLinkV2,
        this.firstFrame,
        this.pubLocation,
        this.cover43,
        this.bvid,
        this.score,
        this.enableVt,
        this.missionId,
        this.upFromV2});

  Others.fromJson(Map<String, dynamic> json) {
    aid = json['aid'];
    videos = json['videos'];
    tid = json['tid'];
    tname = json['tname'];
    copyright = json['copyright'];
    pic = json['pic'];
    title = json['title'];
    pubdate = json['pubdate'];
    ctime = json['ctime'];
    desc = json['desc'];
    state = json['state'];
    attribute = json['attribute'];
    duration = json['duration'];
    rights =
    json['rights'] != null ? new Rights.fromJson(json['rights']) : null;
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
    // dynamic = json['dynamic'];
    cid = json['cid'];
    dimension = json['dimension'] != null
        ? new Dimension.fromJson(json['dimension'])
        : null;
    attributeV2 = json['attribute_v2'];
    shortLinkV2 = json['short_link_v2'];
    firstFrame = json['first_frame'];
    pubLocation = json['pub_location'];
    cover43 = json['cover43'];
    bvid = json['bvid'];
    score = json['score'];
    enableVt = json['enable_vt'];
    missionId = json['mission_id'];
    upFromV2 = json['up_from_v2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aid'] = this.aid;
    data['videos'] = this.videos;
    data['tid'] = this.tid;
    data['tname'] = this.tname;
    data['copyright'] = this.copyright;
    data['pic'] = this.pic;
    data['title'] = this.title;
    data['pubdate'] = this.pubdate;
    data['ctime'] = this.ctime;
    data['desc'] = this.desc;
    data['state'] = this.state;
    data['attribute'] = this.attribute;
    data['duration'] = this.duration;
    if (this.rights != null) {
      data['rights'] = this.rights!.toJson();
    }
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    if (this.stat != null) {
      data['stat'] = this.stat!.toJson();
    }
    // data['dynamic'] = this.dynamic;
    data['cid'] = this.cid;
    if (this.dimension != null) {
      data['dimension'] = this.dimension!.toJson();
    }
    data['attribute_v2'] = this.attributeV2;
    data['short_link_v2'] = this.shortLinkV2;
    data['first_frame'] = this.firstFrame;
    data['pub_location'] = this.pubLocation;
    data['cover43'] = this.cover43;
    data['bvid'] = this.bvid;
    data['score'] = this.score;
    data['enable_vt'] = this.enableVt;
    data['mission_id'] = this.missionId;
    data['up_from_v2'] = this.upFromV2;
    return data;
  }
}

class CategoryMo {
  String? title;

  CategoryMo({this.title});
}

class BannerMo {
  String? title;
  String? cover;
  String? type;
  int? aid;
  int? tid;
  BannerMo({this.title,this.cover,this.type,this.aid,this.tid});
}