package site.dearmysanta.domain.message;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import site.dearmysanta.domain.user.User;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class MessageInfo {
	
	private String userId;
	private String phoneNumber;
	private int validationNumber;
	
	
}
