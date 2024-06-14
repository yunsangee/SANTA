package site.dearmysanta.web.chatting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.service.chatting.ChattingService;
import site.dearmysanta.service.meeting.MeetingService;

@Controller
@RequestMapping("/chatting/*")
public class ChattingController {
	
	@Autowired
	@Qualifier("meetingService")
	private MeetingService meetingService;
	
	public ChattingController() {
        System.out.println(this.getClass());
    }
	
	@GetMapping(value = "getChattingRoomList")
    public String getChatRoomList(@RequestParam int userNo, Model model) throws Exception {
        List<MeetingPost> chattingRooms = meetingService.getChattingRoomList(userNo);
        model.addAttribute("chattingRooms", chattingRooms);
        return "forward:/chatting/chattingRoom.jsp";
    }
	
	@GetMapping(value = "getChattingRoom")
    public String getChatRoom(@RequestParam int roomNo, Model model) throws Exception {
        model.addAttribute("roomNo", roomNo);
        return "forward:/chatting/chatting.jsp";
    }

}
