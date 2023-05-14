<template>
  <div class="app-container">
    <div>
      <span style="color:red">说明：需要复制本平台的回调地址到第三方平台中</span>
  </div></br>
    <!-- <el-form :model="queryParams" ref="queryForm" :inline="true" label-width="68px">
      <el-form-item label="回调标识" prop="source">
        <el-input
          v-model="queryParams.source"
          placeholder="请输入回调标识"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="前端域名" prop="domainName">
        <el-input
          v-model="queryParams.domainName"
          placeholder="请输入前端域名"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="类型，1：谷歌，2：FB" prop="type">
        <el-select v-model="queryParams.type" placeholder="请选择类型，1：谷歌，2：FB" clearable size="small">
          <el-option label="请选择字典生成" value="" />
        </el-select>
      </el-form-item>
      <el-form-item label="clientId" prop="clientId">
        <el-input
          v-model="queryParams.clientId"
          placeholder="请输入clientId"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="clientSecret" prop="clientSecret">
        <el-input
          v-model="queryParams.clientSecret"
          placeholder="请输入clientSecret"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="后端域名" prop="systemDomainName">
        <el-input
          v-model="queryParams.systemDomainName"
          placeholder="请输入后端域名"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="回调地址" prop="callBackUrl">
        <el-input
          v-model="queryParams.callBackUrl"
          placeholder="请输入回调地址"
          clearable
          size="small"
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form> -->

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
        >新增</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="domainList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="前端域名" align="center" prop="domainName" />
      <el-table-column label="平台" align="center" prop="type" >
        <template slot-scope="scope">
          <dict-tag :options="dict.type.third_part" :value="scope.row.type"/>
        </template>
      </el-table-column>
      <el-table-column label="clientId" align="center" prop="clientId" />
      <el-table-column label="clientSecret" align="center" prop="clientSecret" />
      <el-table-column label="回调地址" align="center" prop="callBackUrl" />
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

    <!-- 添加或修改平台第三方域名管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px">
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-form-item label="前端域名" prop="domainName">
          <el-input v-model="form.domainName" placeholder="请输入前端域名" />
        </el-form-item>
        <el-form-item label="平台">
          <el-select v-model="form.type" v-bind:disabled="isAble" placeholder="请选择" clearable>
          <el-option
            v-for="dict in dict.type.third_part"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
          </el-select>
        </el-form-item>
        <el-form-item label="clientId" prop="clientId">
          <el-input v-model="form.clientId" placeholder="请输入clientId" />
        </el-form-item>
        <el-form-item label="clientSecret" prop="clientSecret">
          <el-input v-model="form.clientSecret" placeholder="请输入clientSecret" />
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
import { listDomain, getDomain,getUUID, delDomain, addDomain, updateDomain, exportDomain } from "@/api/system/domain";

export default {
  name: "Domain",
  dicts: ['third_part'],
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
      // 平台第三方域名管理表格数据
      domainList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        source: undefined,
        domainName: undefined,
        type: undefined,
        clientId: undefined,
        clientSecret: undefined,
        systemDomainName: undefined,
        callBackUrl: undefined,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        domainName: [
          { required: true, message: "请输入", trigger: "blur" }
        ],
        type: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        clientId: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
        clientSecret: [
          { required: true, message: "请选择", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询平台第三方域名管理列表 */
    getList() {
      this.loading = true;
      listDomain(this.queryParams).then(response => {
        this.domainList = response.rows;
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
        source: undefined,
        domainName: undefined,
        type: undefined,
        clientId: undefined,
        clientSecret: undefined,
        systemDomainName: undefined,
        callBackUrl: undefined,
        createBy: undefined,
        createTime: undefined,
        updateBy: undefined,
        updateTime: undefined,
        remark: undefined
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
      this.single = selection.length!=1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加平台第三方域名管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getDomain(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改平台第三方域名管理";
      });
    },
    /** 提交按钮 */
    submitForm: function() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateDomain(this.form).then(response => {
              if (response.code === 200) {
                this.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              } else {
                this.msgError(response.msg);
              }
            });
          } else {
            addDomain(this.form).then(response => {
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
      this.$confirm('是否确认删除平台第三方域名管理编号为"' + ids + '"的数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return delDomain(ids);
        }).then(() => {
          this.getList();
          this.msgSuccess("删除成功");
        }).catch(function() {});
    },
    /** 导出按钮操作 */
    handleExport() {
      const queryParams = this.queryParams;
      this.$confirm('是否确认导出所有平台第三方域名管理数据项?', "警告", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(function() {
          return exportDomain(queryParams);
        }).then(response => {
          this.download(response.msg);
        }).catch(function() {});
    }
  }
};
</script>