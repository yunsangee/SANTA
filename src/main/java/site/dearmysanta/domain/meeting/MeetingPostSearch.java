package site.dearmysanta.domain.meeting;

import site.dearmysanta.domain.common.Search;

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
public class MeetingPostSearch extends Search{
	private int meetingPostListSearchCondition; // Condition for searching the meeting post list by category

}
