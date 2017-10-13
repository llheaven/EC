package src.main.java.cn.net.communion.xml;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import src.main.java.cn.net.communion.entity.JobInfo;
import src.main.java.cn.net.communion.entity.KeyValue;
import src.main.java.cn.net.communion.helper.ArgParser;





public class Root {
    static private Root instance = new Root();
    private List<JobInfo> jobList;

    private Root() {
        jobList = new ArrayList<JobInfo>();
    }

    static public Root getInstance() {
        return instance;
    }

    public Root loadXml(String file) {
        SAXReader reader = new SAXReader();
        try {
            // 璇诲彇xml鐨勯厤缃枃浠跺悕锛屽苟鑾峰彇鍏堕噷闈㈢殑鑺傜偣
            Element root = reader.read(file).getRootElement();
            // System.out.println(root.element("path").getTextTrim());
            Element jobs = root.element("jobs");
            // 閬嶅巻job鍗冲悓姝ョ殑琛�
            for (Iterator it = jobs.elementIterator("job"); it.hasNext();) {
                this.jobList.add(elementJobtoObject((Element) it.next(), new JobInfo()));
            }
            return this;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Load xml file error, please check!!!");
            return null;
        }

    }

    private JobInfo elementJobtoObject(Element job, JobInfo jobInfo) throws IOException {
        jobInfo.setId(job.element("id").getTextTrim());
        jobInfo.setNum(Integer.parseInt(job.element("num").getTextTrim()));
        jobInfo.setTable(job.element("table").getTextTrim());
        String filename = job.element("filename").getTextTrim();
        if (!"".equals(filename)) {
            jobInfo.setFilename(filename);
            // jobInfo.setWriter(new FileWriter("output/" + filename, true));
        }
        if (jobInfo.getNum() > 20 && jobInfo.getFilename() == null) {
            System.out.println("[job-" + jobInfo.getId() + "]" + " num is bigger than 20, path should't be empty");
            throw new IOException();
        }
        Element detail = job.element("detail");
        List<KeyValue> kvList = jobInfo.getDetail();
        for (Iterator i = detail.elementIterator(); i.hasNext();) {
            Element e = (Element) i.next();
            kvList.add(new KeyValue(e.getName(), e.getTextTrim()));
        }
        return jobInfo;
    }

    static public void main(String[] args) {
        Root parser = new Root();
        parser.loadXml(ArgParser.JOBFILE);
    }

    public List<JobInfo> getJobList() {
        return this.jobList;
    }
}
