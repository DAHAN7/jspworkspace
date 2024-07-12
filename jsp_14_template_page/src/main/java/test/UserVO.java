package test; // 패키지 선언: 이 클래스가 속한 패키지 이름

/**
 * 사용자 정보를 저장하는 Value Object (VO) 클래스입니다.
 */
public class UserVO { // 클래스 선언: UserVO라는 이름의 클래스를 정의합니다.

	// 멤버 변수 선언: 사용자 정보를 저장할 변수들입니다.
	private String name; // 사용자 이름
	private String addr; // 사용자 주소
	private int age;    // 사용자 나이

	// 생성자 선언
	
	/**
	 * 기본 생성자: 모든 멤버 변수를 초기화하지 않는 생성자입니다.
	 */
	public UserVO() {
		super(); // 부모 클래스의 생성자 호출 (Object 클래스의 생성자 호출)
	}

	/**
	 * 매개변수가 있는 생성자: 모든 멤버 변수를 초기화하는 생성자입니다.
	 * @param name 사용자 이름
	 * @param addr 사용자 주소
	 * @param age 사용자 나이
	 */
	public UserVO(String name, String addr, int age) {
		super();
		this.name = name; // this 키워드를 사용하여 현재 객체의 멤버 변수를 참조합니다.
		this.addr = addr;
		this.age = age;
	}

	// Getter 및 Setter 메서드 선언
	// 멤버 변수에 접근하고 값을 설정하기 위한 메서드입니다.
	
	/**
	 * name 멤버 변수의 값을 반환하는 Getter 메서드입니다.
	 * @return name 멤버 변수의 값
	 */
	public String getName() {
		return name;
	}

	/**
	 * name 멤버 변수의 값을 설정하는 Setter 메서드입니다.
	 * @param name 설정할 name 값
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * addr 멤버 변수의 값을 반환하는 Getter 메서드입니다.
	 * @return addr 멤버 변수의 값
	 */
	public String getAddr() {
		return addr;
	}

	/**
	 * addr 멤버 변수의 값을 설정하는 Setter 메서드입니다.
	 * @param addr 설정할 addr 값
	 */
	public void setAddr(String addr) {
		this.addr = addr;
	}

	/**
	 * age 멤버 변수의 값을 반환하는 Getter 메서드입니다.
	 * @return age 멤버 변수의 값
	 */
	public int getAge() {
		return age;
	}

	/**
	 * age 멤버 변수의 값을 설정하는 Setter 메서드입니다.
	 * @param age 설정할 age 값
	 */
	public void setAge(int age) {
		this.age = age;
	}

	// toString 메서드 재정의
	
	/**
	 * 객체의 정보를 문자열로 표현하여 반환하는 메서드입니다.
	 * @return 객체의 정보를 담은 문자열
	 */
	@Override
	public String toString() {
		return "UserVO [name=" + name + ", addr=" + addr + ", age=" + age + "]";
	}

} // end of class
