package com.kk.config;

/*
@author kzj
@date 2020/2/18 - 20:18
*/

import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        //包含login的请求都放行
        if(request.getRequestURI().contains("login")){
            return true;
        }
        //session不为空则放行
        HttpSession session = request.getSession();
        if(session.getAttribute("user") != null){
            return true;
        }
        //不然都登录
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);


        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
