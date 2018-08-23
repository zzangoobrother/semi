package semi.locationInfo.model.dao;

import static semi.common.JDBCTemplat.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import semi.locationInfo.exception.LocationInfoException;
import semi.locationInfo.model.vo.LocationInfo;

public class LocationInfoDao {

	public String toolSelect(Connection conn, String borough) {
		return null;
	}
	
	public ArrayList<LocationInfo> boroughSelect(Connection conn, String borough) {
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();
		
		return list;
	}
	
	public ArrayList<LocationInfo> listView(Connection conn) {
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();
		
		return list;
	}
	
	public int getListCount(Connection conn) {
		int listCount = 0;
		
		Statement stmt = null;
		
		ResultSet rset = null;
		
		String query = "select count(*) from tb_local";
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(query);
			
			if(rset.next()) {
				listCount = rset.getInt(1);
			} else {
				throw new LocationInfoException("검색할 지역이 없습니다!");
			}
		} catch (Exception e) {
			e.printStackTrace();
			//throw new LocationInfoException(e.getMessage());
		} finally {
			close(rset);
			close(stmt);
		}
		
		return listCount;
	}

	public ArrayList<LocationInfo> selectList(Connection conn, int currentPage, int limit) {
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from (select rownum rnum, l_name, l_local, l_address from tb_local) where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				LocationInfo location = new LocationInfo();
				
				location.setL_Name(rset.getString("l_name"));
				location.setL_Local(rset.getString("l_local"));
				location.setL_Address(rset.getString("l_address"));
				
				list.add(location);
			}
			
			if(list.size() == 0) {
				throw new LocationInfoException("지역이 존재하지 않습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			//throw new LocationInfoException(e.getMessage());
		} finally {
			close(rset);
			close(pstmt);
		}
		
		
		return list;
	}
}
