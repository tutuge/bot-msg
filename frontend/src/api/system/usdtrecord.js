import request from '@/utils/request'

// 查询用户usdt变动记录列表
export function listRecord(query) {
  return request({
    url: '/system/usdtrecord/list',
    method: 'get',
    params: query
  })
}

// 查询用户usdt变动记录详细
export function getRecord(id) {
  return request({
    url: '/system/usdtrecord/' + id,
    method: 'get'
  })
}

// 新增用户usdt变动记录
export function addRecord(data) {
  return request({
    url: '/system/usdtrecord',
    method: 'post',
    data: data
  })
}

// 修改用户usdt变动记录
export function updateRecord(data) {
  return request({
    url: '/system/usdtrecord',
    method: 'put',
    data: data
  })
}

// 删除用户usdt变动记录
export function delRecord(id) {
  return request({
    url: '/system/usdtrecord/' + id,
    method: 'delete'
  })
}

// 导出用户usdt变动记录
export function exportRecord(query) {
  return request({
    url: '/system/usdtrecord/export',
    method: 'get',
    params: query
  })
}

export function getMaxId() {
  return request({
    url: '/system/usdtrecord/getMaxId',
    method: 'get'
  })
}