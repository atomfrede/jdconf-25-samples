package com.github.atomfrede.jdconf_sample;

import com.github.atomfrede.jdconf_sample.pagination.PagerModel;
import com.github.atomfrede.jdconf_sample.person.Person;
import com.github.atomfrede.jdconf_sample.person.PersonService;
import io.github.wimdeblauwe.htmx.spring.boot.mvc.HxRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("tables")
public class TablesController {

    private final PersonService personService;

    public TablesController(PersonService personService) {
        this.personService = personService;
    }

    @GetMapping
    public String index(Model model, Pageable pageable) {
        Page<Person> page = personService.findAll(pageable);
        model.addAttribute("persons", page);
        model.addAttribute("pager", PagerModel.fromPage(page));

        return "table/index";
    }

    @GetMapping
    @HxRequest
    public String table(Model model, Pageable pageable) {
        Page<Person> page = personService.findAll(pageable);
        model.addAttribute("persons", page);
        model.addAttribute("pager", PagerModel.fromPage(page));

        return "table/table";
    }
}
