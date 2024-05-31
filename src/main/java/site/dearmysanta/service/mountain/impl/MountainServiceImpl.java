package site.dearmysanta.service.mountain.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import site.dearmysanta.service.mountain.MountainDao;

@Service("mountainServiceImpl")
@Transactional()
public class MountainServiceImpl {
	
	@Autowired
	@Qualifier("mountainDao")
	MountainDao mountainDao;

}
