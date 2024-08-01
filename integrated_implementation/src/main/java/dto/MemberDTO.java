package dto;

/**
 * Data Transfer Object
 * 계층 간 데이터를 전달하기 위해 설계된 객체
 */
public class MemberDTO {
    
    private int num;            
    private String id;          
    private String pass;       
    private String name;       
    private String addr;       
    private String phone;      
    
    public MemberDTO() {}

    public MemberDTO(String id, String pass) {
        this.id = id;
        this.pass = pass;
    }

    public MemberDTO(String id, String pass, String name, String addr, String phone) {
        this.id = id;
        this.pass = pass;
        this.name = name;
        this.addr = addr;
        this.phone = phone;
    }

    public MemberDTO(int num, String id, String pass, String name, String addr, String phone) {
        this.num = num;
        this.id = id;
        this.pass = pass;
        this.name = name;
        this.addr = addr;
        this.phone = phone;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "MemberDTO [num=" + num + ", id=" + id + ", pass=" + pass + ", name=" + name + ", addr=" + addr
                + ", phone=" + phone + "]";
    }
}
