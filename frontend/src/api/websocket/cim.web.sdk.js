/* eslint-disable */
import './message.js'
import './replybody.js'
import './sentbody.js'

/*CIM服务器IP*/
const CIM_HOST = window.location.hostname;
/*
 * 服务端 websocket端口
 */
const CIM_PORT = 45678;
const CIM_URI = "ws://" + CIM_HOST + ":" + CIM_PORT;

const APP_VERSION = "1.0.0";
const APP_CHANNEL = "web";
const APP_PACKAGE = "com.hashGame.netty";

/*
 *特殊的消息类型，代表被服务端强制下线
 */
const ACTION_999 = "999";
const DATA_HEADER_LENGTH = 1;

const MESSAGE = 2;
const REPLY_BODY = 4;
const SENT_BODY = 3;
const PING = 1;
const PONG = 0;
/**
 * PONG字符串转换后
 * @type {Uint8Array}
 */
const PONG_BODY = new Uint8Array([80, 79, 78, 71]);

let socket;
let manualStop = false;
const CIMPushManager = {};
const onConnect = CIMPushManager.connect = function () {
  manualStop = false;
  window.localStorage.account = '';
  socket = new WebSocket(CIM_URI);
  socket.cookieEnabled = false;
  socket.binaryType = 'arraybuffer';
  socket.onopen = CIMPushManager.innerOnConnectFinished;
  socket.onmessage = CIMPushManager.innerOnMessageReceived;
  socket.onclose = CIMPushManager.innerOnConnectionClosed;
};
/**
 * 绑定账户
 * @type {CIMPushManager.bindAccount}
 */
const onBindAccount = CIMPushManager.bindAccount = function (account, userType, roomId) {
  window.localStorage.account = account;
  window.localStorage.userType = userType;
  window.localStorage.roomId = roomId;

  let deviceId = window.localStorage.deviceId;
  if (deviceId == '' || deviceId == undefined) {
    deviceId = generateUUID();
    window.localStorage.deviceId = deviceId;
  }

  let browser = getBrowser();
  console.log(proto)
  let body = new proto.com.hashGame.netty.api.domain.proto.SentBody();
  //注意此处，设置key是为了后端能否选定对应处理的handler，client_bind为绑定客户端到服务器
  //配合上对应的roomId和用户信息，即可实现对应channel和channel组群的管理
  //
  body.setKey("client_bind");
  body.setTimestamp(new Date().getTime());
  body.getDataMap().set("userId", account);
  body.getDataMap().set("userType", userType);
  body.getDataMap().set("roomId", roomId);
  body.getDataMap().set("channel", APP_CHANNEL);
  body.getDataMap().set("appVersion", APP_VERSION);
  body.getDataMap().set("osVersion", browser.version);
  body.getDataMap().set("packageName", APP_PACKAGE);
  body.getDataMap().set("deviceId", deviceId);
  body.getDataMap().set("deviceName", browser.name);
  body.getDataMap().set("language", navigator.language);
  CIMPushManager.sendRequest(body);
};

const onUnbindAccount = CIMPushManager.unbindAccount = function (roomId) {

  let body = new proto.com.hashGame.netty.api.domain.proto.SentBody();
  //注意此处，设置key是为了后端能否选定对应处理的handler，client_bind为绑定客户端到服务器
  //配合上对应的roomId和用户信息，即可实现对应channel和channel组群的管理
  //
  body.setKey("client_subscribe");
  body.getDataMap().set("roomId", roomId);
  CIMPushManager.sendRequest(body);
};

CIMPushManager.stop = function () {
  manualStop = true;
  socket.close();
};

CIMPushManager.resume = function () {
  manualStop = false;
  CIMPushManager.connect();
};

CIMPushManager.innerOnConnectFinished = function () {
  let account = window.localStorage.account;
  let userType = window.localStorage.userType;
  let roomId = window.localStorage.roomId;
  if (account === '' || account === undefined) {
    window.onConnectFinished();
  } else {
    CIMPushManager.bindAccount(account, userType, roomId);
  }
};

CIMPushManager.innerOnMessageReceived = function (e) {
  let data = new Uint8Array(e.data);
  let type = data[0];
  let body = data.subarray(DATA_HEADER_LENGTH, data.length);
  // console.log("type->" + type)
  // console.log("body->" + body)
  if (type === PING) {
    CIMPushManager.pong();
    return;
  }
  if (type === MESSAGE) {
    let message = proto.com.hashGame.netty.api.domain.proto.Message.deserializeBinary(body);
    console.log("当前消息为：", message)
    onInterceptMessageReceived(message.toObject(false));
    return;
  }

  if (type === REPLY_BODY) {
    let message = proto.com.hashGame.netty.api.domain.proto.ReplyBody.deserializeBinary(body);
    /**
     * 将proto对象转换成json对象，去除无用信息
     */
    let reply = {};
    reply.code = message.getCode();
    reply.key = message.getKey();
    reply.message = message.getMessage();
    reply.timestamp = message.getTimestamp();
    reply.data = {};

    /**
     * 注意，遍历map这里的参数 value在前key在后
     */
    message.getDataMap().forEach(function (v, k) {
      reply.data[k] = v;
    });
    window.onReplyReceived(reply);
  }
};

CIMPushManager.innerOnConnectionClosed = function (e) {
  if (!manualStop) {
    let time = Math.floor(Math.random() * (30 - 15 + 1) + 15);
    setTimeout(function () {
      CIMPushManager.connect();
    }, time);
  }
};
/**
 * 发送消息至后端
 * @type {CIMPushManager.sendRequest}
 */
const onSendRequest = CIMPushManager.sendRequest = function (body) {
  let data = body.serializeBinary();
  let protobuf = new Uint8Array(data.length + 1);
  protobuf[0] = SENT_BODY;
  protobuf.set(data, 1);
  socket.send(protobuf);
};

CIMPushManager.pong = function () {
  let pong = new Uint8Array(PONG_BODY.byteLength + 1);
  pong[0] = PONG;
  pong.set(PONG_BODY, 1);
  socket.send(pong);
};

function onInterceptMessageReceived(message) {
  /*
   *被强制下线之后，不再继续连接服务端
   */
  if (message.action == ACTION_999) {
    manualStop = true;
  }
  console.log("当前接收到的消息--->", message);
  /*
   *收到消息后，将消息发送给页面
   */
  if (onMessageReceived instanceof Function) {
    window.onMessageReceived(message);
  }
}

/**
 * 获得浏览器类型
 * @returns {{name: string, version: string}}
 */
function getBrowser() {
  let explorer = window.navigator.userAgent.toLowerCase();
  if (explorer.indexOf("msie") >= 0) {
    let ver = explorer.match(/msie ([\d.]+)/)[1];
    return {name: "IE", version: ver};
  } else if (explorer.indexOf("firefox") >= 0) {
    let ver = explorer.match(/firefox\/([\d.]+)/)[1];
    return {name: "Firefox", version: ver};
  } else if (explorer.indexOf("chrome") >= 0) {
    let ver = explorer.match(/chrome\/([\d.]+)/)[1];
    return {name: "Chrome", version: ver};
  } else if (explorer.indexOf("opera") >= 0) {
    let ver = explorer.match(/opera.([\d.]+)/)[1];
    return {name: "Opera", version: ver};
  } else if (explorer.indexOf("Safari") >= 0) {
    let ver = explorer.match(/version\/([\d.]+)/)[1];
    return {name: "Safari", version: ver};
  }
  return {name: "Other", version: "1.0.0"};
}

/**
 * 生成uuid
 * @returns {string}
 */
function generateUUID() {
  let d = new Date().getTime();
  let uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
    let r = (d + Math.random() * 16) % 16 | 0;
    d = Math.floor(d / 16);
    return (c == 'x' ? r : (r & 0x3 | 0x8)).toString(16);
  });
  return uuid.replace(/-/g, '');
}

export {
  onConnect,
  onBindAccount,
  onUnbindAccount,
  onSendRequest
}
