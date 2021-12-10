String diffTime(Duration d) {
  if (d.inSeconds < 60) {
    return d.inSeconds.toString() + "秒前";
  } else if (d.inMinutes < 60) {
    return d.inMinutes.toString() + "分钟前";
  } else if (d.inHours < 24) {
    return d.inHours.toString() + "小时前";
  } else {
    return d.inDays.toString() + "天前";
  }
}