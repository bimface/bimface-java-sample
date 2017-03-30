package com.bimface.sample.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.alibaba.fastjson.JSONObject;
import com.bimface.sdk.bean.request.FileUploadRequest;
import com.bimface.sdk.bean.response.FileBean;
import com.bimface.sdk.bean.response.TranslateBean;
import com.bimface.sdk.exception.BimfaceException;
/**
 * 上传模型文件
 * @author bimface, 2017-03-01
 *
 */
public class UploadServlet extends AbstractServlet {

    private static final long serialVersionUID = 366642753723716298L;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("jsp/upload.jsp").forward(request, response);
    }

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	//上传文件
        FileBean fileBean = null;
        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List<FileItem> fileItems = upload.parseRequest(request);
            FileUploadRequest fileUploadRequest = new FileUploadRequest();
            for (FileItem fileItem : fileItems) {
                fileUploadRequest.setContentLength(fileItem.getSize());
                fileUploadRequest.setName(fileItem.getName());
                fileUploadRequest.setInputStream(fileItem.getInputStream());
            }
            fileBean = bimfaceClient.upload(fileUploadRequest);
        } catch (FileUploadException e) {
        } catch (BimfaceException e) {
        }

        // 获取fileId
        Long fileId = fileBean.getFileId();

        // 发起文件转换
        TranslateBean translateBean = null;
        try {
            translateBean = bimfaceClient.translate(fileId);
        } catch (BimfaceException e) {
        }

        response.getWriter().write(JSONObject.toJSONString(translateBean));
    }
}
