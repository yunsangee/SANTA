package site.dearmysanta.web.chatting;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.dearmysanta.domain.meeting.MeetingPost;
import site.dearmysanta.domain.user.User;
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
    public String getChatRoomList(HttpSession session, Model model) throws Exception {
		
		int userNo = ((User)session.getAttribute("user")).getUserNo();
		
        List<MeetingPost> chattingRooms = meetingService.getChattingRoomList(userNo);
        model.addAttribute("chattingRooms", chattingRooms);
        
        return "forward:/chatting/listChattingRoom.jsp";
    }
	
	@GetMapping(value = "getChattingRoom") // userNo, nickname은 지워야함
    public String getChatRoom(@RequestParam int roomNo, @RequestParam String roomName, HttpSession session, Model model) throws Exception {
		
		int userNo = ((User)session.getAttribute("user")).getUserNo();
		String nickname = ((User)session.getAttribute("user")).getNickName();
		
		model.addAttribute("userNo", userNo);
		model.addAttribute("nickname", nickname);
        model.addAttribute("roomNo", roomNo);
        model.addAttribute("roomName", roomName);
        
        
        return "forward:/chatting/chattingRoom.jsp";
    }

}
