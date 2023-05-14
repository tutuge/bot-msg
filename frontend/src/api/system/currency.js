import request from '@/utils/request'

// 查询平台币种列表
export function listCurrency(query) {
  return request({
    url: '/basic/currency/list',
    method: 'get',
    params: query
  })
}

// 查询平台所有币种列表
export function listAllCurrency() {
  return request({
    url: '/basic/currency/listAll',
    method: 'get'
  })
}

// 查询平台币种详细
export function getCurrency(id) {
  return request({
    url: '/basic/currency/' + id,
    method: 'get'
  })
}

// 新增平台币种
export function addCurrency(data) {
  return request({
    url: '/basic/currency',
    method: 'post',
    data: data
  })
}

// 修改平台币种
export function updateCurrency(data) {
  return request({
    url: '/basic/currency',
    method: 'put',
    data: data
  })
}

// 删除平台币种
export function delCurrency(id) {
  return request({
    url: '/basic/currency/' + id,
    method: 'delete'
  })
}
