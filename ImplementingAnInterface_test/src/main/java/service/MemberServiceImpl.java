package service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MemberServiceImpl implements MemberService{

	@Override
	public boolean memberJoin(HttpServletRequest request) {
		return false;
	}

	@Override
	public boolean memberLogin(HttpServletRequest request, HttpServletResponse response) {
		return false;
	}

	@Override
	public void logOut(HttpServletRequest requst, HttpServletResponse response) {
		
	}

}
