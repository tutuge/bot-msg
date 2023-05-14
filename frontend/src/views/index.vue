<template>
  <div class="dashboard-editor-container">
<!--    <el-row>-->
<!--      <el-col :span="24">-->
<!--        <div class="date_container">-->
<!--          <span class="date">整体情况：{{currentDate}}</span>&nbsp;&nbsp;&nbsp;&nbsp;-->
<!--          <el-button @click="type = '2'" type="primary" size="mini">今日</el-button>-->
<!--          <el-button @click="type = '1'" type="primary" size="mini">昨日</el-button>-->
<!--		  <el-button @click="type = '3'" type="primary" size="mini">一周</el-button>-->
<!--		  <el-button @click="type = '4'" type="primary" size="mini">一月</el-button>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="24">-->
<!--        <div class="container">-->
<!--          <div class="title">平台总用户数</div>-->
<!--          <div class="value">{{allUserNums}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="24">-->
<!--        <div class="container">-->
<!--          <div class="title">存取差</div>-->
<!--          <div class="value">{{poorAccess}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">登录人数</div>-->
<!--          <div class="value">{{loginUsers}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">充值人数</div>-->
<!--          <div class="value">{{rechargeUserNums}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">提现人数</div>-->
<!--          <div class="value">{{cashUserNums}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">充值金额</div>-->
<!--          <div class="value">{{rechargeMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">提现金额</div>-->
<!--          <div class="value">{{cashMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">彩金总额</div>-->
<!--          <div class="value">{{giveMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    -->
<!--    <el-row>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">盈亏</div>-->
<!--          <div class="value">{{winLoss}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">理财总额</div>-->
<!--          <div class="value">{{financingMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">理财利润</div>-->
<!--          <div class="value">{{financingProfitMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">NFT成交额</div>-->
<!--          <div class="value">{{nftMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
<!--    <el-row>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">借贷总额</div>-->
<!--          <div class="value">{{loanMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--      <el-col :span="12">-->
<!--        <div class="container">-->
<!--          <div class="title">还款总额</div>-->
<!--          <div class="value">{{rePayLoanMoney}}</div>-->
<!--        </div>-->
<!--      </el-col>-->
<!--    </el-row>-->
    <!-- <el-dialog
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
    </el-dialog> -->

  </div>
</template>

<script>
import {bind, getindexData} from "@/api/system/index";
import moment from "moment";

export default {
  name: 'Index',
  data() {
    return {
      // 查询参数
      type: '',

      // queryParams: {
      //   type: undefined
      // },
      currentDate: '',
      enbleUser: '',
      dialogVisible: false,
      codeValue: '',
      googleKey: '',
      qr_code:'',
      allUserNums:'',
      loginUsers:'',
      rechargeUserNums:'',
      cashUserNums:'',
      rechargeMoney:'',
      cashMoney:'',
      poorAccess:'',
      winLoss:'',
      financingMoney:'',
      financingProfitMoney:'',
      nftMoney:'',
      loanMoney:'',
      rePayLoanMoney:'',
      giveMoney:''
    }
  },
  // watch: {
  //   type() {
  //     if(this.type=='1'){
  //       this.currentDate=this.getYesterday();
  //     }else{
  //       this.currentDate=this.getToday();
  //     }
  //     this.getData(this.type)
  //   }
  // },
  created() {
    this.init()
    // this.getData('2');
  },
  methods: {
    getYesterday() {
        let obj = {
            starttime: '',
            endtime: ''
        }
        obj.starttime = moment(moment().add(-1, 'days').startOf("day").valueOf()).format("YYYY-MM-DD");
        obj.endtime = moment(moment().add(-1, 'days').endOf('day').valueOf()).format('YYYY-MM-DD');
        return obj.endtime;
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
    getToday() {
        let obj = {
            starttime: '',
            endtime: ''
        }
        obj.starttime = moment(moment().startOf("day").valueOf()).format("YYYY-MM-DD");
        obj.endtime = moment(moment().valueOf()).format("YYYY-MM-DD");
        return obj.endtime
    },
    init() {
      let date = new Date()
      let y = date.getFullYear()
      let m = date.getMonth() + 1
      let d = date.getDate()
      m = m < 10 ? '0'+ m : m
      d = d < 10 ? '0'+ d : d
      this.currentDate = y+'-'+m+'-'+d

    },
    getData(type) {
      this.loading = true;
      const queryParams = {
        type: type
      }
      getindexData(queryParams).then(response => {
        console.log(response)
        this.allUserNums = response.data.allUserNums;
        this.loginUsers = response.data.loginUsers;
        this.rechargeUserNums = response.data.rechargeUserNums;
        this.cashUserNums = response.data.cashUserNums;
        this.rechargeMoney = response.data.rechargeMoney;
        this.cashMoney = response.data.cashMoney;
        this.poorAccess = response.data.poorAccess;
        this.winLoss = response.data.winLoss;
        this.financingMoney = response.data.financingMoney;
        this.financingProfitMoney = response.data.financingProfitMoney;
        this.nftMoney = response.data.nftMoney;
        this.loanMoney = response.data.loanMoney;
        this.rePayLoanMoney = response.data.rePayLoanMoney;
        this.giveMoney = response.data.giveMoney;
      });
    }
    
  }
}
</script>

<style lang="scss" scoped>
.dashboard-editor-container {
  // padding: 32px 0;
  background-color: rgb(240, 242, 245);
  position: relative;

  .chart-wrapper {
    background: #fff;
    padding: 16px 16px 0;
    margin-bottom: 32px;
  }
  .date_container {
    text-align: left;
    margin: 10px;
    background-color: #fff;
    padding: 10px;
  }
  .container {
    margin: 10px;
    text-align: center;
    background-color: #fff;
    .title {
      padding: 10px 0;
      border-bottom: 1px solid #eee;
    }
    .value {
      margin-top: 8px;
      padding-bottom: 10px;
    }
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
}

@media (max-width:1024px) {
  .chart-wrapper {
    padding: 8px;
  }
}
</style>
