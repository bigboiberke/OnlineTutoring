Public Class Teacher
 Inherits System.Web.UI.Page
 Dim txt As String
 Dim provider3 As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource3 As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connString3 As String = provider3 & dataSource3
 Dim con3 As New OleDb.OleDbConnection(connString3)
 Dim found3 As Boolean = False
 Dim TeacherID As Integer
 Dim sqlCommand As OleDb.OleDbCommand
 Dim rs As OleDb.OleDbDataReader
 Public Sub populatefromdb()
 Try
 con3.Open()
 sqlCommand = con3.CreateCommand
 'select teacher id, username and password
 sqlCommand.CommandText = "SELECT [ID], [TeacherFirstName], [TeacherLastName], 
[TeacherEmail], [PhotoLinkT] FROM Teachers"
 rs = sqlCommand.ExecuteReader
 TeacherID = CInt(Session("TeacherID").ToString)
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found3 = False
 ' compare the data from the table with the input data for username and
 If CInt(rs(0).ToString) = TeacherID Then
 txtfirstnameT.Text = rs(1).ToString
txtlastnameT.Text = rs(2).ToString
 txtemailT.Text = rs(3).ToString
 Image1.ImageUrl = rs(4).ToString
found3 = True
 End If
 End While
 con3.Close()
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Public Sub updatedb()
 Dim first, last, email As String
 first = txtfirstnameT.Text
 last = txtlastnameT.Text
 email = txtemailT.Text
 TeacherID = Session("TeacherID").ToString
 ''Call arrays for first name, last name and email in order to use them for the 
update method
 Try
 con3.Open()
 Dim SqlString = "UPDATE [Teachers] SET [TeacherFirstName]=?, 
[TeacherLastName]=?, [TeacherEmail]=? WHERE [ID]=?"
 ''select data from the Teachers table in the database
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con3)
 cmd1.Parameters.AddWithValue("TeacherFirstName", first)
 cmd1.Parameters.AddWithValue("TeacherLastName", last)
 cmd1.Parameters.AddWithValue("TeacherEmail", email)
 cmd1.Parameters.AddWithValue("ID", CInt(TeacherID))
 cmd1.ExecuteNonQuery()
 con3.Close()
 MsgBox("Success")
 ''the database values will update according to what the user wrote in the 
text fields
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Public Sub updatephoto()
 TeacherID = Session("TeacherID").ToString
 Try
 txt = txtChangeImgT.Text
 con3.Open()
 Dim SqlString = "UPDATE [Teachers] SET [PhotoLinkT]=? WHERE [ID]=?"
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con3)
 cmd1.Parameters.AddWithValue("PhotoLinkT", txt)
 cmd1.Parameters.AddWithValue("ID", CInt(TeacherID))
 cmd1.ExecuteNonQuery()
 con3.Close()
 MsgBox("Success")
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 End Sub
 Protected Sub txtChangeImgT_TextChanged(sender As Object, e As EventArgs) Handles
txtChangeImgT.TextChanged
 txt = txtChangeImgT.Text
 updatephoto()
 Image1.ImageUrl = txt
 txtChangeImgT.Text = ""
 End Sub
 Protected Sub btnpersonaldataT_Click(sender As Object, e As EventArgs) Handles
btnpersonaldataT.Click
 populatefromdb()
 End Sub
 Protected Sub btnsaveT_Click(sender As Object, e As EventArgs) Handles btnsaveT.Click
 updatedb()
 End Sub
 Protected Sub btnchangepassT_Click(sender As Object, e As EventArgs) Handles
btnchangepassT.Click
 Dim current, newpass, reppas, passindb As String
 Try
 current = txtcurrentpasswordT.Text
 newpass = txtnewpasswordT.Text
 reppas = txtconfirmnewpasswordT.Text
 con3.Open()
 sqlCommand = con3.CreateCommand
 'select teacher id, password
 sqlCommand.CommandText = "SELECT [ID], [TeacherPassword] FROM Teachers"
 rs = sqlCommand.ExecuteReader
 TeacherID = CInt(Session("TeacherID").ToString)
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found3 = False
 ' compare the data from the table with the input data for password
 If CInt(rs(0).ToString) = TeacherID Then
 passindb = rs(1).ToString
 found3 = True
 End If
 End While
 If (passindb.Length > 0) Then
 If (passindb = current) Then
 If (newpass = reppas) Then
 Dim SqlString = "UPDATE [Teachers] SET [TeacherPassword]=? WHERE 
[ID]=?"
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con3)
 cmd1.Parameters.AddWithValue("TeacherPassword", newpass)
cmd1.Parameters.AddWithValue("ID", CInt(TeacherID))
 cmd1.ExecuteNonQuery()
con3.Close()
MsgBox("Password has been changed")
 Else
 MsgBox("Passwords do not match")
 End If
 Else
 MsgBox("Your Password is wrong")
 End If
 End If
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
End Class
