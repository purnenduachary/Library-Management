package com.lmp.model;

import java.sql.Date;

import lombok.Data;
@Data

public class TransReturn {
    private String username;
    private int bookId;
    private Date fromDate;
    private Date ToDate;
}
