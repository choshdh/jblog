package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.FileUploadService;
import com.javaex.vo.FileVo;

@Controller
@RequestMapping("/fileupload")
public class FileUploadController {
	
	@Autowired
	FileUploadService fuService;

	@RequestMapping("/form")
	public String form(Model model) {
		System.out.println("form 진입");
		List<FileVo> l = fuService.list();
		model.addAttribute("l", l);
		
		return "fileupload/form";
	}
	
	@RequestMapping("/upload")
	public String upload(@RequestParam("file") MultipartFile file,Model model) {
		System.out.println("upload 진입");
		String fileSaveName = fuService.restore(file);
		
		String url = "upload/" + fileSaveName;
		
		model.addAttribute("url", url);
		
		return "fileupload/result";
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam("fileNo") int fileNo) {
		int result = fuService.delete(fileNo);
		System.out.println("삭제 처리 결과 : " + result);
		return "redirect:/fileupload/form";
	}
}
