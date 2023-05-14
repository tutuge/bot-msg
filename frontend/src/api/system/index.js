import request from '@/utils/request'

// 获取首页数据
export function getindexData(query) {
  return request({
    url: '/system/index/indexData',
    method: 'get',
    params: query
  })
}

export function checkUserBindGoogle() {
  return request({
    url: '/system/index/checkUserBindGoogle',
    method: 'get'
  })
}

export function bind(key,code) {
  const query = {
    "key":key,
    "code":code
  }
  return request({
    url: '/system/index/bindGoogle',
    method: 'get',
    params: query
  })
}

