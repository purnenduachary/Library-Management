package com.lmp.dao;

import java.sql.SQLException;
import java.util.List;

import com.lmp.model.AdminLogin;
import com.lmp.model.BookModel;
import com.lmp.model.LibUsers;
import com.lmp.model.TranBookModel;
import com.lmp.model.TransReturn;


public interface LibraryDao {

	String createUser(LibUsers libusers) throws ClassNotFoundException, SQLException;
	
	int login(LibUsers libuser) throws ClassNotFoundException, SQLException;
	
	List<BookModel> searchBooks(String searchType, String searchvalue) throws ClassNotFoundException, SQLException;
	
	String issueBook(String username, int bookId) throws ClassNotFoundException, SQLException;
	
	List<TranBookModel> accountDetails(String username) throws ClassNotFoundException, SQLException;
	
	String returnbook(String username, int bookId) throws ClassNotFoundException, SQLException;
	
	List<TransReturn> getAllTransactionHistory() throws SQLException, ClassNotFoundException;

	
	
	//Admin methods
	String createAdmin(AdminLogin adlog) throws ClassNotFoundException, SQLException;
	
	int AdminLogin(AdminLogin adlog) throws ClassNotFoundException, SQLException;
	
	String addBooks(BookModel bm) throws SQLException, ClassNotFoundException;

}
