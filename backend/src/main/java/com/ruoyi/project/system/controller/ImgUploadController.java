package com.ruoyi.project.system.controller;

import com.ruoyi.common.core.domain.R;
import com.ruoyi.framework.config.RuoYiConfig;
import com.ruoyi.framework.web.controller.BaseController;
import com.ruoyi.project.system.service.ISysConfigService;
import com.ruoyi.project.system.util.HexUtil;
import com.ruoyi.project.system.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.HashMap;
import java.util.Map;

/**
 * 图片上传
 *
 * @author limeng_pc
 */
@RestController
@RequestMapping("/system/upload")
public class ImgUploadController extends BaseController {

    @Autowired
    private ISysConfigService sysConfigService;

    /**
     * 上传图片
     *
     * @param req
     * @param multiReq
     * @return
     * @throws IOException
     */
    @PostMapping("/imgUpload")
    public Map<String, String> imgUpload(HttpServletRequest req, MultipartHttpServletRequest multiReq)
            throws IOException {
        String fileUploadPath = RuoYiConfig.getProfile();
        Map<String, String> map = new HashMap<String, String>();
        MultipartFile file = multiReq.getFile("file");
        String originalFilename = file.getOriginalFilename();
        //根据文件流判断文件是否真的是图片文件
        String filetype = getPicType(file.getInputStream());
        if (filetype == null || ("unknown".equals(filetype))) {
            //不是图片文件
            map.put("url", "");
            map.put("status", "1");
            return map;
        }
        String suffix = originalFilename.substring(originalFilename.indexOf("."));
        String localFileName = MD5Util.md5(file.getInputStream()) + suffix;
        File localFile = new File(fileUploadPath + "/" + localFileName);
        if (!localFile.exists()) {
            localFile.createNewFile();

            FileOutputStream fos = new FileOutputStream(
                    localFile);
            FileInputStream fs = (FileInputStream) multiReq.getFile("file").getInputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = fs.read(buffer)) != -1) {
                fos.write(buffer, 0, len);
            }
            fos.close();
            fs.close();

        }
        map.put("url", localFileName);
        return map;
    }

    @PostMapping("/imgUploadNew")
    public R<?> imgUploadNew(HttpServletRequest req, MultipartHttpServletRequest multiReq)
            throws IOException {
        String fileUploadPath = RuoYiConfig.getProfile();
        Map<String, String> map = new HashMap<String, String>();
        MultipartFile file = multiReq.getFile("file");
        String originalFilename = file.getOriginalFilename();
        //根据文件流判断文件是否真的是图片文件
		/*String filetype = getPicType(file.getInputStream());
		if(filetype==null || (filetype!=null && filetype.equals("unknown"))){
			//不是图片文件
			map.put("url", "");
			map.put("fileName", "");
			return R.fail(map);
		}*/
        String suffix = originalFilename.substring(originalFilename.indexOf("."));
        String localFileName = MD5Util.md5(file.getInputStream()) + suffix;
        File localFile = new File(fileUploadPath + "/" + localFileName);
        if (!localFile.exists()) {
            localFile.createNewFile();

            FileOutputStream fos = new FileOutputStream(
                    localFile);
            FileInputStream fs = (FileInputStream) multiReq.getFile("file").getInputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = fs.read(buffer)) != -1) {
                fos.write(buffer, 0, len);
            }
            fos.close();
            fs.close();

        }
        String base_img_url = sysConfigService.selectConfigByKey("base_img_url");
        map.put("url", base_img_url + localFileName);
        map.put("fileName", originalFilename);
        return R.ok(map);
    }


    /**
     * 上传视频
     *
     * @param req
     * @param multiReq
     * @return
     * @throws IOException
     */
    @PostMapping("/videoUpload")
    public Map<String, String> videoUpload(HttpServletRequest req, MultipartHttpServletRequest multiReq)
            throws IOException {
        String fileUploadPath = RuoYiConfig.getProfile();
        Map<String, String> map = new HashMap<String, String>();
        MultipartFile file = multiReq.getFile("file");
        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.indexOf("."));
        String localFileName = MD5Util.md5(file.getInputStream()) + suffix;
        File localFile = new File(fileUploadPath + "/" + localFileName);
        if (!localFile.exists()) {
            localFile.createNewFile();

            FileOutputStream fos = new FileOutputStream(
                    localFile);
            FileInputStream fs = (FileInputStream) multiReq.getFile("file").getInputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = fs.read(buffer)) != -1) {
                fos.write(buffer, 0, len);
            }
            fos.close();
            fs.close();

        }
        map.put("url", localFileName);
        return map;
    }

    public String getPicType(InputStream is) {
        //读取文件的前几个字节来判断图片格式
        byte[] b = new byte[4];
        try {
            is.read(b, 0, b.length);
            String type = HexUtil.bytes2Hex(b).toUpperCase();
            if (type.contains("FFD8FF")) {
                return "jpg";
            } else if (type.contains("89504E47")) {
                return "png";
            } else if (type.contains("47494638")) {
                return "gif";
            } else if (type.contains("424D")) {
                return "bmp";
            } else {
                return "unknown";
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }
}
