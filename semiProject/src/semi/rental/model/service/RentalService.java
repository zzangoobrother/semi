package semi.rental.model.service;

import static semi.common.JDBCTemplat.close;
import static semi.common.JDBCTemplat.commit;
import static semi.common.JDBCTemplat.getConnection;
import static semi.common.JDBCTemplat.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import semi.locationInfo.model.vo.LocationInfo;
import semi.products.model.vo.Product;
import semi.rental.exception.RentalException;
import semi.rental.model.dao.RentalDao;
import semi.rental.model.vo.Rental;

public class RentalService {

	public int insertRental(Rental rental) throws RentalException {
		int result = 0;

		Connection conn = getConnection();

		result = new RentalDao().insertRental(conn, rental);

		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}

		close(conn);

		return result;
	}

	// 관리자 대여 등록
	public int manageInsertRental(Rental r) throws RentalException {
		Connection con = getConnection();
		int result = new RentalDao().manageInsertRental(con, r);
		if (result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	// 대여목록 테이블의 대여번호 생성용
	public Rental insertRentalNumber(Rental r) throws RentalException {
		Connection con = getConnection();
		String rentalNum = new RentalDao().insertRentalNumber(con, r);
		r.setrNo(rentalNum);

		if (Integer.parseInt(rentalNum) > 0)
			commit(con);
		else
			rollback(con);
		return r;

	}

	// 지역명 조회용
	public ArrayList<LocationInfo> rentalLocalList() throws RentalException {
		Connection con = getConnection();
		ArrayList<LocationInfo> list = new RentalDao().rentalLocalList(con);
		if (list != null)
			commit(con);
		else
			rollback(con);
		close(con);
		return list;
	}

	// 동사무소 조회용
	public ArrayList<LocationInfo> rentalLocalNameList(String localName) throws RentalException {
		Connection con = getConnection();
		ArrayList<LocationInfo> list = new RentalDao().rentalLocalNameList(con, localName);
		if (list != null)
			commit(con);
		else
			rollback(con);
		close(con);
		return list;
	}

	// 물품명 출력용
	public ArrayList<Product> rentalProductNameList(String localName) throws RentalException {
		Connection con = getConnection();
		ArrayList<Product> list = new RentalDao().rentalProductNameList(con, localName);
		if (list != null)
			commit(con);
		else
			rollback(con);
		close(con);
		return list;
	}

	// 물품정보 출력용
	public Product rentalProductInfoList(String pName, String lName) throws RentalException {
		Connection con = getConnection();
		Product p = new RentalDao().rentalProductInfoList(con, pName, lName);
		if (p != null)
			commit(con);
		else
			rollback(con);
		close(con);
		return p;
	}
}
