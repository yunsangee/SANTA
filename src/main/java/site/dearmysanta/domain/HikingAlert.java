package site.dearmysanta.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.SuperBuilder;


@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString	

public class HikingAlert {
	
	private int userNo; //ȸ���ĺ���ȣ
	private int hikingAlerFlag; //�˸���ȣ�÷���
	private String destinationAlert; //�������Ÿ��˸�
	private String sunsetAlert; //�ϸ��˸�
	private String locationOverAlert; //��ġ��Ż�˸�
	private String meetingTimeAlert; //���ӽð��˸�
	private String meetingTime; //���ӽð�
	private String alertContent; //�˸�����
	private String allAlert; //��ü�˸�
	
}
