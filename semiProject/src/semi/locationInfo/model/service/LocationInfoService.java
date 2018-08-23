package semi.locationInfo.model.service;

import static semi.common.JDBCTemplat.close;
import static semi.common.JDBCTemplat.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import semi.locationInfo.model.dao.LocationInfoDao;
import semi.locationInfo.model.vo.LocationInfo;

public class LocationInfoService {

	public String toolSelect(String borough) {
		return null;
	}
	
	public ArrayList<LocationInfo> boroughSelect(String borough) {
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();
		
		return list;
	}
	
	public ArrayList<LocationInfo> listView() {
		ArrayList<LocationInfo> list = new ArrayList<LocationInfo>();
		
		return list;
	}
	
	public int getListCount() {
		Connection conn = getConnection();
		int listCount = new LocationInfoDao().getListCount(conn);
		close(conn);
		
		return listCount;
	}

	public ArrayList<LocationInfo> selectList(int currentPage, int limit) {
		Connection conn = getConnection();
		ArrayList<LocationInfo> list = new LocationInfoDao().selectList(conn, currentPage, limit);
		close(conn);
		return list;
	}

}
