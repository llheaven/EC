package main;

import java.io.IOException;
import java.util.Formatter;
import java.util.List;

import core.Generator;
import entity.JobInfo;
import helper.ArgParser;
import xml.Root;



public class App {
	public static int KEY =1;

	public static void main(String[] args) {
		if(args.length!=0)
		{
			ArgParser.argParser(args);
		}
		else
		{
			ArgParser.printHelp();
			return;
		}
		Root root = Root.getInstance().loadXml(ArgParser.JOBFILE);
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
