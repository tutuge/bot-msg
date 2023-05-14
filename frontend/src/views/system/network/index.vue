<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="充值网络" prop="networkName">
        <el-input
          v-model="queryParams.networkName"
          placeholder="请输入充值网络"
          clearable
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
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="networkList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="充值网络(别名)" align="center" prop="aliasName" />
      <el-table-column label="充值网络" align="center" prop="networkName" />
      <el-table-column label="排序" align="center" prop="seqNum" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
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

    <!-- 添加或修改币种充值网络对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="充值网络(别名)" prop="aliasName">
          <el-input v-model="form.aliasName" placeholder="请输入充值网络别名" />
        </el-form-item>
        <el-form-item label="充值网络" prop="networkName">
          <el-input v-model="form.networkName" placeholder="请输入充值网络" />
        </el-form-item>
        <!-- <el-form-item label="钱包地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入钱包地址" />
        </el-form-item>
        <el-form-item label="钱包地址二维码" >
            <Image-upload
              :value="form.qrcode"
              @input="(e) => getImg(e)"
            ></Image-upload>
        </el-form-item> -->
        <el-form-item label="排序" prop="seqNum">
          <el-input v-model="form.seqNum" type="number" placeholder="请输入" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button :loading="buttonLoading" type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listNetwork, getNetwork, delNetwork, addNetwork, updateNetwork } from "@/api/system/network";
import ImageUpload from "@/components/ImageUpload"
export default {
  name: "Network",
  components: { ImageUpload },
  data() {
    return {
      // 按钮loading
      buttonLoading: false,
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 币种充值网络表格数据
      networkList: [],
      // 弹出层标题
      title: "",
      parentIdFin:"",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        parentId: undefined,
        networkName: undefined,
        address: undefined,
        qrcode: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        id: [
          { required: true, message: "主键ID不能为空", trigger: "blur" }
        ],
        parentId: [
          { required: true, message: "关联币种ID不能为空", trigger: "blur" }
        ],
        networkName: [
          { required: true, message: "充值网络不能为空", trigger: "blur" }
        ],
        aliasName: [
          { required: true, message: "充值网络别名不能为空", trigger: "blur" }
        ],
        address: [
          { required: true, message: "钱包地址不能为空", trigger: "blur" }
        ],
        qrcode: [
          { required: true, message: "钱包二维码地址不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    const parentId = this.$route.query.id;
    this.parentIdFin = parentId;
    this.queryParams.parentId = parentId;
    this.queryParams.type='1';
    this.getList();
  },
  methods: {
    /** 查询币种充值网络列表 */
    getList() {
      this.loading = true;
      listNetwork(this.queryParams).then(response => {
        this.networkList = response.rows;
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
        parentId: undefined,
        networkName: undefined,
        address: undefined,
        qrcode: undefined,
        createBy: undefined,
        createTime: undefined,
        updateBy: undefined,
        updateTime: undefined,
        seqNum:undefined,
        type:'1',
        aliasName:undefined
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
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加币种充值网络";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.loading = true;
      this.reset();
      const id = row.id || this.ids
      getNetwork(id).then(response => {
        this.loading = false;
        this.form = response.data;
        this.open = true;
        this.title = "修改币种充值网络";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.form.parentId = this.parentIdFin;
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.buttonLoading = true;
          if (this.form.id != null) {
            updateNetwork(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            }).finally(() => {
              this.buttonLoading = false;
            });
          } else {
            addNetwork(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            }).finally(() => {
              this.buttonLoading = false;
            });
          }
        }
      });
    },
    getImg(index, e) {
      this.form.qrcode = e;
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除币种充值网络编号为"' + ids + '"的数据项？').then(() => {
        this.loading = true;
        return delNetwork(ids);
      }).then(() => {
        this.loading = false;
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).finally(() => {
        this.loading = false;
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('basic/network/export', {
        ...this.queryParams
      }, `network_${new Date().getTime()}.xlsx`)
    }
  }
};
</script>
