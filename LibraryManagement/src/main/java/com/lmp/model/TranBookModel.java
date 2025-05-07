package com.lmp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class TranBookModel {
	private String UserName;
	private int BookId;
	private Date Fromdate;
	
}
