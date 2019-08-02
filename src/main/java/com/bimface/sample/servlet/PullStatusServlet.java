package com.bimface.sample.servlet;

import com.bimface.api.bean.response.FileTranslateBean;
import com.bimface.exception.BimfaceException;
import com.google.gson.Gson;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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
        FileTranslateBean translateBean = null;
        try {
            translateBean = bimfaceClient.getTranslate(Long.valueOf(fileId));
        } catch (NumberFormatException e) {
        } catch (BimfaceException e) {
            e.printStackTrace();
        }

        //// JSON序列化
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(translateBean));
    }

}
