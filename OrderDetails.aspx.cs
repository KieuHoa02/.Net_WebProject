using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace WebApplication1
{
    public partial class OrderDetails : System.Web.UI.Page
    {
        clsDatabase db = new clsDatabase();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMenuItems();
                LoadOrderDetails();
                GridView2.Visible = false;
            }
        }


        private void LoadMenuItems()
        {
            string query = "SELECT * FROM MenuItems";
            GridView1.DataSource = db.GetData(query);
            GridView1.DataBind();
        }

        private void LoadOrderDetails()
        {
            int userID = 1; // Giả định lấy từ session
            int orderID = GetOrderID(userID);

            if (orderID == -1)
            {
                lblTotalPrice.Text = "0";
                GridView2.DataSource = null;
                GridView2.DataBind();
                return;
            }

            string query = "SELECT mi.Name, od.Quantity, od.Price, od.ItemID FROM OrderDetails od " +
                           "JOIN MenuItems mi ON od.ItemID = mi.ItemID WHERE od.OrderID = " + orderID;

            DataTable dt = db.GetData(query);
            GridView2.DataSource = dt;
            GridView2.DataBind();

            decimal total = 0;
            foreach (DataRow row in dt.Rows)
            {
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            }
            lblTotalPrice.Text = total.ToString("C");
        }


        private int GetOrderID(int userID)
        {
            string query = $"SELECT OrderID FROM Orders WHERE UserID = {userID} AND Status = 'Pending'";
            object result = db.ExecuteScalar(query);
            return result != null ? Convert.ToInt32(result) : -1;
        }


        protected void btnAddItem_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int itemID = Convert.ToInt32(btn.CommandArgument);
            int userID = 1;
            int orderID = GetOrderID(userID);

            if (orderID == -1)
            {
                string createOrderQuery = $"INSERT INTO Orders (UserID, Status) OUTPUT INSERTED.OrderID VALUES ({userID}, 'Pending')";
                orderID = Convert.ToInt32(db.ExecuteScalar(createOrderQuery));
            }

            string checkQuery = $"SELECT COUNT(*) FROM OrderDetails WHERE OrderID = {orderID} AND ItemID = {itemID}";
            int count = Convert.ToInt32(db.ExecuteScalar(checkQuery));

            if (count > 0)
            {
                string updateQuery = $"UPDATE OrderDetails SET Quantity = Quantity + 1 WHERE OrderID = {orderID} AND ItemID = {itemID}";
                db.ExecuteNonQuery(updateQuery);
            }
            else
            {
                string insertQuery = $"INSERT INTO OrderDetails (OrderID, ItemID, Quantity, Price) VALUES ({orderID}, {itemID}, 1, (SELECT Price FROM MenuItems WHERE ItemID = {itemID}))";
                db.ExecuteNonQuery(insertQuery);
            }
            LoadOrderDetails();
        }


        protected void btnRemoveItem_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            int itemID = Convert.ToInt32(btn.CommandArgument);
            int userID = 1;
            int orderID = GetOrderID(userID);

            if (orderID == -1) return;

            string updateQuery = $"UPDATE OrderDetails SET Quantity = Quantity - 1 WHERE OrderID = {orderID} AND ItemID = {itemID}";
            db.ExecuteNonQuery(updateQuery);

            string deleteQuery = $"DELETE FROM OrderDetails WHERE OrderID = {orderID} AND ItemID = {itemID} AND Quantity <= 0";
            db.ExecuteNonQuery(deleteQuery);

            LoadOrderDetails();
        }

        protected void btnToggleOrder_Click(object sender, EventArgs e)
        {
            GridView2.Visible = !GridView2.Visible;
            if (GridView2.Visible) LoadOrderDetails();
        }

        protected void btnViewInvoice_Click(object sender, EventArgs e)
        {
            int userID = 1;
            int orderID = GetOrderID(userID);

            if (orderID != -1)
            {
                GridViewInvoice.Visible = !GridViewInvoice.Visible;
                if (GridViewInvoice.Visible) LoadInvoiceDetails(orderID);
            }
        }


        private void LoadInvoiceDetails(int orderID)
        {
            string query = $"SELECT o.OrderID, o.OrderTime, mi.Name AS ItemName, od.Quantity, od.Price, (od.Quantity * od.Price) AS TotalPrice " +
                           "FROM Orders o " +
                           "JOIN OrderDetails od ON o.OrderID = od.OrderID " +
                           "JOIN MenuItems mi ON od.ItemID = mi.ItemID " +
                           "WHERE o.OrderID = {orderID}";
            GridViewInvoice.DataSource = db.ExecuteQuery(query);
            GridViewInvoice.DataBind();
        }

        protected void btnCreateOrder_Click(object sender, EventArgs e)
        {
            int userID = 1; // Giả định UserID lấy từ session
            int orderID = GetOrderID(userID);
            int totalPrice;
            bool isValid = int.TryParse(lblTotalPrice.Text, out totalPrice);

            if (GridView2.Rows.Count == 0)
            {
                Response.Write("Không thể tạo đơn hàng do chưa chọn món !");
                return;
            }

            string createOrderQuery = $"INSERT INTO Orders (UserID, Status, TotalPrice) OUTPUT INSERTED.OrderID VALUES ({userID}, 'Pending', {totalPrice})";
            orderID = Convert.ToInt32(db.ExecuteScalar(createOrderQuery));

            lblTotalPrice.Text = "0";
            LoadOrderDetails();
            Response.Write("Đơn hàng mới được tạo !");
        }

        protected void btnCancelOrder_Click(object sender, EventArgs e)
        {
            int userID = 1;
            int orderID = GetOrderID(userID);

            if (orderID != -1)
            {
                db.ExecuteNonQuery($"DELETE FROM OrderDetails WHERE OrderID = {orderID}");
                db.ExecuteNonQuery($"DELETE FROM Orders WHERE OrderID = {orderID} AND Status = 'Pending'");
                LoadOrderDetails();
                Response.Write("<script>alert('Đơn hàng đã được hủy!');</script>");
            }
            else
            {
                Response.Write("<script>alert('Không có đơn hàng nào để hủy!');</script>");
            }
        }
    }
}


