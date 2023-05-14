<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="标题" prop="ptitle">
        <el-input
          v-model="queryParams.ptitle"
          placeholder="请输入标题"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
        >导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="productinfoList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="产品名称" width="110" align="center" prop="ptitle" />
      <el-table-column label="产品全称" width="110" align="center" prop="fullName" />
      <el-table-column label="产品代码" width="90" align="center" prop="procode" />
      <el-table-column label="风控波动范围" width="140" align="center" prop="pointLow" />
      <el-table-column label="随机波动范围" width="140"  align="center" prop="rands" />
      <el-table-column label="时间玩法间隔" width="140"  align="center" prop="protime" />
      <el-table-column label="(合约)涨跌点金额" width="140"  align="center" prop="pointMoney" />
      <el-table-column label="盈亏比例" width="150" align="center" prop="proscale" />
      <el-table-column label="杠杆倍数" align="center" prop="gearing" />
      <el-table-column label="最低下单USD" width="140"  align="center" prop="minOrder" />
      <el-table-column label="最高下单USD" width="140" align="center" prop="maxOrder" />
      <el-table-column label="手续费比例" width="140" align="center" prop="commission" />
      <el-table-column label="是否开市" align="center" prop="isopen" >
            <template slot-scope="scope">
              <el-switch
                v-model="scope.row.isopen"
                active-value="0"
                inactive-value="1"
                @change="handleOpenChange(scope.row)"
              ></el-switch>
            </template>
      </el-table-column>
      <el-table-column  fixed="right"  label="操作" width="200" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            icon="el-icon-success"-->
<!--            @click="configLc(scope.row)"-->
<!--          >配置理财</el-button>-->
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

    <!-- 添加或修改产品信息对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="900px">
      <el-form ref="form" :model="form" :rules="rules" label-width="130px">
        <!-- <el-form-item label="产品名称" prop="ptitle">
          <el-input v-model="form.ptitle" placeholder="请输入产品名称" />
        </el-form-item>
        <el-form-item label="英文" prop="ptitleEn">
          <el-input v-model="form.ptitleEn" placeholder="请输入英文产品名称" />
        </el-form-item>
        <el-form-item label="繁体" prop="ptitleTw">
          <el-input v-model="form.ptitleTw" placeholder="请输入繁体产品名称" />
        </el-form-item>
        <el-form-item label="法语" prop="ptitleFc">
          <el-input v-model="form.ptitleFc" placeholder="请输入法语产品名称" />
        </el-form-item>
        <el-form-item label="印尼" prop="ptitleIs">
          <el-input v-model="form.ptitleIs" placeholder="请输入印尼产品名称" />
        </el-form-item>
        <el-form-item label="西班牙" prop="ptitleSh">
          <el-input v-model="form.ptitleSh" placeholder="请输入西班牙产品名称" />
        </el-form-item>
        <el-form-item label="阿拉伯" prop="ptitleArb">
          <el-input v-model="form.ptitleArb" placeholder="请输入阿拉伯产品名称" />
        </el-form-item>
        <el-form-item label="日本" prop="ptitleJp">
          <el-input v-model="form.ptitleJp" placeholder="请输入日本产品名称" />
        </el-form-item>
        <el-form-item label="韩国" prop="ptitleKr">
          <el-input v-model="form.ptitleKr" placeholder="请输入韩国产品名称" />
        </el-form-item>
        <el-form-item label="越南" prop="ptitleVt">
          <el-input v-model="form.ptitleVt" placeholder="请输入越南产品名称" />
        </el-form-item>
        <el-form-item label="印地" prop="ptitleHd">
          <el-input v-model="form.ptitleHd" placeholder="请输入印地产品名称" />
        </el-form-item>
        <el-form-item label="德国" prop="ptitleDm">
          <el-input v-model="form.ptitleDm" placeholder="请输入德国产品名称" />
        </el-form-item>
        <el-form-item label="泰国" prop="ptitleThai">
          <el-input v-model="form.ptitleThai" placeholder="请输入泰国产品名称" />
        </el-form-item> -->
        <el-form-item label="产品名称" prop="ptitle">
          <el-input v-model="form.ptitle" placeholder="请输入产品名称" />
        </el-form-item>
        <el-form-item label="产品全称" prop="fullName">
          <el-input v-model="form.fullName" placeholder="请输入产品全称" />
        </el-form-item>
        <el-form-item label="产品代码" prop="procode">
          <el-input v-model="form.procode" placeholder="请输入产品代码" />
        </el-form-item>
        <!-- <el-form-item label="产品logo" prop="picUrl">
          <el-input v-model="form.picUrl" type="hidden" />
          <el-upload
              action="/prod-api/system/upload/imgUpload"
              ref="upload"
              list-type="picture-card"
              accept="image/*"
              :limit="imgLimit"
              :headers="importHeaders"
              :file-list="productImgs"
              :multiple="isMultiple"
              :on-preview="handlePictureCardPreview"
              :on-remove="handleRemove"
              :on-success="handleAvatarSuccess"
              :before-upload="beforeAvatarUpload"
              :on-exceed="handleExceed"
              :on-error="imgUploadError">
              <i class="el-icon-plus"></i>
          </el-upload>
          <el-dialog :visible.sync="dialogVisible">
            <img width="100%" :src="form.remark" alt="">
          </el-dialog>
        </el-form-item> -->
        <el-form-item label="产品LOGO" prop="fileList">
            <imageUpload
              :value="form.fileList"
              @input="(e) => getImg(e)"
            ></imageUpload>
        </el-form-item>
        <el-form-item label="小数点位数" prop="decimalPlaces">
          <el-input v-model="form.decimalPlaces" type="number" placeholder="请输入小数点位数" />
          <span style="color:red">注意： 小数点位数是产品行情数据小数点几位。</span>
        </el-form-item>
        <el-form-item label="随机波动范围" prop="rands">
          <el-input v-model="form.rands" type="number" placeholder="请输入随机波动范围" />
          <span style="color:red">注意： 产品获取接口值后，会加上+-此处的值。如5，则在接口获取的数据中加上-5~5之间的随机数。</span>
        </el-form-item>
        <el-form-item label="风控波动最小值" prop="pointLow">
          <el-input v-model="form.pointLow" type="number" placeholder="请输入波动最小值" />
        </el-form-item>
        <el-form-item label="风控波动最大值" prop="pointTop">
          <el-input v-model="form.pointTop" type="number" placeholder="请输入波动最大值" />
          <span style="color:red">注意：客户的期权订单在条件范围内时，会根据订单的涨或跌，自动减或加最小值与最大值之间的随机数，不开启请填写0</span>
        </el-form-item>
        <el-form-item label="时间玩法间隔" prop="protime">
          <el-input v-model="form.protime" placeholder="请输入时间玩法间隔,用逗号隔开" />
          <span style="color:red">注意： 如时间为：1分、3分、5分、8分，则请用字母逗号将时间分开，如输入：1,3,5,8。如没有此玩法则留空。</span>
        </el-form-item>
        <el-form-item label="时间盈亏比例" prop="proscale">
          <el-input v-model="form.proscale" placeholder="请输入盈亏比例，用逗号隔开" />
          <span style="color:red">注意： 如比例为：75%、77%，80%、85%，则请用字母逗号将比例分开，如输入：0.75,0.77,0.80,0.85。</span>
        </el-form-item>
        <el-form-item label="最高下单金额" prop="maxOrder">
          <el-input v-model="form.maxOrder" type="number" placeholder="请输入最高" />
        </el-form-item>
        <el-form-item label="最低下单金额" prop="minOrder">
          <el-input v-model="form.minOrder" type="number" placeholder="请输入最低" />
        </el-form-item>
        <el-form-item label="手续费比例" prop="commission">
          <el-input v-model="form.commission" type="number" placeholder="请输入手续费" />
        </el-form-item>
        <el-form-item label="杠杆倍数" prop="gearing">
          <el-input v-model="form.gearing" type="number" placeholder="请输入杠杆倍数" />
        </el-form-item>
        <el-form-item label="一手金额" prop="handMoney">
          <el-input v-model="form.handMoney" placeholder="请输入一手金额" />
        </el-form-item>
        <el-form-item label="(合约)涨跌点金额" prop="pointMoney">
          <el-input v-model="form.pointMoney" type="number" placeholder="请输入涨跌点金额" />
        </el-form-item>
        <el-form-item label="开市时间" >
          周一<el-input style="width:45%;" v-model="form.zhouyi"  />
          周二<el-input style="width:45%;" v-model="form.zhouer"  />
          周三<el-input style="width:45%;" v-model="form.zhousan"  />
          周四<el-input style="width:45%;" v-model="form.zhousi"  />
          周五<el-input style="width:27.5%;" v-model="form.zhouwu"  />
          周六<el-input style="width:27.5%;" v-model="form.zhouliu"  />
          周日<el-input style="width:30.5%;" v-model="form.zhouri"  />
          <span style="color:red">注意： 开市时间为00:00~18:00则输入 00:00~18:00 开市时间为00:00~03:00 和 08:00~24:00;则输入 如：00:00~03:00|08:00~24:00 不得出现中文符号，全天不开市请留空,时间一定要填写准确</span>
        </el-form-item>
        <el-form-item label="是否开市" prop="isopen">
          <el-select v-model="form.isopen" placeholder="请选择是否开市">
            <el-option label="开市" value="0" />
            <el-option label="休市" value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否置顶推荐" prop="topOrNot">
          <el-select v-model="form.topOrNot" placeholder="请选择是否置顶">
            <el-option label="是" value="1" />
            <el-option label="否" value="0" />
          </el-select>
        </el-form-item>
        <el-form-item label="是否推荐至首页" prop="isIndex">
          <el-select v-model="form.isIndex" placeholder="请选择是否推荐置首页">
            <el-option label="是" value="1" />
            <el-option label="否" value="0" />
          </el-select>
        </el-form-item>
        <el-form-item label="推荐至PC引导页" prop="pcIndex">
          <el-select v-model="form.pcIndex" placeholder="请选择">
            <el-option label="是" value="1" />
            <el-option label="否" value="0" />
          </el-select>
        </el-form-item>
        <el-form-item label="排序" prop="seq">
          <el-input v-model="form.seq" type="number" placeholder="排序值越小越靠前" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="title" :visible.sync="openLc" width="900px">
      <el-form ref="formLc" :model="formLc" :rules="rulesLc" label-width="120px">
        <el-form-item label="理财金范围" prop="amountRange">
          <el-input v-model="formLc.amountRange" placeholder="请输入理财金范围,例如：100-5000" />
        </el-form-item>
        <el-form-item label="利率范围" prop="rateRange">
          <el-input v-model="formLc.rateRange" placeholder="请输入利率范围，例如：0.2-0.6" />
        </el-form-item>
        <el-form-item label="理财天数" prop="days">
          <el-input v-model="formLc.days" type="number" placeholder="请输入理财天数" />
        </el-form-item>
        <el-row type="flex" class="row-bg" justify="center">
          <el-col :span="6"><el-button type="primary" @click="submitFormLc">确 定</el-button>
            <el-button @click="cancelLc">取 消</el-button>
          </el-col>
          <!-- <el-col :span="6"><el-button @click="cancelLc">取 消</el-button></el-col> -->
        </el-row>
        <!-- <div >
          <el-button type="primary" @click="submitFormLc">确 定</el-button>
          <el-button @click="cancelLc">取 消</el-button>
        </div> -->
      </el-form>
      <br><br>
      <el-table v-loading="loading" :data="financingList" @selection-change="handleSelectionChange">
      <el-table-column label="理财金范围" align="center" prop="amountRange" />
      <el-table-column label="利率范围" align="center" prop="rateRange" />
      <el-table-column label="理财天数" align="center" prop="days" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdateLc(scope.row)"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDeleteLc(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParamsLc.pageNum"
      :limit.sync="queryParamsLc.pageSize"
      @pagination="getListLc"
    />
    </el-dialog>

  </div>
</template>

<script>
import { listProductinfo, getProductinfo,getLcInfo,addProductinfoLc,changeproduct, delProductinfo, addProductinfo, updateProductinfo, exportProductinfo } from "@/api/system/productinfo_hy";
import Cookies from 'js-cookie';
import { listFinancing, getFinancing, delFinancing, addFinancing, updateFinancing, exportFinancing } from "@/api/system/financing";
import ImageUpload from "@/components/ImageUpload"
const TokenKey = 'Admin-Token';
let remarks = '';
var mytoken =  Cookies.get(TokenKey);
export default {
  name: "Productinfo",
  components: { ImageUpload },
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
      // 产品信息表格数据
      productinfoList: [],
      financingList:[],
      addPid:undefined,
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      openLc: false,
      importHeaders: {Authorization: mytoken},
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        ptitle: undefined,
        ptitleEn: undefined,
        ptitleTw: undefined,
        commission: undefined,
        otid: undefined,
        isopen: undefined,
        type: '4',
        pointLow: undefined,
        pointTop: undefined,
        rands: undefined,
        moneyList: undefined,
        isdelete: undefined,
        procode: undefined,
        gearing: undefined,
        handMoney: undefined,
        addData: undefined,
        protime: undefined,
        propoint: undefined,
        proscale: undefined,
        topOrNot: undefined,
        isIndex: undefined,
        minOrder: undefined,
        maxOrder: undefined,
      },
      queryParamsLc:{
        pageNum: 1,
        pageSize: 10,
        pid:undefined
      },
      // 表单参数
      form: {},
      formLc: {},
      // 表单校验
      rules: {
        procode: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        decimalPlaces: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        rands: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        pointLow: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        pointTop: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        protime: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        maxOrder: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        minOrder: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        commission: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        gearing: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        pointMoney: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        isopen: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        topOrNot: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        isIndex: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
      },
      rulesLc: {
        amountRange: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        rateRange: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        days: [
          { required: true, message: "请输入", trigger: "blur" }
        ]
      },
      dialogImageUrl: '',
      dialogVisible: false,
      productImgs: [],
      isMultiple: true,
      imgLimit: 1
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询产品信息列表 */
    getList() {
      this.loading = true;
      listProductinfo(this.queryParams).then(response => {
        this.productinfoList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    cancelLc() {
      this.openLc = false;
      this.resetLc();
    },
    // 表单重置
    reset() {
      this.form = {
        pid: undefined,
        ptitle: undefined,
        ptitleEn: undefined,
        ptitleTw: undefined,
        ptitleFc: undefined,
        ptitleIs: undefined,
        ptitleSh: undefined,
        ptitleArb: undefined,
        ptitleJp: undefined,
        ptitleKr: undefined,
        ptitleVt: undefined,
        ptitleHd: undefined,
        ptitleThai: undefined,
        ptitleDm: undefined,
        commission: undefined,
        otid: undefined,
        isopen: undefined,
        type: '4',
        pointLow: undefined,
        pointTop: undefined,
        rands: undefined,
        moneyList: undefined,
        isdelete: undefined,
        procode: undefined,
        gearing: undefined,
        handMoney: undefined,
        addData: undefined,
        protime: undefined,
        propoint: undefined,
        proscale: undefined,
        topOrNot: undefined,
        isIndex: undefined,
        createTime: undefined,
        minOrder: undefined,
        maxOrder: undefined,
        remark: undefined,
        zhouyi: undefined,
        zhouer: undefined,
        zhousan: undefined,
        zhousi: undefined,
        zhouwu: undefined,
        zhouliu: undefined,
        zhouri: undefined,
        picUrl:undefined,
        fullName:undefined,
        seq:undefined,
        fileList:undefined,
        pcIndex:undefined
      };
      this.resetForm("form");
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
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.pid)
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    getImg(e) {
      this.form.fileList = e;
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.productImgs=[];
      this.reset();
      this.open = true;
      this.title = "添加产品信息";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.productImgs=[];
      remarks="";
      this.reset();
      const pid = row.pid || this.ids
      getProductinfo(pid).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改产品信息";
      });
    },
    handleUpdateLc(row) {
      this.resetLc_();
      const id = row.id || this.ids
      getFinancing(id).then(response => {
        this.formLc = response.data;
      });
    },
    configLc(row) {
      this.resetLc(row);
      const pid = row.pid || this.ids
      this.getListLc(pid);
      this.openLc = true;
      this.title = "理财配置";
    },
    getListLc(pid) {
      this.loading = true;
      this.queryParamsLc.pid = pid;
      listFinancing(this.queryParamsLc).then(response => {
        this.financingList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    resetLc(row) {
      if(row==null && row.pid==null){
        this.formLc = {
        pid: undefined,
        amountRange: undefined,
        rateRange: undefined,
        days: undefined,
        id:undefined
      };
      }else{
        this.formLc = {
          pid: row.pid,
          amountRange: undefined,
          rateRange: undefined,
          days: undefined,
          id:undefined
        };
      }
      this.resetForm("formLc");
      if(row.pid!=null){
        this.addPid = row.pid;
      }
    },
    resetLc_() {
      this.formLc = {
        amountRange: undefined,
        rateRange: undefined,
        days: undefined,
        id:undefined
      };
      this.resetForm("formLc");
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.pid != undefined) {
            updateProductinfo(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addProductinfo(this.form).then(response => {
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
    submitFormLc: function() {
      this.$refs["formLc"].validate(valid => {
        if (valid) {
          addProductinfoLc(this.formLc).then(response => {
              if (response.code === 200) {
                this.msgSuccess("配置成功");
                this.resetLc_();
                this.getListLc(this.addPid);
              } else {
                this.msgError(response.msg);
              }
            });
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const pids = row.pid || this.ids;
      this.$confirm('是否确认删除产品信息编号为"' + pids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delProductinfo(pids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    handleDeleteLc(row) {
      const ids = row.id || this.ids;
      this.$confirm('是否确认删除该理财配置?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delFinancing(ids);
        }).then(() => {
          this.getListLc(this.addPid);
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有产品信息数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportProductinfo(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    },
    handleOpenChange(row) {
      let text = row.isopen === "0" ? "开市" : "休市";
      this.$confirm('确认要"' + text + '"吗?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return changeproduct(row.pid, row.isopen);
        }).then(() => {
          this.msgSuccess(text + "成功");
        }).catch(function() {
          row.isopen = row.isopen === "0" ? "1" : "0";
        });
    },
    handleRemove(file, fileList) {//移除图片
        console.log(file, fileList);
      },
      handlePictureCardPreview(file) {//预览图片时调用
        console.log(file);
        this.dialogImageUrl = file.url;
        this.dialogVisible = true;
      },
      beforeAvatarUpload(file) {//文件上传之前调用做一些拦截限制
        var imgStr = /\.(jpg|jpeg|png|bmp|BMP|JPG|PNG|JPEG)$/;
        let isJPG = false;
        if(!imgStr.test(file.name)) {
          this.$message.error("文件不是图片类型");
          return false;
        }else{
          isJPG = true;
        }
        const isLt2M = file.size / 1024 / 1024 < 2;
        if (!isLt2M) {
          this.$message.error('上传图片大小不能超过 2MB!');
        }
        return isJPG && isLt2M;
      },
      handleAvatarSuccess(res, file) {//图片上传成功
        console.log(res);
        if(res.status=="1"){
          this.$message.error('上传失败，文件非法!');
          return;
        }
        remarks=res.url;
        this.imageUrl = URL.createObjectURL(file.raw);
      },
      handleExceed(files, fileList) {//图片上传超过数量限制
        this.$message.error('上传图片不能超过1张!');
        console.log(file, fileList);
      },
      imgUploadError(err, file, fileList){//图片上传失败调用
        console.log(err)
        this.$message.error('上传图片失败!');
      }
  }
};
</script>