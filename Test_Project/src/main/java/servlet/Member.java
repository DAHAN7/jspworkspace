package servlet;

public class Member {
	private String name;
	private String id;
	private String email;
	private String password;
	private String phone;
	private String addr1;
	private String addr2;
	private String addr3;
	private String gender;
	private String seller;
	
	// alt + s + a
	public Member() {
	}
	
	public Member(String name, String id, String email, String password, String phone, String addr1, String addr2,
			String addr3, String gender, String seller) {
		super();
		this.name = name;
		this.id = id;
		this.email = email;
		this.password = password;
		this.phone = phone;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.addr3 = addr3;
		this.gender = gender;
		this.seller = seller;
	}
	
	// alt + s + r
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

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}
	
}
