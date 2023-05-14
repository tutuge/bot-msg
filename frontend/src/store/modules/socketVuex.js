import Vue from 'vue'
import Vuex from 'vuex'
import '../../api/websocket/message.js'
import '../../api/websocket/replybody.js'
import '../../api/websocket/sentbody.js'

Vue.use(Vuex)

/*CIM服务器IP*/
const CIM_HOST = window.location.hostname;
/*
 * 服务端 websocket端口
 */
const CIM_PORT = 45678;
const CIM_URI = "ws://" + CIM_HOST + ":" + CIM_PORT;

const DATA_HEADER_LENGTH = 1;
const PONG = 0;
const PING = 1;
const MESSAGE = 2;
const SENT_BODY = 3;
/**
 * PONG字符串转换后
 * @type {Uint8Array}
 */
const PONG_BODY = new Uint8Array([80, 79, 78, 71]);

export default new Vuex.Store({
  state: {
    ws: null, //建立的连接
    lockReconnect: false, //是否真正建立连接
    timeout: 15000, //15秒一次心跳
    timeoutObj: null, //心跳心跳倒计时
    serverTimeoutObj: null, //心跳倒计时
    timeoutNum: null, //断开 重连倒计时
    msg: {} //接收到的信息
  },
  // getters: {
  //   // 获取接收的信息
  //   socketMsgs: state => state.msg
  // },
  mutations: {
    //初始化ws 用户登录后调用
    webSocketInit(state) {
      let that = this
      //this 创建一个state.ws对象【发送、接收、关闭socket都由这个对象操作】
      state.ws = new WebSocket(CIM_URI);
      state.ws.cookieEnabled = false;
      state.ws.binaryType = 'arraybuffer';
      state.ws.onopen = function (res) {
        console.log("Connection success...");
        /**
         * 启动心跳检测
         */
        that.commit("start");
      }
      state.ws.onmessage = function (res) {
        let data = new Uint8Array(res.data);
        let type = data[0];
        let body = data.subarray(DATA_HEADER_LENGTH, data.length);
        if (type === PING) {
          if (state.ws.readyState === 1) {
            //如果连接正常
            let pong = new Uint8Array(PONG_BODY.byteLength + 1);
            pong[0] = PONG;
            pong.set(PONG_BODY, 1);
            state.ws.send(pong);
            // 收到服务器信息，心跳重置
            that.commit("reset");
          }
        } else if (type === MESSAGE) {
          let message = proto.com.hashGame.netty.api.domain.proto.Message.deserializeBinary(body);
          state.msg = message.toObject(false);
          console.log("当前消息为：", state.msg)
        }
      }
      state.ws.onclose = function (res) {
        console.log("Connection closed...");
        //重连
        that.commit('reconnect');
      }
      state.ws.onerror = function (res) {
        console.log("Connection error...");
        //重连
        that.commit('reconnect');
      }
    },
    webSocketClose(state) {
      if (state.ws) {
        state.ws.onclose = function (res) {
          console.log("Connection closing...", res);
        };
      }
    },
    reconnect(state) {
      //重新连接
      let that = this;
      if (state.lockReconnect) {
        return;
      }
      state.lockReconnect = true;
      //没连接上会一直重连,30秒重试请求重连，设置延迟避免请求过多
      state.timeoutNum &&
      clearTimeout(state.timeoutNum);
      console.log("重连-->", state.timeoutNum)
      state.timeoutNum = setTimeout(() => {
        //新连接
        that.commit('webSocketInit')
        state.lockReconnect = false;
      }, 1000);
    },
    reset(state) {
      //重置心跳
      let that = this;
      //清除时间
      clearTimeout(state.timeoutObj);
      clearTimeout(state.serverTimeoutObj);
      //重启心跳
      that.commit('start')
    },

    start(state) {
      //开启心跳
      var self = this;
      state.timeoutObj &&
      clearTimeout(state.timeoutObj);
      state.serverTimeoutObj &&
      clearTimeout(state.serverTimeoutObj);
      state.timeoutObj = setTimeout(() => {
        console.log("ws状态...", state.ws.readyState)
        //这里发送一个心跳，后端收到后，返回一个心跳消息，
        if (state.ws.readyState === 1) {
          //如果连接正常
          let pong = new Uint8Array(PONG_BODY.byteLength + 1);
          pong[0] = PONG;
          pong.set(PONG_BODY, 1);
          state.ws.send(pong);
        } else {
          //否则重连
          self.commit('reconnect');
        }
        state.serverTimeoutObj = setTimeout(function () {
          //超时关闭
          state.ws.close();
        }, state.timeout);
      }, state.timeout);
    },

    webSocketSend(state, counter) {
    },
    /**
     * 绑定房间
     * @param state
     * @param obj
     */
    bindAccount(state, obj) {
      var self = this;
      let body = new proto.com.hashGame.netty.api.domain.proto.SentBody();
      //注意此处，设置key是为了后端能否选定对应处理的handler，client_bind为绑定客户端到服务器
      //配合上对应的roomId和用户信息，即可实现对应channel和channel组群的管理
      body.setKey("client_bind");
      body.setTimestamp(new Date().getTime());
      body.getDataMap().set("userId", obj.account);
      body.getDataMap().set("userType", obj.userType);
      body.getDataMap().set("roomId", obj.roomId);
      self.commit('sendRequest', body);
    },

    /**
     * 取消对某个房间的订阅
     * @param roomId
     */
    unBindAccount(roomId) {
      var self = this;
      let body = new proto.com.hashGame.netty.api.domain.proto.SentBody();
      body.setKey("client_subscribe");
      body.getDataMap().set("roomId", roomId);
      self.commit('sendRequest', body);
    },
    /**
     *测试pingpong
     */
    pingPong() {
      var self = this;
      let body = new proto.com.hashGame.netty.api.domain.proto.SentBody();
      body.setKey("ping_pong");
      self.commit('sendRequest', body);
    },

    /**
     * 执行具体的发送
     * @param state
     * @param body
     */
    sendRequest(state, body) {
      let data = body.serializeBinary();
      let protobuf = new Uint8Array(data.length + 1);
      protobuf[0] = SENT_BODY;
      protobuf.set(data, 1);
      state.ws.send(protobuf);
    }
  },
  actions: {
    webSocketInit({
                    commit
                  }, url) {
      commit('webSocketInit', url)
    },
    /**
     * 发送消息
     * @param commit
     * @param p
     */
    webSocketSend({
                    commit
                  }, p) {
      commit('webSocketSend', p)
    },
    bindAccount({
                  commit
                }, obj) {
      commit('bindAccount', obj)
    },
    unBindAccount({
                    commit
                  }, roomId) {
      commit('unBindAccount', roomId)
    },
    pingPong({
               commit
             },) {
      commit('pingPong')
    },
    webSocketClose({
                     commit
                   }) {
      commit('webSocketClose')
    }
  }
});
