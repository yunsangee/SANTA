package site.dearmysanta.domain.meeting;

import site.dearmysanta.domain.common.Like;

import lombok.experimental.SuperBuilder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;

@SuperBuilder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString(callSuper=true)
public class MeetingPostLike extends Like {
	private int meetingPostNo;

}
