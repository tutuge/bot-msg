import request from '@/utils/request'

// 查询币种充值网络列表
export function listNetwork(query) {
  return request({
    url: '/basic/network/list',
    method: 'get',
    params: query
  })
}

// 查询币种充值网络详细
export function getNetwork(id) {
  return request({
    url: '/basic/network/' + id,
    method: 'get'
  })
}

// 新增币种充值网络
export function addNetwork(data) {
  return request({
    url: '/basic/network',
    method: 'post',
    data: data
  })
}

// 修改币种充值网络
export function updateNetwork(data) {
  return request({
    url: '/basic/network',
    method: 'put',
    data: data
  })
}

// 删除币种充值网络
export function delNetwork(id) {
  return request({
    url: '/basic/network/' + id,
    method: 'delete'
  })
}
