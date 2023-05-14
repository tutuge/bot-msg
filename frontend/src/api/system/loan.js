import request from '@/utils/request'

// 查询平台用户借贷基础资料列表
export function listLoan(query) {
  return request({
    url: '/system/loan/list',
    method: 'get',
    params: query
  })
}

// 查询平台用户借贷基础资料详细
export function getLoan(id) {
  return request({
    url: '/system/loan/' + id,
    method: 'get'
  })
}

// 新增平台用户借贷基础资料
export function addLoan(data) {
  return request({
    url: '/system/loan',
    method: 'post',
    data: data
  })
}

// 修改平台用户借贷基础资料
export function updateLoan(data) {
  return request({
    url: '/system/loan',
    method: 'put',
    data: data
  })
}

// 删除平台用户借贷基础资料
export function delLoan(id) {
  return request({
    url: '/system/loan/' + id,
    method: 'delete'
  })
}

// 导出平台用户借贷基础资料
export function exportLoan(query) {
  return request({
    url: '/system/loan/export',
    method: 'get',
    params: query
  })
}