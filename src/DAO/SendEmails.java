package DAO;

import java.security.Security;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

public class SendEmails {

	/**
	 * @param args
	 * @throws MessagingException 
	 */
	public static void main(String[] args) throws MessagingException {
		// TODO Auto-generated method stub
		
		Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		  
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		  
		props.setProperty("mail.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		props.put("mail.debug", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
		"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");
		props.setProperty("mail.smtp.quitwait", "false");
		 
		Session session = Session.getDefaultInstance(props,
		new javax.mail.Authenticator() {
		  
		protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("savanpatel750@gmail.com","samino7508401300410sp@!");
		}
		});
		  
		session.setDebug(true);
		  
		 
		Transport transport = session.getTransport();
		InternetAddress addressFrom = new InternetAddress("savanpatel750@gmail.com");
		  
		MimeMessage message = new MimeMessage(session);
		message.setSender(addressFrom);
		message.setSubject("Testing javamail plain");
		message.setContent("This mail is sent by servlet,,,dont reply to this mail...", "text/plain");
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(
		"niks.ce15@gmail.com"));
		  
		transport.connect();
		transport.send(message);
		transport.close();

	}

}
