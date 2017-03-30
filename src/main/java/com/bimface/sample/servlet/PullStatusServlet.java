package com.bimface.sample.servlet;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSONObject;
import com.bimface.sdk.bean.response.TranslateBean;
import com.bimface.sdk.exception.BimfaceException;

/**
 * 获取文件转换状态
 * @author bimface, 2017-03-01
 *
 */
public class PullStatusServlet extends AbstractServlet {

    private static final long serialVersionUID = -4032856105060880005L;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String fileId = request.getParameter("fileId");

        //调用BIMFACE-SDK获取文件转换状态
        TranslateBean translateBean = null;
        try {
            translateBean = bimfaceClient.getTranslate(Long.valueOf(fileId));
        } catch (NumberFormatException e) {
        } catch (BimfaceException e) {
        }

        //// JSON序列化
        response.getWriter().write(JSONObject.toJSONString(translateBean));
    }

}
