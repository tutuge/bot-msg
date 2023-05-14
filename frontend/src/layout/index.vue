<template>
  <div :class="classObj" class="app-wrapper">
    <div v-if="device==='mobile'&&sidebar.opened" class="drawer-bg" @click="handleClickOutside" />
    <sidebar class="sidebar-container" />
    <div :class="{hasTagsView:needTagsView}" class="main-container">
      <div :class="{'fixed-header':fixedHeader}">
        <navbar />
        <tags-view v-if="needTagsView" />
      </div>
      <app-main />
      <right-panel v-if="showSettings">
        <settings />
      </right-panel>
    </div>
    <el-dialog
      title="启用Google"
      :visible.sync="dialogVisible"
      :show-close="false"
      :center="true"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
      class="google_dialog"
      width="25%">
      <div class="des">请在手机中打开Google Authenticator 扫描如下二维码输入6位动态码</div>
      <div class="qr_code">
        <img :src="qr_code" alt="">
      </div>
      <div class="input_container">
        <input v-model="codeValue" type="text" placeholder="动态码">
        <img src="../assets/logo/google.jpg" alt="">
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="bindCode">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import RightPanel from '@/components/RightPanel'
import { AppMain, Navbar, Settings, Sidebar, TagsView } from './components'
import ResizeMixin from './mixin/ResizeHandler'
import { mapState } from 'vuex'
import {checkUserBindGoogle,bind} from "@/api/system/index";
export default {
  name: 'Layout',
  data() {
    return {
      // 查询参数
      dialogVisible: false,
      googleKey: '',
      qr_code:'',
      codeValue: '',
    }
  },
  created() {
    // this.init();
  },
  components: {
    AppMain,
    Navbar,
    RightPanel,
    Settings,
    Sidebar,
    TagsView
  },
  mixins: [ResizeMixin],
  computed: {
    ...mapState({
      sidebar: state => state.app.sidebar,
      device: state => state.app.device,
      showSettings: state => state.settings.showSettings,
      needTagsView: state => state.settings.tagsView,
      fixedHeader: state => state.settings.fixedHeader
    }),
    classObj() {
      return {
        hideSidebar: !this.sidebar.opened,
        openSidebar: this.sidebar.opened,
        withoutAnimation: this.sidebar.withoutAnimation,
        mobile: this.device === 'mobile'
      }
    }
  },
  methods: {
    handleClickOutside() {
      this.$store.dispatch('app/closeSideBar', { withoutAnimation: false })
    },
    init(){
      checkUserBindGoogle().then(response => {
        console.log(response)
        let status = response.data.status;
        if(status==="0"){
          this.dialogVisible = true;
          this.googleKey=response.data.googleKey;
          this.qr_code = response.data.url;
        }
      });
    },
    bindCode() {
      // 提交数据
      console.log(this.codeValue);
      console.log(this.googleKey);
      bind(this.googleKey,this.codeValue).then(response => {
        if(response.data.status=="1"){
          // 成功关闭
          this.msgSuccess("绑定Google身份认证成功");
          this.dialogVisible = false
          //退出登录
          this.$store.dispatch('LogOut').then(() => {
            location.reload()
          })
        }else{
          this.msgError("验证码输入错误，请重新填写");
        }
      });
    },
  }
}
</script>

<style lang="scss" scoped>
  @import "~@/assets/styles/mixin.scss";
  @import "~@/assets/styles/variables.scss";

  .app-wrapper {
    @include clearfix;
    position: relative;
    height: 100%;
    width: 100%;

    &.mobile.openSidebar {
      position: fixed;
      top: 0;
    }
  }

  .drawer-bg {
    background: #000;
    opacity: 0.3;
    width: 100%;
    top: 0;
    height: 100%;
    position: absolute;
    z-index: 999;
  }

  .fixed-header {
    position: fixed;
    top: 0;
    right: 0;
    z-index: 9;
    width: calc(100% - #{$sideBarWidth});
    transition: width 0.28s;
  }

  .hideSidebar .fixed-header {
    width: calc(100% - 54px)
  }

  .mobile .fixed-header {
    width: 100%;
  }

  .google_dialog {
    .des {
      text-align: center;
    }
    .qr_code {
      width: 200px;
      height: 200px;
      margin: 20px auto;
      img {
        width: 100%;
        height: 100%;
      }
    }
    .input_container {
      position: relative;
      width: 60%;
      margin: 0 auto;
      border: 1px solid #ccc;
      input {
        width: 100%;
        outline: none;
        border: none;
        padding: 6px 10px 6px 36px; 
      }
      img {
        position: absolute;
        top: 0;
        left: 6px;
        bottom: 0;
        margin: auto;
        width: 15px;
        height: 15px;
      }
    }
  }
</style>
