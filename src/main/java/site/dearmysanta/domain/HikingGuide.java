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
    private int userNo; // 회원 식별 번호
    private int hikingRecordNo; // 등산 기록 번호
    private int mountainTrailNo; // 등산로 번호
    private int userDistance; // 회원 이동 거리
    private int ascentTime; // 회원 상행 시간
    private int descentTime; // 회원 하행 시간
    private int totalTime; // 총 소요 시간
    private Date hikingDate; // 등산 일자
    private List<String> userCoordinates; // 회원 위치 좌표
    private Mountain mountain; // 산 정보 (mountain class)
    private Weather weather; // 날씨 정보 (weather class)
    private Meeting meeting; // 모임원 식별 번호 (meeting class)
}
