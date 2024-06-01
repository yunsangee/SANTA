package site.dearmysanta.domain;

import java.sql.Date;
import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.Builder;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class HikingGuide {
    private int userNo; // ȸ�� �ĺ� ��ȣ
    private int hikingRecordNo; // ��� ��� ��ȣ
    private int mountainTrailNo; // ���� ��ȣ
    private int userDistance; // ȸ�� �̵� �Ÿ�
    private int ascentTime; // ȸ�� ���� �ð�
    private int descentTime; // ȸ�� ���� �ð�
    private int totalTime; // �� �ҿ� �ð�
    private Date hikingDate; // ��� ����
    private List<String> userCoordinates; // ȸ�� ��ġ ��ǥ
    private Mountain mountain; // �� ���� (mountain class)
    private Weather weather; // ���� ���� (weather class)
    private Meeting meeting; // ���ӿ� �ĺ� ��ȣ (meeting class)
}