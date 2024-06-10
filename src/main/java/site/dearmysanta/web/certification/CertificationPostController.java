package site.dearmysanta.web.certification;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import site.dearmysanta.service.certification.CertificationPostService;

@Controller
@RequestMapping("/CertificationPostController/*")
public class CertificationPostController {

	private CertificationPostService certificationPostService;
}
