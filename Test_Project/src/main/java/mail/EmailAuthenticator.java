package mail;

import java.io.*;
import java.util.Properties;
import jakarta.mail.*;

public class EmailAuthenticator extends Authenticator {

	PasswordAuthentication passwordAuthentication;

	public EmailAuthenticator() {

		try {
			Properties prop = new Properties();
			String path = getClass().getResource("../prop/mail.properties").getPath();
			prop.load(new FileReader(path));
			String auth = prop.getProperty("gmail_auth");
			String pass = prop.getProperty("gmail_pass");
			// new PasswordAuthentication("계정", "비밀번호");
			System.out.println("auth : " + auth);
			System.out.println("pass : " + pass);
			passwordAuthentication = new PasswordAuthentication(auth, pass);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	public PasswordAuthentication getPasswordAuthentication() {
		return passwordAuthentication;
	}

	public Properties getProp() {
		Properties p = new Properties();
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.port", "587");
		p.put("mail.smtp.starttls.enable", "true");
		return p;
	}
}
