package convert.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.TreeMap;

@Controller
public class NumberController {

    private final static TreeMap<Integer, String> map = new TreeMap<Integer, String>();
    static {
        map.put(1000, "M");
        map.put(900, "CM");
        map.put(500, "D");
        map.put(400, "CD");
        map.put(100, "C");
        map.put(90, "XC");
        map.put(50, "L");
        map.put(40, "XL");
        map.put(10, "X");
        map.put(9, "IX");
        map.put(5, "V");
        map.put(4, "IV");
        map.put(1, "I");
    }



        String romeNumber ="";

    @GetMapping
    public String main(Map<String, Object> model) {
        model.put("some", romeNumber);
        return "main";
    }

    @PostMapping
    public String conv(@RequestParam int number, Map<String, Object> model){
        romeNumber = toRoman(number);
        model.put("some", romeNumber);
        return "main";
    }



    public final static String toRoman(int number) {
        int l =  map.floorKey(number);
        if ( number == l ) {
            return map.get(number);
        }
        return map.get(l) + toRoman(number-l);
    }
}
//    @GetMapping("/greeting")
//    public String greeting(@RequestParam(name="name", required=false, defaultValue="World") String name, Model model) {
//        model.addAttribute("name", name);
//        return "greeting";
//    }

//    @GetMapping ( "/welcome" )
//    public ModelAndView welcomePage ( ) {
//        ModelAndView model = new ModelAndView("WelcomePage");
////        model.addObject("linksCpe", getCpeLinks());
////        model.addObject("linksPe", getPeLinks());
//        return model;
//    }

//templates/index.jsp
//
//    @RequestMapping(value = { "/", "/index" }, method = RequestMethod.GET)
//    public String index(Model model) {
//
//        String message = "Hello Spring Boot + JSP";
//
//        model.addAttribute("message", message);
//
//        return "index.jsp";
//    }