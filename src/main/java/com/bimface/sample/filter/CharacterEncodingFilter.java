package com.bimface.sample.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 设置通用的字符编码为UTF-8
 * 
 * @author bimface, 2017-03-01
 */
public class CharacterEncodingFilter implements Filter {

    private final static String UTF8 = "utf-8";

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException,
                                                                                      ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        request.setCharacterEncoding(UTF8);
        response.setCharacterEncoding(UTF8);
        chain.doFilter(request, response);
    }

    public void destroy() {
    }
}
