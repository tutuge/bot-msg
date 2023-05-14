<template>
  <div>
    <div ref="toolbar" class="toolbar"></div>
    <div ref="editor" class="text"></div>
  </div>
</template>
<script>
  import E from 'wangeditor'
  import { getToken } from "@/utils/auth";

  export default {
    name: 'wangEditor',
    data() {
      return {
        editor: null,
        info: null
      }
    },
    model: {
      prop: 'value',
      event: 'change'
    },
    props: {
      value: {
        type: String,
        default: ''
      },
      isClear: {
        type: Boolean,
        default: false
      }
    },
    watch: {
      isClear(val) {
        // 触发清除文本域内容
        if (val) {
          this.editor.txt.clear()
          this.info = null
        }
      },
      //value为编辑框输入的内容即父组件的v-model的值
      value: function(value) {
        if (value !== this.editor.txt.html()) {
          this.editor.txt.html(this.value)
        }
      }
    },
    mounted() {
      this.initEditor()
      this.editor.txt.html(this.value)
    },
    // 销毁编辑器
    beforeDestroy() {
      this.editor.destroy()
      this.editor = null
    },
    methods: {

      initEditor() {
        this.editor = new E(this.$refs.toolbar, this.$refs.editor)
        this.editor.config.uploadImgShowBase64 = false // 是否设置base64存储图片
        this.editor.config.uploadImgServer = process.env.VUE_APP_BASE_API + "/common/upload"// 配置服务器端地址
        this.editor.config.uploadImgHeaders = { Authorization: "Bearer " + getToken()}// 自定义 header
        this.editor.config.uploadFileName = 'file' // 后端接受上传文件的参数名
       // this.editor.config.uploadImgMaxSize = 2 * 1024 * 1024 // l将图片大小限制为 2M
        this.editor.config.uploadImgMaxLength = 3 // 限制一次最多上传 3 张图片
       // this.editor.config.uploadImgTimeout = 3 * 60 * 1000 // 设置超时时间
        this.editor.config.showLinkImg = false //隐藏插入网络图片的功能
        // 设置编辑区域高度为 500px
        this.editor.config.height = 500

        // 配置菜单
        this.editor.config.menus = [
          'head', // 标题
          'bold', // 粗体
          'fontSize', // 字号
          'fontName', // 字体
          'italic', // 斜体
          'underline', // 下划线
          'strikeThrough', // 删除线
          'foreColor', // 文字颜色
          'backColor', // 背景颜色
          'link', // 插入链接
          'list', // 列表
          'justify', // 对齐方式
          'quote', // 引用
          'emoticon', // 表情
          'image', // 插入图片
          'table', // 表格
          'video', // 插入视频
          'code', // 插入代码
          'undo', // 撤销
          'redo', // 重复
          'fullscreen' // 全屏
        ]

        this.editor.config.uploadImgHooks = {
          // 上传图片之前
          before: function(xhr) {
            console.log(xhr)
            // 上传之前的一些判断操作,可阻止图片上传
           /* return {
              prevent: true,
              msg: '需要提示给用户的错误信息'
            }*/
          },
          // 图片上传并返回了结果，图片插入已成功
          success: function(xhr) {
            console.log('success', xhr)
          },
          // 图片上传并返回了结果，但图片插入时出错了
          fail: function(xhr, editor, resData) {
            console.log('fail', resData)
          },
          // 上传图片出错，一般为 http 请求的错误
          error: function(xhr, editor, resData) {
            console.log('error', xhr, resData)
          },
          // 上传图片超时
          timeout: function(xhr) {
            console.log('timeout')
          },
          // 图片上传并返回了结果，想要自己把图片插入到编辑器中
          // 例如服务器端返回的不是 { errno: 0, data: [...] } 这种格式，可使用 customInsert
          customInsert: function(insertImgFn, result) {
            // result 即服务端返回的接口
            console.log('customInsert', result)
            //insertImgFn 可把图片插入到编辑器，传入图片 src ，执行函数即可
            //我的后端接口返回的格式为{code:0,data:'url地址'}
            insertImgFn(result.url)
          }
        }
        this.editor.config.onchange = (html) => {
          this.info = html
          this.$emit('change', this.info) // 将内容同步到父组件中
        }
        // 创建富文本编辑器
        this.editor.create()
      }
    }
  }
</script>

<style>
  .toolbar {
    border: 1px solid #ccc;
  }
  .text {
    border: 1px solid #ccc;
    height: 400px;
  }
</style>
