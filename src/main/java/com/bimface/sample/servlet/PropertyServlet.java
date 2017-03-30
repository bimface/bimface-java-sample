package com.bimface.sample.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.bimface.sdk.bean.response.PropertyBean;
import com.bimface.sdk.exception.BimfaceException;

/**
 * 获取构件属性
 * 
 * @author bimface, 2017-03-01
 */
public class PropertyServlet extends AbstractServlet {

    private static final long serialVersionUID = 7575893574163011145L;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 获取参数值
        String fileId = request.getParameter("fileId");
        String elementId = request.getParameter("elementId");

        // 调用BIMFACE-SDK获取构件属性
        PropertyBean propertyBean = new PropertyBean();
        try {
            propertyBean = bimfaceClient.getProperty(Long.valueOf(fileId), elementId);
        } catch (NumberFormatException e) {
        } catch (BimfaceException e) {
        }

        // JSON序列化
        String propertyBeanJson = JSONObject.toJSONString(propertyBean);

        response.getWriter().write(propertyBeanJson);
    }
}
