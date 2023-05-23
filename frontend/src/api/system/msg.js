import request from '@/utils/request'

// 查询【请填写功能名称】列表
export function listMsg(query) {
  return request({
    url: '/system/msg/list',
    method: 'get',
    params: query
  })
}

// 查询【请填写功能名称】详细
export function getMsg(id) {
  return request({
    url: '/system/msg/' + id,
    method: 'get'
  })
}

// 新增【请填写功能名称】
export function addMsg(data) {
  return request({
    url: '/system/msg',
    method: 'post',
    data: data
  })
}

// 修改【请填写功能名称】
export function updateMsg(data) {
  return request({
    url: '/system/msg',
    method: 'put',
    data: data
  })
}

// 删除【请填写功能名称】
export function delMsg(id) {
  return request({
    url: '/system/msg/' + id,
    method: 'delete'
  })
}

// 导出【请填写功能名称】
export function exportMsg(query) {
  return request({
    url: '/system/msg/export',
    method: 'get',
    params: query
  })
}