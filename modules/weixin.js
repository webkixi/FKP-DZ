/**
 * Module dependencies.
 */
var libs = require('../libs/libs')
var config = require('../config');

var wechat = require('co-wechat')
//https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wxc9edcce4f4d915e6&secret=926ba5478ce3f06ed153d294b1b22030

function weixin(){
    return wechat(config.weixin).middleware(function *() {
        var message = this.weixin;
          if (message.FromUserName === 'diaosi') {
            // 回复屌丝(普通回复)
            this.body = 'hehe';
          } else if (message.FromUserName === 'text') {
            //你也可以这样回复text类型的信息
            this.body = {
              content: 'text object',
              type: 'text'
            };
          } else if (message.FromUserName === 'hehe') {
            // 回复一段音乐
            this.body = {
              type: "music",
              content: {
                title: "来段音乐吧",
                description: "一无所有",
                musicUrl: "http://mp3.com/xx.mp3",
                hqMusicUrl: "http://mp3.com/xx.mp3"
              }
            };
          } else if (message.FromUserName === 'kf') {
            // 转发到客服接口
            this.body = {
              type: "customerService",
              kfAccount: "test1@test"
            };
          } else {
            // 回复高富帅(图文回复)
            this.body = [
              {
                title: '你来我家接我吧',
                description: '这是女神与高富帅之间的对话',
                picurl: 'http://nodeapi.cloudfoundry.com/qrcode.jpg',
                url: 'http://nodeapi.cloudfoundry.com/'
              }
            ];
          }
    })
}


module.exports = weixin
