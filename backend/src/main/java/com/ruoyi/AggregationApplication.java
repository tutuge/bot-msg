package com.ruoyi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.scheduling.annotation.EnableAsync;


/**
 * 启动程序
 *
 * @author none
 */
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
@EnableAsync
public class AggregationApplication extends SpringApplication {

    public static void main(String[] args) {
        SpringApplication.run(AggregationApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  聚合项目启动成功   ლ(´ڡ`ლ)");
    }

}
