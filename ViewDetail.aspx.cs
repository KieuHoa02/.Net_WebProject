using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class ViewDetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string itemId = Request.QueryString["ItemID"];
                if (!string.IsNullOrEmpty(itemId))
                {
                    LoadItemDetails(itemId);
                }
                else
                {
                    Response.Redirect("MenuItem.aspx");
                }
            }
        }

        private void LoadItemDetails(string itemId)
        {
            try
            {
                if (!clsDatabase.OpenConnection())
                {
                    ShowAlert("Không thể kết nối cơ sở dữ liệu!");
                    return;
                }

                string query = "SELECT * FROM MenuItems WHERE ItemID = @ItemID";
                using (SqlCommand cmd = new SqlCommand(query, clsDatabase.con))
                {
                    cmd.Parameters.AddWithValue("@ItemID", itemId);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtName.Text = reader["Name"].ToString();
                            decimal price = Convert.ToDecimal(reader["Price"]);
                            txtPrice.Text = ((int)price).ToString("N0"); // Định dạng giá

                            txtDescription.Text = reader["Description"].ToString();
                            txtCategory.Text = reader["Category"].ToString();
                            txtType.Text = reader["Type"].ToString();

                            if (reader["Image"] != DBNull.Value)
                            {
                                byte[] imageData = (byte[])reader["Image"];
                                imgFood.ImageUrl = imageData.Length > 0
                                    ? $"data:image/png;base64,{Convert.ToBase64String(imageData)}"
                                    : "https://via.placeholder.com/300";
                            }
                            else
                            {
                                imgFood.ImageUrl = "https://via.placeholder.com/300";
                            }
                        }
                        else
                        {
                            ShowAlert("Không tìm thấy món ăn!");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowAlert("Lỗi khi tải thông tin món ăn: " + ex.Message);
            }
            finally
            {
                clsDatabase.CloseConnection();
            }
        }

        private void ShowAlert(string message)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", $"alert('{message}');", true);
        }
    }
}
