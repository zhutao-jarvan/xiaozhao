package top.w8d.service;

import top.w8d.domain.User;

public interface UserService {
    /**
     * SESSION用户名KEY
     */
    public static final String AUTH_USER_NAME_KEY = "__SESSION_USER_NAME_KEY";
    /**
     * SESSION用户对象KEY
     */
    public static final String AUTH_USER_KEY = "__SESSION_USER_KEY";
    public abstract User queryUserById(Integer userId);
    public abstract User queryUserByName(String username);
    public abstract User queryUserByTelephone(String telephone);
    public abstract boolean addUser(User user);
    public abstract boolean deleteUser(Integer userId);
}
