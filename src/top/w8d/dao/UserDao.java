package top.w8d.dao;

import org.apache.ibatis.annotations.Param;
import top.w8d.domain.User;

public interface UserDao {
    public abstract User queryUserById(@Param("user_id") Integer userId);
    public abstract User queryUserByName(@Param("username") String username);
    public abstract User queryUserByTelephone(String telephone);
    public abstract boolean addUser(User user);
    public abstract boolean deleteUser(Integer userId);
    public abstract int updateUser(User user);
}
