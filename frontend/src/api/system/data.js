import request from '@/utils/request'

// 查询新币K线列表
export function listData(query) {
  return request({
    url: '/system/data/list',
    method: 'get',
    params: query
  })
}

// 查询新币K线详细
export function getData(klineId) {
  return request({
    url: '/system/data/' + klineId,
    method: 'get'
  })
}

// 新增新币K线
export function addData(data) {
  return request({
    url: '/system/data',
    method: 'post',
    data: data
  })
}

// 修改新币K线
export function updateData(data) {
  return request({
    url: '/system/data',
    method: 'put',
    data: data
  })
}

// 删除新币K线
export function delData(klineId) {
  return request({
    url: '/system/data/' + klineId,
    method: 'delete'
  })
}

// 导出新币K线
export function exportData(query) {
  return request({
    url: '/system/data/export',
    method: 'get',
    params: query
  })
}