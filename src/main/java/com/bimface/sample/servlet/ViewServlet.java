package com.bimface.sample.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bimface.sdk.exception.BimfaceException;

/**
 * 获取view token
 * 
 * @author bimface, 2017-03-01
 */
public class ViewServlet extends AbstractServlet {

    private static final long serialVersionUID = -8602521795850327602L;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 获取参数值
        String fileId = request.getParameter("fileId");

        // 获取view token
        String viewToken = null;
        try {
            viewToken = bimfaceClient.getViewTokenByFileId(Long.valueOf(fileId));
        } catch (NumberFormatException e) {
        } catch (BimfaceException e) {
        }

        request.setAttribute("viewToken", viewToken);
        request.getRequestDispatcher("jsp/view.jsp").forward(request, response);
    }
}
