package servlet;

import java.sql.*;

public class MemberVO {
	private int memberNum;
	private String name;
	private String id;
	private String email;
	private String password;
	private String phone;
	private String birth;
	private String addr1;
	private String addr2;
	private String addr3;
	private String gender;
	private int money;
	private Timestamp joinDate;
	private Timestamp visitDate;
	private int type;
	private String withdraw;
	
	
	
	
	public MemberVO() {
		super();
	}

	public MemberVO(int memberNum, String name, String id, String email, String password, String phone, String birth,
			String addr1, String addr2, String addr3, String gender, int money, Timestamp joinDate, Timestamp visitDate,
			int type, String withdraw) {
		super();
		this.memberNum = memberNum;
		this.name = name;
		this.id = id;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.birth = birth;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.addr3 = addr3;
		this.gender = gender;
		this.money = money;
		this.joinDate = joinDate;
		this.visitDate = visitDate;
		this.type = type;
		this.withdraw = withdraw;
	}
	
	public int getMemberNum() {
		return memberNum;
	}
	public void setMemberNum(int memberNum) {
		this.memberNum = memberNum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	public String getAddr3() {
		return addr3;
	}
	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public Timestamp getJoinDate() {
		return joinDate;
	}
	public void setJoinDate(Timestamp joinDate) {
		this.joinDate = joinDate;
	}
	public Timestamp getVisitDate() {
		return visitDate;
	}
	public void setVisitDate(Timestamp visitDate) {
		this.visitDate = visitDate;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getWithdraw() {
		return withdraw;
	}
	public void setWithdraw(String withdraw) {
		this.withdraw = withdraw;
	}

	@Override
	public String toString() {
		return "MemberVO [memberNum=" + memberNum + ", name=" + name + ", id=" + id + ", email=" + email + ", password="
				+ password + ", phone=" + phone + ", birth=" + birth + ", addr1=" + addr1 + ", addr2=" + addr2
				+ ", addr3=" + addr3 + ", gender=" + gender + ", money=" + money + ", joinDate=" + joinDate
				+ ", visitDate=" + visitDate + ", type=" + type + ", withdraw=" + withdraw + "]";
	}

}
