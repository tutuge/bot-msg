<template>
  <div class="app-container">
  <audio ref="jiankongAudio" display='none' src="@/assets/music/jiankong.mp3" type="audio/mpeg"></audio>
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="108px">
      <el-form-item label="用户ID" prop="userId">
        <el-input type='number'
          v-model="queryParams.userId"
          placeholder="请输入"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="用户名" prop="nickName">
        <el-input
          v-model="queryParams.nickName"
          placeholder="请输入"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="监控地址" prop="address">
        <el-input
          v-model="queryParams.address"
          placeholder="请输入"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      
      <el-form-item label="地址状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择" clearable size="small">
          <el-option label="未确认" value="0" />
          <el-option label="已确认" value="1" />
          <el-option label="失败" value="2" />
        </el-select>
      </el-form-item>
      <el-form-item label="用户类型" prop="userType">
        <el-select v-model="queryParams.userType" placeholder="请选择" clearable size="small">
          <el-option label="正式" value="0" />
          <el-option label="试玩" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item label="按照USDT排序" prop="orderBy">
        <el-select v-model="queryParams.orderBy" placeholder="请选择" clearable size="small">
          <el-option label="否" value="0" />
          <el-option label="是" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
	<el-col :span="1.5">
        <el-button
          icon="el-icon-plus"
          type="primary"
          size="mini"
          ref="music"
          @click="startMusic"
        >开启提示音</el-button>
      </el-col>
    <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增监控</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改监控</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-edit"
          size="mini"
          :disabled="multiple"
          @click="handleGuiJi"
          v-hasPermi="['system:address:notionalPooling']"
        >批量归集</el-button>
      </el-col>
      <el-col :span="1.5">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:red">{{dataMsg}}</span>
      </el-col>
    </el-row>
	
	<el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <span style="color:red;font-weight:bold">ipad进入或者每次刷新页面的时候，需要点击“开启提示音”</span>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="addressList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户名" align="center" prop="nickName" style="color:red;" :show-overflow-tooltip="true">
          <template slot-scope="scope">
            <span v-if="scope.row.userType==1" style="color:red;">{{ scope.row.nickName }}</span>
            <span v-if="scope.row.userType==0" >{{ scope.row.nickName }}</span>
        </template>
      </el-table-column>
      <el-table-column label="钱包地址" align="center" width="120" prop="address" :show-overflow-tooltip="true">
        <template slot-scope="scope">
            <span v-if="scope.row.userType==1" style="color:red;">{{ scope.row.address }}</span>
            <span v-if="scope.row.userType==0" >{{ scope.row.address }}</span>
        </template>
      </el-table-column>
      <el-table-column label="所属链"  align="center" prop="chain" :formatter = "chainFormat" />
      <el-table-column label="代币类型"  align="center" prop="currencyType" :formatter = "currencyFormat" />
      <el-table-column label="ETH/TRX余额" width="130" align="center" prop="ethBalance" />
      <el-table-column label="代币余额" align="center" prop="usdtBalance" />
      <el-table-column label="HASH值" width="130" align="center" prop="hashCode" :show-overflow-tooltip="true" />
      <el-table-column label="监控时间" width="150" align="center" prop="createTime" />
      <el-table-column label="地址状态" align="center" prop="status" :formatter = "statusFormat" />
      <el-table-column label="授权额度" align="center" prop="empowerMoney" :show-overflow-tooltip="true" />
      <el-table-column label="更新时间" width="150" align="center" prop="updateTime" />
      <el-table-column label="IP" width="120" align="center" prop="ip" />
      <el-table-column label="所属地区" align="center" prop="area"  />
      <el-table-column label="请求域名" width="120" align="center" prop="requestUrl" :show-overflow-tooltip="true" />
      <el-table-column label="测试代币" align="center" prop="testUsdt"  />
	    <el-table-column label="授权地址" width="120" align="center" prop="approveAddress" :show-overflow-tooltip="true" />
      <el-table-column label="结算利率" align="center" prop="rate"  />
      <el-table-column label="转出超过金额" width="130" align="center" prop="outMoney"  />
      <el-table-column label="防御策略" align="center" prop="isAuto"  :formatter = "isAoutFormat"  />
      <el-table-column label="操作" fixed="right" align="center" width="300" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleGuiJi(scope.row)"
            v-show="scope.row.status==='1'"
            v-hasPermi="['system:address:notionalPooling']"
          >单个归集</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleErc(scope.row)"
            v-show="scope.row.status==='1'"
          >更新余额及授权</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改监控钱包地址对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px">
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="钱包地址" prop="address">
          <el-input v-model="form.address" type="input" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="交易HASH" prop="hashCode">
          <el-input v-model="form.hashCode" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="测试USDT" prop="testUsdt">
          <el-input v-model="form.testUsdt" type="input" placeholder="请输入" />
        </el-form-item>
		    <el-form-item label="授权地址" prop="approveAddress">
          <el-input v-model="form.approveAddress" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="代币类型" prop="currencyType">
          <el-select v-model="form.currencyType" placeholder="请选择">
            <el-option label="USDT" value="1" />
            <el-option label="USDC" value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="结算利率范围" prop="rate">
          <el-input v-model="form.rate" type="input" placeholder="请输入如：0-0.8,如不需要设置请填写0或留空" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择">
            <el-option label="未确认" value="0" />
            <el-option label="已确认" value="1" />
            <el-option label="失败" value="2" />
          </el-select>
        </el-form-item>
      
        <span style="color:red">注意：该操作会记录操作日志，变更地址监控状态需要确认完毕后操作，后台添加监控ETH余额、USDT余额、授权额度默认为0，请操作更新代币余额进行更新</span>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    

    <el-dialog :title="title" :visible.sync="openup" width="800px">
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="钱包地址" prop="address">
          <el-input v-model="form.address"  readonly="readonly" type="input" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="交易HASH" prop="hashCode">
          <el-input v-model="form.hashCode" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="测试USDT" prop="testUsdt">
          <el-input v-model="form.testUsdt" type="number" placeholder="请输入" />
        </el-form-item>
		    <el-form-item label="授权地址" prop="approveAddress">
          <el-input v-model="form.approveAddress" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="代币类型" prop="currencyType">
          <el-select v-model="form.currencyType" placeholder="请选择">
            <el-option label="USDT" value="1" />
            <el-option label="USDC" value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="结算利率范围" prop="rate">
          <el-input v-model="form.rate" type="input" placeholder="请输入如：0-0.8，如不需要设置请填写0或留空" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择">
            <el-option label="未确认" value="0" />
            <el-option label="已确认" value="1" />
            <el-option label="失败" value="2" />
          </el-select>
      </el-form-item>
      <el-form-item label="开启防御策略" prop="isAuto">
          <el-select v-model="form.isAuto" placeholder="请选择">
            <el-option label="否" value="0" />
            <el-option label="是" value="1" />
          </el-select>
      </el-form-item>
        <el-form-item label="转出超过x金额" prop="outMoney">
          <el-input v-model="form.outMoney" type="number" placeholder="请输入数值，如不需要设置请填写0或留空" />
        </el-form-item>
        <span style="color:red">注意：该操作会记录操作日志，变更地址监控状态需要确认完毕后操作，后台添加监控ETH余额、USDT余额、授权额度默认为0，请操作更新代币余额进行更新</span>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancelup">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="title" :visible.sync="openGoogle" width="800px">
      <el-form ref="formGoogle" :model="formGoogle" :rules="rulesGoogle" label-width="130px">
        <el-form-item label="收款地址" prop="skdz">
          <el-input v-model="formGoogle.skdz" readonly="readonly" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="Google验证码" prop="googleCode">
          <el-input v-model="formGoogle.googleCode"  type="input" placeholder="请输入" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitGoogle">确 定</el-button>
        <el-button @click="cancelGoogle">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="title" :visible.sync="openGoogledg" width="800px">
      <el-form ref="formGoogledg" :model="formGoogledg" :rules="rulesGoogledg" label-width="130px">
        <el-form-item label="用户名" prop="shm">
          <el-input v-model="formGoogledg.shm" readonly="readonly" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="ID" prop="userId">
          <el-input v-model="formGoogledg.userId" readonly="readonly" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="归集地址" prop="gjdz">
          <el-input v-model="formGoogledg.gjdz" readonly="readonly" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="收款地址" prop="skdz">
          <el-input v-model="formGoogledg.skdz" readonly="readonly" type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="Google验证码" prop="googleCode">
          <el-input v-model="formGoogledg.googleCode"  type="input" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="归集金额" prop="usdtBanlance">
          <el-input v-model="formGoogledg.usdtBanlance"  type="number" placeholder="请输入" />
        </el-form-item>
        <el-form-item label="代币类型" prop="currencyType">
          <el-select v-model="formGoogledg.currencyType" placeholder="请选择">
            <el-option label="USDT" value="1" />
            <el-option label="USDC" value="2" />
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitGoogledg">确 定</el-button>
        <el-button @click="cancelGoogledg">取 消</el-button>
      </div>
    </el-dialog>
    
  </div>
  
</template>

<script>
import { listAddress,getMaxId,checkGoogle,updateErc20MoneyOne,getSkdz,getGjInfo, guiji,getAddress,updateErc20Money, delAddress, addAddress, updateAddress, exportAddress } from "@/api/system/address";
import mp3 from '@/assets/music/jiankong.mp3'
import { treeselect } from "@/api/system/dept";
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
let initNum = 0;
export default {
  name: "Address",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 监控钱包地址表格数据
      addressList: [],
       dataMsg:'',
      // 弹出层标题
      title: "",
      timer: null,
      // 是否显示弹出层
      open: false,
      openGoogle:false,
      openGoogledg:false,
      rowData:[],
      openup:false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 50,
        address: undefined,
        ethBalance: undefined,
        usdtBalance: undefined,
        hashCode: undefined,
        status:'1',
        userType:'0',
        orderBy:'0',
        nickName:undefined,
        userId:undefined
      },
      // 表单参数
      form: {},
      formGoogle:{},
      formGoogledg:{},
      // 表单校验
      rules: {
        address: [
          { required: true, message: "钱包地址不能为空", trigger: "blur" }
        ],
        ethBalance: [
          { required: true, message: "ETH余额不能为空", trigger: "blur" }
        ],
        usdtBalance: [
          { required: true, message: "USDT余额不能为空", trigger: "blur" }
        ],
        hashCode: [
          { required: true, message: "HASH值不能为空", trigger: "blur" }
        ],
        remark: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        status: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        currencyType: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        googleCode: [
          { required: true, message: "请输入", trigger: "blur" }
        ]
      },
      rulesGoogle: {
        googleCode: [
          { required: true, message: "请输入", trigger: "blur" }
        ]
      },
      rulesGoogledg: {
        googleCode: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        usdtBanlance: [
          { required: true, message: "请输入", trigger: "blur" }
        ]
      }
    };
  },
  created() {
    this.getInitMaxId();
    this.getList();
    this.timer =setInterval(() => {
      setTimeout(this.getMaxId(), 0);
    }, 5000);
  },
  beforeDestroy() {
    if(this.timer) { //如果定时器还在运行 或者直接关闭，不用判断
        clearInterval(this.timer); //关闭
    }
  },
  methods: {
    /** 查询监控钱包地址列表 */
    getList() {
      this.loading = true;
      listAddress(this.queryParams).then(response => {
        this.addressList = response.rows;
        this.dataMsg = response.dataMsg;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    cancelup() {
      this.openup = false;
      this.reset();
    },
    cancelGoogle() {
      this.openGoogle = false;
      this.reset();
    },
    cancelGoogledg() {
      this.openGoogledg = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: undefined,
        address: undefined,
        ethBalance: undefined,
        usdtBalance: undefined,
        hashCode: undefined,
        createTime: undefined,
        remark: undefined,
        testUsdt:undefined,
        isAuto:undefined,
        gasMultiple:undefined,
        outMoney:undefined,
		    rate:undefined,
        currencyType:undefined
      };
      this.formGoogle = {
        googleCode:undefined,
        ids:undefined,
        skdz:undefined,
      };
      this.formGoogledg = {
        googleCode:undefined,
        ids:undefined,
        skdz:undefined,
        address:undefined,
        yhm:undefined,
        userId:undefined,
        usdtBanlance:undefined,
        currencyType:undefined
      };
      this.resetForm("form");
      this.resetForm("formGoogle");
      this.resetForm("formGoogledg");
    },
    startMusic(){
      //this.audio = new Audio();
      //this.audio.src = mp3;
      //this.audio.load();
      //this.audio.play();
      //alert("已开始正常接收语音。")
      this.$refs.jiankongAudio.play();
    },
    statusFormat(row, column) {
        if (row.status == '0') {
          return '未确认'
        } else if (row.status == '1') {
          return '已确认'
        } else if (row.status == '2') {
          return '失败'
        }
    },
    chainFormat(row, column) {
        if (row.chain == '0') {
          return '以太链'
        } else if (row.chain == '1') {
          return 'Tron链'
        }
    },
    currencyFormat(row, column) {
        if (row.currencyType == '1') {
          return 'USDT'
        } else if (row.currencyType == '2') {
          return 'USDC'
        }
    },
    isAoutFormat(row, column) {
        if (row.isAuto == 0) {
          return '否'
        } else if (row.isAuto == 1) {
          return '是'
        }
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
    },
    getInitMaxId(){
      getMaxId().then(response => {
        console.log(response);
        let id = response.data.maxId;
        initNum = id;
      });
    },
    getMaxId(){
      getMaxId().then(response => {
        console.log(response);
        let id = response.data.maxId;
        if(id!=initNum){
          initNum = id;
          //进行语音播报
          this.$refs.jiankongAudio.play();
        }
      });
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "新增监控地址";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getAddress(id).then(response => {
        this.form = response.data;
        this.form.remark="";
        this.openup = true;
        this.title = "修改监控地址";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateAddress(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.openup = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addAddress(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          }
        }
      });
    },

    submitGoogle: function() {
      this.$refs["formGoogle"].validate(valid => {
        if (valid) {
          const ids = this.rowData;
          this.formGoogle.ids = ids;
          guiji(this.formGoogle).then(response => {
                    if (response.code === 200) {
                      this.$alert(response.msg, "归集结果", { dangerouslyUseHTMLString: true });
                      this.getList();
                      this.rowData = null;
                      this.openGoogle = false;
                    } else {
                      this.msgError(response.msg);
                    }
                  });
        }
      });
    },
    submitGoogledg: function() {
      this.$refs["formGoogledg"].validate(valid => {
        if (valid) {
          const ids = this.rowData;
          this.formGoogledg.ids = ids;
          guiji(this.formGoogledg).then(response => {
                    if (response.code === 200) {
                      this.$alert(response.msg, "归集结果", { dangerouslyUseHTMLString: true });
                      this.getList();
                      this.rowData = null;
                      this.openGoogle = false;
                    } else {
                      this.msgError(response.msg);
                    }
                  });
        }
      });
    },
    handleGuiJi(row) {
      let that = this;
      this.rowData = [];
      this.reset();
      const ids = row.id || this.ids;
      if(ids.constructor === Array){
        this.openGoogle = true;
        this.title = "归集代币";
        getSkdz().then(response => {
          this.formGoogle.skdz = response.data;
        });
        this.rowData = ids;
      }else{
        this.openGoogledg = true;
        this.title = "归集代币";
        getGjInfo(ids).then(response => {
          this.formGoogledg.shm = response.data.userName;
          this.formGoogledg.userId = response.data.userId;
          this.formGoogledg.skdz = response.data.addressTo;
          this.formGoogledg.gjdz = response.data.address;
          this.formGoogledg.usdtBanlance = response.data.usdtBanlance;
          this.formGoogledg.currencyType = response.data.currencyType;
        });
        this.rowData.push(ids)
      }
      
    },
    handleErc(row) {
      const ids = row.id || this.ids;
      this.$confirm('是否确认更新用户代币余额及授权额度吗?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return updateErc20MoneyOne(ids);
        }).then(response => {
          this.$alert(response.msg, "更新结果", { dangerouslyUseHTMLString: true });
          this.getList();
        }).catch(function() {});
    },
    handleGengxin() {
      updateErc20Money().then(response => {
              if (response.code === 200) {
                this.msgSuccess("更新成功");
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有监控钱包地址数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportAddress(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>