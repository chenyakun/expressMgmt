import ex.model.AppJoinDAO;



public class test {

	public static void main(String[] args) {

		try {

			AppJoinDAO dao = new AppJoinDAO();
			dao.findAll();
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
