<%-- 
    Document   : index
    Created on : 22 de nov. de 2021, 22:00:57
    Author     : erik_
--%>

<%@page import="db.TasksConnector"%>
<%@page import="model.Task"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    ArrayList<Task> tasks = new ArrayList<Task>();
    try {
        if (request.getParameter("add") != null) {
            TasksConnector.addTask(request.getParameter("title"), (String) session.getAttribute("username"));
            response.sendRedirect(request.getRequestURI());
        }
        if (request.getParameter("remove") != null) {
            TasksConnector.removeTask(Integer.parseInt(request.getParameter("id")));
            response.sendRedirect(request.getRequestURI());
        }
        tasks = TasksConnector.getTasks();
    } catch (Exception e) {
        response.sendRedirect(request.getRequestURI());
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <%if(isLogin){%>
        <form>
            <input type="text" name="title" />
            <input type="submit" name="add" value="+" />
        </form>
        <table>
            <thead>
                <tr>
                    <th>Nome da tarefa</th>
                    <th>Usuario</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <%for (Task task : tasks) {%>
                <tr>
                    <td><%= task.getTitle()%></td>
                    <td><%= task.getUsername()%></td>
                    <td>
                        <form>
                            <input type="hidden" name="id" value="<%= task.getId()%>" />
                            <input type="submit" name="remove" value="-" />
                        </form>
                    </td>
                </tr>
                <%}%>
            </tbody>
        </table>
        <%}%>
    </body>
</html>
