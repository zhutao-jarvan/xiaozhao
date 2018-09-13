package top.w8d.util;

public class RegisterCheck {
    public static final int  REG_OK = 0;
    public static final String REG_OK_DESC = "注册成功";
    public static final int  REG_USERNAME_ERR2 = -101;
    public static final String REG_USERNAME_ERR2_DESC = "用户已注册";
    public static final int  REG_TELEPHONE_ERR2 = -102;
    public static final String REG_TELEPHONE_ERR2_DESC = "电话号码已注册";

    public static final int  REG_PASSOWRD_ERR1 = -1;
    public static final String REG_PASSOWRD_ERR1_DESC = "两次输入的密码不一致";
    public static final int  REG_PASSOWRD_ERR2 = -2;
    public static final String REG_PASSOWRD_ERR2_DESC = "密码长度必须大于6";
    public static final int  REG_PASSOWRD_ERR3 = -3;
    public static final String REG_PASSOWRD_ERR3_DESC = "密码长度必须小于16";
    public static int passwordCheck(String pwd1, String pwd2) {
        if (!pwd1.equals(pwd2))
            return REG_PASSOWRD_ERR1;

        if (pwd1.length() < 6)
            return REG_PASSOWRD_ERR2;

        if (pwd1.length() > 16)
            return REG_PASSOWRD_ERR3;

        return REG_OK;
    }

    public static final int  REG_USERNAME_ERR1 = -4;
    public static final String REG_USERNAME_ERR1_DESC = "用户名不能为空";
    public static int usernameCheck(String username) {
        if (username.isEmpty())
            return REG_USERNAME_ERR1;

        return REG_OK;
    }

    public static final int  REG_QQ_ERR1 = -5;
    public static final String REG_QQ_ERR1_DESC = "无效的QQ号";
    public static int qqCheck(String qq) {
        if (qq.length() < 5 || qq.length() > 32)
            return REG_QQ_ERR1;

        return REG_OK;
    }

    public static final int  REG_TELEPHONE_ERR1 = -6;
    public static final String REG_TELEPHONE_ERR1_DESC = "无效的电话号码";
    public static int telephoneCheck(String tel) {
        if (tel.length() != 11)
            return REG_TELEPHONE_ERR1;

        return REG_OK;
    }

    public static final int  REG_VERIFY_ERR1 = -7;
    public static final String REG_VERIFY_ERR1_DESC = "验证码错误";
    public static int verifyCodeCheck(String verifyCode) {
        if (verifyCode.length() != 4)
            return REG_VERIFY_ERR1;
        return REG_OK;
    }

    public static final int  REG_VERIFY_ERR2 = -8;
    public static final String REG_VERIFY_ERR2_DESC = "短信验证码错误";
    public static int verifyNoteCheck(String verifyNote) {
        if (verifyNote.length() != 4)
            return REG_VERIFY_ERR2;
        return REG_OK;
    }
    public static String regErrorInfo(int regCode) {
        switch (regCode) {
            case REG_OK: return REG_OK_DESC;
            case REG_PASSOWRD_ERR1: return REG_PASSOWRD_ERR1_DESC;
            case REG_PASSOWRD_ERR2: return REG_PASSOWRD_ERR2_DESC;
            case REG_PASSOWRD_ERR3: return REG_PASSOWRD_ERR3_DESC;
            case REG_USERNAME_ERR1: return REG_USERNAME_ERR1_DESC;
            case REG_QQ_ERR1: return REG_QQ_ERR1_DESC;
            case REG_TELEPHONE_ERR1: return REG_TELEPHONE_ERR1_DESC;
            case REG_VERIFY_ERR1: return REG_VERIFY_ERR1_DESC;
            case REG_VERIFY_ERR2: return REG_VERIFY_ERR2_DESC;
            case REG_USERNAME_ERR2: return REG_USERNAME_ERR2_DESC;
            case REG_TELEPHONE_ERR2: return REG_TELEPHONE_ERR2_DESC;
            default: return "未知错误";
        }
    }

    public static int regCheck(String username, String pwd1, String pwd2, String qq, String tel, String verifyCode, String verfyNote) {
        int ret;

        ret = RegisterCheck.usernameCheck(username);
        if (ret != RegisterCheck.REG_OK) {
            return ret;
        }

        ret = RegisterCheck.passwordCheck(pwd1, pwd2);
        if (ret != RegisterCheck.REG_OK) {
            return ret;
        }

        ret = RegisterCheck.qqCheck(qq);
        if (ret != RegisterCheck.REG_OK) {
            return ret;
        }

        ret = RegisterCheck.telephoneCheck(tel);
        if (ret != RegisterCheck.REG_OK) {
            return ret;
        }

        ret = RegisterCheck.verifyCodeCheck(verifyCode);
        if (ret != RegisterCheck.REG_OK) {
            return ret;
        }

        ret = RegisterCheck.verifyNoteCheck(verfyNote);
        if (ret != RegisterCheck.REG_OK) {
            return ret;
        }

        return RegisterCheck.REG_OK;
    }
}
