package src.main.java.cn.net.communion.main;

import java.io.IOException;
import java.util.List;

import src.main.java.cn.net.communion.core.Generator;
import src.main.java.cn.net.communion.entity.JobInfo;
import src.main.java.cn.net.communion.xml.Root;



public class App {
    public static void main(String[] args) {
        Root root = Root.getInstance().loadXml("jobs.xml");
        List<JobInfo> ll=root.getJobList();
        if (root != null) {

            try {
                new Generator().start(root.getJobList());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        
    }

}
