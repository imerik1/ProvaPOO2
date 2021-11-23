package db;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import model.Task;
import web.ErikSantanaDbListener;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author erik_
 */
public class TasksConnector {
    
    public static void addTask(String title, String username) throws Exception {
        Connection con = ErikSantanaDbListener.getConnection();
        PreparedStatement ps = con.prepareStatement("insert into ErikSantana_tasks(title, username) values(?, ?)");
        ps.setString(1, title);
        ps.setString(2, username);
        ps.executeUpdate();
        ps.close();
        con.close();
    }
    
    public static void removeTask(Integer id) throws Exception {
        Connection con = ErikSantanaDbListener.getConnection();
        PreparedStatement ps = con.prepareStatement("delete from ErikSantana_tasks where id = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
        ps.close();
        con.close();
    }
    
    public static ArrayList<Task> getTasks() throws Exception {
        ArrayList<Task> tasks = new ArrayList<>();
        Connection con = ErikSantanaDbListener.getConnection();
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("select * from ErikSantana_tasks");
        while(rs.next()) {
            tasks.add(new Task(rs.getInt("id"), rs.getString("title"), rs.getString("username")));
        }
        rs.close();
        stmt.close();
        con.close();
        return tasks;
    }
    
}
