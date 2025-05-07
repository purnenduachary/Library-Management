package com.lmp.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.lmp.model.AdminLogin;
import com.lmp.model.BookModel;
import com.lmp.model.LibUsers;
import com.lmp.model.TranBookModel;
import com.lmp.model.TransReturn;
import com.lmp.util.ConnectionHandler;
import com.lmp.util.EncryptPassword;

public class LibraryDaoImpl implements LibraryDao {

	static Connection conn;
	static PreparedStatement pst;

	public int issueOrNot(String userName, int bookId) throws ClassNotFoundException, SQLException {
		conn = ConnectionHandler.getConnection();
		String sql = "select count(*) cnt from TranBook where UserName=? and BookId=?";
		pst = conn.prepareStatement(sql);
		pst.setString(1, userName);
		pst.setInt(2, bookId);
		ResultSet rs = pst.executeQuery();
		rs.next();
		int count = rs.getInt("cnt");
		return count;
	}

	@Override
	public String createUser(LibUsers libusers) throws ClassNotFoundException, SQLException {

		String encr = EncryptPassword.getCode(libusers.getPassword());
		conn = ConnectionHandler.getConnection();
		String sql = "Insert into LibUsers(UserName, Password) values (?,?)";
		pst = conn.prepareStatement(sql);
		pst.setString(1, libusers.getUsername());
		pst.setString(2, encr);
		pst.executeUpdate();
		return "User account created successfully";
	}

	@Override
	public String createAdmin(AdminLogin adlog) throws ClassNotFoundException, SQLException {
		String encr = EncryptPassword.getCode(adlog.getPasscode());
		conn = ConnectionHandler.getConnection();
		String sql = "Insert into AdminLogin(Adminname, passcode) values(?,?)";
		pst = conn.prepareStatement(sql);
		pst.setString(1, adlog.getUsername());
		pst.setString(2, encr);
		pst.executeUpdate();
		return "Hey Admin Welcome to the Board";
	}

	@Override
	public int login(LibUsers libuser) throws ClassNotFoundException, SQLException {
		String encr = EncryptPassword.getCode(libuser.getPassword());
		conn = ConnectionHandler.getConnection();
		String sql = "select count(*) cnt from LibUsers where UserName = ? AND Password =?";
		pst = conn.prepareStatement(sql);
		pst.setString(1, libuser.getUsername());
		pst.setString(2, encr);

		ResultSet rs = pst.executeQuery();
		rs.next();
		int count = rs.getInt("cnt");
		return count;
	}

	@Override
	public int AdminLogin(AdminLogin adlog) throws ClassNotFoundException, SQLException {
		String encr = EncryptPassword.getCode(adlog.getPasscode());
		conn = ConnectionHandler.getConnection();
		String sql = "select count(*) cnt from AdminLogin where Adminname = ? AND passcode = ?";
		pst = conn.prepareStatement(sql);
		pst.setString(1, adlog.getUsername());
		pst.setString(2, encr);

		ResultSet rs = pst.executeQuery();
		rs.next();
		int count = rs.getInt("cnt");
		return count;
	}

	@Override
	public List<BookModel> searchBooks(String searchType, String searchvalue)
			throws ClassNotFoundException, SQLException {
		String cmd;
		boolean isValid = true;
		if (searchType.equals("id")) {
			cmd = " SELECT * FROM Books WHERE Id = ? ";
		} else if (searchType.equals("bookname")) {
			cmd = " SELECT * FROM Books Where Name = ?";
		} else if (searchType.equals("authorname")) {
			cmd = "SELECT * FROM Books where Author = ?";
		} else if (searchType.equals("dept")) {
			cmd = "select * from Books where Dept = ?";
		} else {
			isValid = false;
			cmd = "select * from Books";
		}
		conn = ConnectionHandler.getConnection();
		pst = conn.prepareStatement(cmd);
		if (isValid == true) {
			pst.setString(1, searchvalue);
		}
		ResultSet rs = pst.executeQuery();
		BookModel books = null;
		List<BookModel> booksList = new ArrayList<BookModel>();
		while (rs.next()) {
			books = new BookModel();
			books.setId(rs.getInt("id"));
			books.setName(rs.getString("name"));
			books.setAuthor(rs.getString("author"));
			books.setEdition(rs.getString("edition"));
			books.setDept(rs.getString("dept"));
			books.setNoOfBooks(rs.getInt("TotalBooks"));
			booksList.add(books);
		}
		return booksList;
	}

	@Override
	public String issueBook(String username, int bookId) throws ClassNotFoundException, SQLException {

		int count = issueOrNot(username, bookId);
		if (count == 0) {
			conn = ConnectionHandler.getConnection();
			String sql = "Insert into TranBook(UserName,BookId) values(?,?)";
			pst = conn.prepareStatement(sql);
			pst.setString(1, username);
			pst.setInt(2, bookId);
			pst.executeUpdate();
			sql = "Update Books set TotalBooks=TotalBooks-1 where id=?";
			pst = conn.prepareStatement(sql);
			pst.setInt(1, bookId);
			pst.executeUpdate();
			return "Book with Id " + bookId + " Issued Successfully...";
		} else {
			return "Book Id " + bookId + " for User " + username + " Already Issued...";
		}

	}

	@Override
	public List<TranBookModel> accountDetails(String username) throws ClassNotFoundException, SQLException {
		conn = ConnectionHandler.getConnection();
		String sql = "select * from TranBook where username = ?";
		pst = conn.prepareStatement(sql);
		pst.setString(1, username);
		ResultSet rs = pst.executeQuery();
		List<TranBookModel> bookIssued = new ArrayList<TranBookModel>();
		while (rs.next()) {
			TranBookModel transBook = new TranBookModel(); // FIX: create object
			transBook.setBookId(rs.getInt("BookId"));
			transBook.setUserName(rs.getString("username"));
			transBook.setFromdate(rs.getDate("Fromdate"));
			bookIssued.add(transBook);
		}
		return bookIssued;

	}

	@Override
	public String returnbook(String username, int bookId) throws ClassNotFoundException, SQLException {
		String cmd = "SELECT * FROM TranBook WHERE Username = ? and BookId = ?";
		conn = ConnectionHandler.getConnection();
		pst = conn.prepareStatement(cmd);
		pst.setString(1, username);
		pst.setInt(2, bookId);
		ResultSet rs = pst.executeQuery();
		rs.next();
		Date fromDate = rs.getDate("fromDate");

		String sql2 = " INSERT INTO TransReturn(UserName,BookId,FromDate) VALUES (?,?,?)";
		pst = conn.prepareStatement(sql2);
		pst.setString(1, username);
		pst.setInt(2, bookId);
		pst.setDate(3, fromDate);
		pst.executeUpdate();

		String sql1 = "DELETE FROM TranBook WHERE BookId = ? AND Username = ? ";
		pst = conn.prepareStatement(sql1);
		pst.setInt(1, bookId);
		pst.setString(2, username);
		pst.executeUpdate();

		String sql3 = "Update Books set TotalBooks = TotalBooks + 1 where Id = ?";
		pst = conn.prepareStatement(sql3);
		pst.setInt(1, bookId);
		pst.executeUpdate();
		return "Book with Id " + bookId + " For User " + username + " Returned Successfully...";
	}
	
	
	@Override
    public List<TransReturn> getAllTransactionHistory() throws SQLException, ClassNotFoundException {
        List<TransReturn> historyList = new ArrayList<>();
        String sql = "SELECT * FROM TransReturn";

        try (
            Connection conn = ConnectionHandler.getConnection();
            PreparedStatement pst = conn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery()
        ) {
            while (rs.next()) {
                TransReturn tr = new TransReturn();
                tr.setUsername(rs.getString("Username"));
                tr.setBookId(rs.getInt("BookId"));
                tr.setFromDate(rs.getDate("Fromdate"));
                tr.setToDate(rs.getDate("Todate"));
                historyList.add(tr);
            }
        }

        return historyList;
    }
	
	
	

	@Override
	public String addBooks(BookModel book) throws SQLException, ClassNotFoundException {
	    Connection conn = ConnectionHandler.getConnection();

	    String checkSql = "SELECT Id, TotalBooks FROM Books WHERE Name = ?";
	    try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
	        checkStmt.setString(1, book.getName());
	        ResultSet rs = checkStmt.executeQuery();

	        if (rs.next()) {
	            int existingBookId = rs.getInt("Id");
	            int existingCount = rs.getInt("TotalBooks");

	            String updateSql = "UPDATE Books SET TotalBooks = ? WHERE Id = ?";
	            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
	                updateStmt.setInt(1, existingCount + book.getNoOfBooks());
	                updateStmt.setInt(2, existingBookId);
	                int updated = updateStmt.executeUpdate();
	                return updated > 0 ? "Book count updated successfully." : "Failed to update book count.";
	            }

	        } else {
	            String maxIdSql = "SELECT MAX(Id) AS maxId FROM Books";
	            try (PreparedStatement maxStmt = conn.prepareStatement(maxIdSql);
	                 ResultSet maxRs = maxStmt.executeQuery()) {

	                int newBookId = 1;
	                if (maxRs.next() && maxRs.getInt("maxId") > 0) {
	                    newBookId = maxRs.getInt("maxId") + 1;
	                }

	                String insertSql = "INSERT INTO Books (Id, Name, Author, Edition, Dept, TotalBooks) VALUES (?, ?, ?, ?, ?, ?)";
	                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
	                    insertStmt.setInt(1, newBookId);
	                    insertStmt.setString(2, book.getName());
	                    insertStmt.setString(3, book.getAuthor());
	                    insertStmt.setString(4, book.getEdition());
	                    insertStmt.setString(5, book.getDept());
	                    insertStmt.setInt(6, book.getNoOfBooks());

	                    int inserted = insertStmt.executeUpdate();
	                    return inserted > 0 ? "New book added successfully." : "Failed to add new book.";
	                }
	            }
	        }
	    }
	}


}
