<template>
  <div class="app-container">
    <audio ref="biandongAudio" display='none' src="@/assets/music/biandong.mp3" type="audio/mpeg"></audio>
    <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="用户ID" prop="userId">
        <el-input
          v-model="queryParams.userId"
          type="number"
          placeholder="请输入用户ID"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="钱包地址" prop="address">
        <el-input
          v-model="queryParams.address"
          placeholder="请输入钱包地址"
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
          size="mini"
          @click="startMusic"
        >开启提示音</el-button>
      </el-col>
    </el-row>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <span style="color:red;font-weight:bold">ipad进入或者每次刷新页面的时候，需要点击“开启提示音”</span>
      </el-col>
    </el-row>
    <el-table v-loading="loading" :data="recordList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" align="center" prop="id" />
      <el-table-column label="钱包地址" align="center" prop="address" />
      <el-table-column label="用户ID" align="center" prop="userId" />
      <el-table-column label="用户名" align="center" prop="nickName" />
      <el-table-column label="初始值" align="center" prop="usdtBalance" />
      <el-table-column label="变动值" align="center" prop="changeBalance" />
      <el-table-column label="终值" align="center" prop="endBalance" />
      <el-table-column label="所属链"  align="center" prop="chain" :formatter = "chainFormat" />
      <el-table-column label="代币类型"  align="center" prop="currencyType" :formatter = "currencyFormat" />
      <el-table-column label="变动时间" align="center" prop="createTime" >
          <template slot-scope="scope">
              <span>{{ parseTime(scope.row.createTime) }}</span>
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

    <!-- 添加或修改用户usdt变动记录对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px">
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="钱包地址" prop="address">
          <el-input v-model="form.address" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="用户ID" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户ID" />
        </el-form-item>
        <el-form-item label="用户名" prop="nickName">
          <el-input v-model="form.nickName" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="初始值" prop="usdtBalance">
          <el-input v-model="form.usdtBalance" placeholder="请输入初始值" />
        </el-form-item>
        <el-form-item label="变动值" prop="changeBalance">
          <el-input v-model="form.changeBalance" placeholder="请输入变动值" />
        </el-form-item>
        <el-form-item label="终值" prop="endBalance">
          <el-input v-model="form.endBalance" placeholder="请输入终值" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listRecord, getRecord,getMaxId, delRecord, addRecord, updateRecord, exportRecord } from "@/api/system/usdtrecord";
import mp3 from '@/assets/music/biandong.mp3'
let initNum = 0;
export default {
  name: "Record",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      timer: null,
      // 非多个禁用
      multiple: true,
      // 总条数
      total: 0,
      // 用户usdt变动记录表格数据
      recordList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 50,
        address: undefined,
        userId: undefined,
        nickName: undefined,
        usdtBalance: undefined,
        changeBalance: undefined,
        endBalance: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
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
    /** 查询用户usdt变动记录列表 */
    getList() {
      this.loading = true;
      listRecord(this.queryParams).then(response => {
        this.recordList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        id: undefined,
        address: undefined,
        userId: undefined,
        nickName: undefined,
        usdtBalance: undefined,
        changeBalance: undefined,
        endBalance: undefined,
        createTime: undefined,
        remark: undefined
      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
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
	startMusic(){
      //this.audio = new Audio();
      //this.audio.src = mp3;
      //this.audio.load();
      //this.audio.play();
      //alert("已开始正常接收语音。")
      this.$refs.biandongAudio.play();
    },
    getInitMaxId(){
      getMaxId().then(response => {
        console.log(response);
        let id = response.data.maxId;
        initNum = id;
      });
    },getMaxId(){
      getMaxId().then(response => {
        console.log(response);
        let id = response.data.maxId;
        if(id!=initNum){
          initNum = id;
          //进行语音播报
          this.$refs.biandongAudio.play();
        }
      });
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.handleQuery();
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
      this.title = "添加用户usdt变动记录";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getRecord(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改用户usdt变动记录";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateRecord(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addRecord(this.form).then(response => {
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
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$confirm('是否确认删除用户usdt变动记录编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delRecord(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有用户usdt变动记录数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportRecord(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>