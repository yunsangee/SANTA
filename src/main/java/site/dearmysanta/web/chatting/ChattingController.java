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
	
	@GetMapping(value = "getChattingRoomList") //requestparam userNo 지우고, session 주석풀면됨.
    public String getChatRoomList(HttpSession session, Model model) throws Exception {
		
		User user = (User) session.getAttribute("user");

		int userNo;
		
		if (user != null) {
		    userNo = user.getUserNo();
		} else {
		    userNo = 1;
		    System.out.println("session에서 값 못받아와서 임의로 userNo 1 박힘");
		}
		
        List<MeetingPost> chattingRooms = meetingService.getChattingRoomList(userNo);
        System.out.println("채팅방리스트 ======= "+chattingRooms);
        
        model.addAttribute("chattingRooms", chattingRooms);
        
        
        return "forward:/chatting/listChattingRoom.jsp";
    }
	
	@GetMapping(value = "getChattingRoom") // userNo, nickname은 지우고 session 주석풀면됨
    public String getChatRoom(@RequestParam int roomNo, @RequestParam String roomName, Model model) throws Exception {
		
        model.addAttribute("roomNo", roomNo);
        model.addAttribute("roomName", roomName);
        
        return "forward:/chatting/chattingRoom.jsp";
    }

}
