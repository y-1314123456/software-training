package com.student;

import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import jakarta.annotation.Resource;

@RestController
public class TestController {

    @Resource
    private StringRedisTemplate stringRedisTemplate;

    @GetMapping("/test")
    public String test() {
        stringRedisTemplate.opsForValue().set("msg", "项目连接Redis成功！");
        String res = stringRedisTemplate.opsForValue().get("msg");
        return "后端启动成功！Redis返回信息：" + res;
    }
}
