package semi.rental.model.dao;

import static semi.common.JDBCTemplat.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import semi.locationInfo.model.vo.LocationInfo;
import semi.products.model.vo.Product;
import semi.rental.exception.RentalException;
import semi.rental.model.vo.Rental;

public class RentalDao {

	public int insertRental(Connection conn, Rental rental) throws RentalException {
		int result = 0;

		PreparedStatement pstmt = null;

		String query = "insert into tb_rental values (?, ?, ?, ?, ?, sysdate, ?, ?, null, null, ?)";

		try {
			pstmt = conn.prepareStatement(query);

			pstmt.setString(1, rental.getrNo());
			pstmt.setInt(2, rental.getpNo());
			pstmt.setString(3, rental.getmId());
			pstmt.setInt(4, rental.getpCount());
			pstmt.setInt(5, rental.getrPrice());
			pstmt.setString(6, rental.getrStartDate());
			pstmt.setString(7, rental.getrReturnDate());
			pstmt.setString(8, rental.getpState());

			result = pstmt.executeUpdate();

			if (result <= 0) {
				throw new RentalException("물품 대여 정보 등록 실패!");
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new RentalException(e.getMessage());
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int manageInsertRental(Connection con, Rental r) throws RentalException {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into tb_rental values (대여번호, ?, ?, ?, ?, ?, ?, null, null, ?)";

		/*
		 * R_NO VARCHAR2(100 BYTE) No 1 대여번호 P_NO NUMBER No 2 물품번호 M_ID
		 * VARCHAR2(30 BYTE) Yes 3 아이디 R_PRICE NUMBER No 4 대여소계 RENTAL_DATE DATE
		 * Yes SYSDATE 5 대여접수일자 RENTAL_START_DATE DATE Yes 6 대여실행일자
		 * R_RETURN_DATE DATE No 7 반납접수일자 R_RETURN_LAST_DATE DATE Yes 8 반납실행일자
		 * R_BOOKING_DAYE DATE Yes 9 예약일자 P_STATE VARCHAR2(30 BYTE) Yes 10 대여상태
		 */

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "대여번호");
			pstmt.setInt(2, r.getpNo());
			pstmt.setString(3, r.getmId());
			pstmt.setInt(4, r.getrPrice());
			// pstmt.setDate(5, r.getRentalDate());
			// pstmt.setDate(6, r.getRentalStartDate());
			// pstmt.setDate(7, r.getRentalReturnDate());
			pstmt.setString(8, r.getpState());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}

		return result;
	}

	public String insertRentalNumber(Connection con, Rental r) throws RentalException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String rentalNum = "";

		String query = "select r_no from tb_rentallist where m_id = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, r.getmId());

			rset = pstmt.executeQuery();

			if (rset.next())
				rentalNum = rset.getString(1);

		} catch (Exception e) {
			e.printStackTrace();
			e.getMessage();
		}

		return rentalNum;
	}

	// 지역명 조회용
	public ArrayList<LocationInfo> rentalLocalList(Connection con) throws RentalException {
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();

		// String query = "select distinct l_local, l_name from tb_local";
		String query = "select distinct l_local from tb_local order by 1";

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);

			while (rset.next()) {
				LocationInfo l = new LocationInfo();
				l.setL_Local(rset.getString("l_local"));

				list.add(l);

			}

			if (list == null)
				throw new RentalException("지역 존재하지 않음");

		} catch (Exception e) {
			e.printStackTrace();
			throw new RentalException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}

		return list;
	}

	// 동사무소 조회용
	public ArrayList<LocationInfo> rentalLocalNameList(Connection con, String localName) throws RentalException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();

		String query = "select l_name from tb_local where l_local = ? order by 1";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, localName);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				LocationInfo l = new LocationInfo();
				l.setL_Name(rset.getString("l_name"));

				list.add(l);
			}

			if (list == null)
				throw new RentalException("동사무소 존재하지 않음");

		} catch (Exception e) {
			e.printStackTrace();
			throw new RentalException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	// 물품이름 조회용
	public ArrayList<Product> rentalProductNameList(Connection con, String localName) throws RentalException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<Product> list = new ArrayList<Product>();
		String query = "select p_name from tb_product where p_local = ? order by 1";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, localName);

			rset = pstmt.executeQuery();

			while (rset.next()) {
				Product p = new Product();
				p.setP_name(rset.getString(1));
				list.add(p);
			}

			if (list == null)
				throw new RentalException("조회물품 존재하지 않음");

		} catch (Exception e) {
			e.printStackTrace();
			throw new RentalException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}
	
	//물품정보 조회용
	public Product rentalProductInfoList(Connection con, String pName, String lName) throws RentalException {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Product p = new Product();
		System.out.println("productinfo dao : " + pName + "," + lName);
		String query = "select p_no, p_price, p_count, p_item, p_state "
				+ "from tb_product where p_name = ? and p_local = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "'" + pName + "'");
			pstmt.setString(2, "'" + lName + "'");

			rset = pstmt.executeQuery();

			if (rset.next()) {
				p.setP_no(rset.getInt(1));
				p.setP_price(rset.getInt(2));
				p.setP_count(rset.getInt(3));
				p.setP_item(rset.getString(4));
				p.setP_state(rset.getString(5));
			} else {
				throw new RentalException("물품정보 존재하지 않음");
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new RentalException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}

		return p;
	}
}
