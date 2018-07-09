package utils;

import bean.User;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

public class DataBaseUtils {
    private static String username; //用户名
    private static String password; //密码
    private static String dataBaseName; //数据库名

    public static void config(String path){
        InputStream inputStream = DataBaseUtils.class.getClassLoader().getResourceAsStream(path);
        Properties p = new Properties();
        try {
            p.load(inputStream);
            username = p.getProperty("db.username");
            password = p.getProperty("db.password");
            dataBaseName = p.getProperty("db.dataBaseName");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection(){
        config("config/jdbc.properties");
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection  = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/"+dataBaseName+"?useUnicode=true&characterEncoding=utf8",username,password);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public static void closeConnection(Connection connection, PreparedStatement statement, ResultSet rs){
        try {
            if(rs!=null)rs.close();
            if(statement!=null)statement.close();
            if(connection!=null)connection.close();
        } catch (Exception e) {
            e.fillInStackTrace();
        }
    }

    /**
     * DML操作
     * @param sql
     * @param objects
     */
    public static void update(String sql, Object...objects){
        Connection connection = getConnection();
        PreparedStatement statement = null;
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            for (int i = 0; i < objects.length; i++) {
                statement.setObject(i+1, objects[i]);
            }
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            closeConnection(connection, statement, null);
        }
    }

    /**
     * 查询出数据，并且list返回
     * @param sql
     * @param objects
     * @return
     * @throws SQLException
     */
    public static List<Map<String,Object>> queryForList(String sql, Object...objects){
        List<Map<String,Object>> result = new ArrayList<Map<String,Object>>();
        Connection connection = getConnection();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try {
            statement = (PreparedStatement) connection.prepareStatement(sql);
            for (int i = 0; i < objects.length; i++) {
                statement.setObject(i+1, objects[i]);
            }

            rs = statement.executeQuery();
            while(rs.next()){
                ResultSetMetaData resultSetMetaData = rs.getMetaData();
                int count = resultSetMetaData.getColumnCount(); //获取列数
                Map<String,Object> map = new HashMap<String, Object>();
                for (int i = 0; i < count; i++) {
                    map.put(resultSetMetaData.getColumnName(i+1), rs.getObject(resultSetMetaData.getColumnName(i+1)));
                }
                result.add(map);
            };
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            closeConnection(connection, statement, rs);
        }

        return result;
    }

    /**
     * 查询出数据，并且map返回
     * @param sql
     * @param objects
     * @return
     * @throws SQLException
     */
    public static Map<String,Object> queryForMap(String sql,Object...objects) throws SQLException{
        Map<String,Object> result = new HashMap<String,Object>();
        List<Map<String,Object>> list = queryForList(sql, objects);
        if(list.size() != 1){
            return null;
        }
        result = list.get(0);
        return result;
    }



    public static <T> T queryForBean(String sql, Class<?> type, Object...objects) throws IllegalAccessException, InstantiationException, SQLException, NoSuchFieldException {
        T obj = (T) type.newInstance();
        Map<String, Object> map = queryForMap(sql, objects);
        Field field = null;

        if (map == null) {
            return null;
        }

        for (String columnName : map.keySet()) {
            Method method = null;
            String propertyName = StringUtils.columnToProperty(columnName);
            field = type.getDeclaredField(propertyName);
            String fieldType = field.toString().split(" ")[1];
            Object value = map.get(columnName);
            if (value == null) {
                continue;
            }

            /**获取set方法的名字* */
            String setMethodName = "set" + StringUtils.upperCaseFirstCharacter(propertyName);
            try {
                /**获取值的类型* */
                String valueType = value.getClass().getName();

                /**查看类型是否匹配* */
                if (!fieldType.equalsIgnoreCase(valueType)) {
                    //System.out.println("类型不匹配");
                    if (fieldType.equalsIgnoreCase("java.lang.Integer")) {
                        value = Integer.parseInt(String.valueOf(value));
                    } else if (fieldType.equalsIgnoreCase("java.lang.String")) {
                        value = String.valueOf(value);
                    } else if (fieldType.equalsIgnoreCase("java.util.Date")) {
                        valueType = "java.util.Date";
                        //将value转换成java.util.Date
                        String dateStr = String.valueOf(value);
                        Timestamp ts = Timestamp.valueOf(dateStr);
                        Date date = new Date(ts.getTime());
                        value = date;
                    }
                }

                /**获取set方法* */
                //System.out.println(valueType);
                method = type.getDeclaredMethod(setMethodName, Class.forName(fieldType));
                /**执行set方法* */
                method.invoke(obj, value);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

        return obj;
    }

    public static void main(String[] args) throws SQLException {
        config("config/jdbc.properties");
        Connection connection = getConnection();
        /*String id = UUID.randomUUID() + "";
        String createTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        update("INSERT INTO user(id,username,password,sex,create_time,is_delete,address,telephone) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)", id,"麻子",123459,0,createTime,0,"保密","保密");
        //closeConnection();*/
        Map map = DataBaseUtils.queryForMap("select * from user where username = ?", "王二");
        System.out.println(map);
    }
}
