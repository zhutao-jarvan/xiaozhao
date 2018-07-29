package utils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AuthFilter implements Filter {
    List<String> ignore_list = null;
    @Override
    public void init(FilterConfig filterConfig) {
        ignore_list = new ArrayList<String>();
        String ignores = filterConfig.getInitParameter("ignore_url");
        String []url = ignores.split(";");

        for (int i=0; i<url.length; i++) {
            ignore_list.add(url[i]);
        }
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        /**
         * 1,doFilter方法的第一个参数为ServletRequest对象。此对象给过滤器提供了对进入的信息（包括*
         * 表单数据、cookie和HTTP请求头）的完全访问。第二个参数为ServletResponse，通常在简单的过*
         * 滤器中忽略此参数。最后一个参数为FilterChain，此参数用来调用servlet或JSP页。
         */
        HttpServletRequest request = (HttpServletRequest) servletRequest;

        /**
         * 如果处理HTTP请求，并且需要访问诸如getHeader或getCookies等在ServletRequest中*
         * 无法得到的方法，就要把此request对象构造成HttpServletRequest
         */
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String currentURL = request.getRequestURI();

        // 需要放心的url，存于配置文件
        for (String ignore_url: ignore_list) {
            if (ignore_url.equals(currentURL)) {
                filterChain.doFilter(request, response);
                return;
            }
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            // *用户登录以后需手动添加session
            System.out.println("request.getContextPath()="
                    + request.getContextPath());
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            // 如果session为空表示用户没有登录就重定向到login.jsp页面
            return;
        }

        // 加入filter链继续向下执行
        filterChain.doFilter(request, response);

        /**
         * 调用FilterChain对象的doFilter方法。Filter接口的doFilter方法取一个FilterChain对象作* 为它
         * 的一个参数。在调用此对象的doFilter方法时，激活下一个相关的过滤器。如果没有另*
         * 一个过滤器与servlet或JSP页面关联，则servlet或JSP页面被激活。
         */
    }

    @Override
    public void destroy() {

    }
}
