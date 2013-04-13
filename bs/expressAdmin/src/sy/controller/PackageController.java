package sy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import sy.pageModel.Json;
import sy.service.PackageServiceI;

@Controller
@RequestMapping("/packageController")
public class PackageController {

	private PackageServiceI menuService;

	public PackageServiceI getMenuService() {
		return menuService;
	}

	@Autowired
	public void setMenuService(PackageServiceI menuService) {
		this.menuService = menuService;
	}

//	@RequestMapping("/allTreeNode")
//	@ResponseBody
//	public List<Menu> allTreeNode() {
//		return menuService.allTreeNode();
//	}

//	@RequestMapping("/treegrid")
//	@ResponseBody
//	public List<Package> treegrid() {
//		return menuService.treegrid();
//	}

	@RequestMapping("/remove")
	@ResponseBody
	public Json remove(String id) {
		Json j = new Json();
		menuService.remove(id);
		j.setSuccess(true);
		j.setObj(id);
		j.setMsg("删除成功!");
		return j;
	}

	@RequestMapping("/add")
	@ResponseBody
	public Json add(sy.pageModel.Package menu) {
		Json j = new Json();
		j.setSuccess(true);
		j.setObj(menuService.save(menu));
		j.setMsg("添加成功!");
		return j;
	}

	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(sy.pageModel.Package menu) {
		Json j = new Json();
		j.setSuccess(true);
		j.setObj(menuService.edit(menu));
		j.setMsg("编辑成功!");
		return j;
	}

}
