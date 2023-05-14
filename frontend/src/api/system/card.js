import request from '@/utils/request'

// 查询前端展示的卡片列表
export function listCard(query) {
  return request({
    url: '/system/card/list',
    method: 'get',
    params: query
  })
}

// 查询前端展示的卡片详细
export function getCard(id) {
  return request({
    url: '/system/card/' + id,
    method: 'get'
  })
}

// 新增前端展示的卡片
export function addCard(data) {
  return request({
    url: '/system/card',
    method: 'post',
    data: data
  })
}

// 修改前端展示的卡片
export function updateCard(data) {
  return request({
    url: '/system/card',
    method: 'put',
    data: data
  })
}

// 删除前端展示的卡片
export function delCard(id) {
  return request({
    url: '/system/card/' + id,
    method: 'delete'
  })
}

// 导出前端展示的卡片
export function exportCard(query) {
  return request({
    url: '/system/card/export',
    method: 'get',
    params: query
  })
}