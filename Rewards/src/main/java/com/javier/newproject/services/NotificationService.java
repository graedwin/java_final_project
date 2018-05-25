package com.javier.newproject.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {
	private JavaMailSender javaMailSender;	
	
	@Autowired
	public NotificationService(JavaMailSender javaMailSender) {
		this.javaMailSender=javaMailSender;
	}
	
	public void sendNotification(String email, String subject, String body) throws MailException{
		SimpleMailMessage mail = new SimpleMailMessage();
		mail.setTo(email);
		mail.setFrom("codingdojotestjavafinal@gmail.com");
		mail.setSubject(subject);
		mail.setText(body);
		javaMailSender.send(mail);
	}
	
	
	
}
