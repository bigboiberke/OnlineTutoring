Public Class Student
 Inherits System.Web.UI.Page
 Dim txt As String
 Dim provider1 As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource1 As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connString As String = provider1 & dataSource1
 Dim con1 As New OleDb.OleDbConnection(connString)
 Dim found1 As Boolean = False
 Dim StudentID As Integer
 Dim sqlCommand As OleDb.OleDbCommand
 Dim rs As OleDb.OleDbDataReader
 Public Sub populatefromdb()
 Try
 con1.Open()
 sqlCommand = con1.CreateCommand
 'select student id, username and password
 sqlCommand.CommandText = "SELECT [ID], [StudentFirstName], [StudentLastName], 
[StudentEmail], [PhotoLink] FROM Students"
 rs = sqlCommand.ExecuteReader
 StudentID = CInt(Session("StudentID").ToString)
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found1 = False
 ' compare the data from the table with the input data for username and
 If CInt(rs(0).ToString) = StudentID Then
 txtname1.Text = rs(1).ToString
 txtlastname1.Text = rs(2).ToString
txtemail3.Text = rs(3).ToString
Image1.ImageUrl = rs(4).ToString
found1 = True
 End If
 End While
 con1.Close()
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Public Sub updatedb()
 Dim first, last, email As String
 first = txtname1.Text
 last = txtlastname1.Text
 email = txtemail3.Text
 StudentID = Session("StudentID").ToString
 Try
 con1.Open()
 Dim SqlString = "UPDATE [Students] SET [StudentFirstName]=?, 
[StudentLastName]=?, [StudentEmail]=? WHERE [ID]=?"
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con1)
 cmd1.Parameters.AddWithValue("StudentFirstName", first)
 cmd1.Parameters.AddWithValue("StudentLastName", last)
 cmd1.Parameters.AddWithValue("StudentEmail", email)
 cmd1.Parameters.AddWithValue("ID", CInt(StudentID))
 cmd1.ExecuteNonQuery()
 con1.Close()
 MsgBox("Success")
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Public Sub updatephoto()
 StudentID = Session("StudentID").ToString
 Try
 txt = txtChangeImg.Text
 con1.Open()
 Dim SqlString = "UPDATE [Students] SET [PhotoLink]=? WHERE [ID]=?"
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con1)
 cmd1.Parameters.AddWithValue("PhotoLink", txt)
 cmd1.Parameters.AddWithValue("ID", CInt(StudentID))
 cmd1.ExecuteNonQuery()
 con1.Close()
 MsgBox("Success")
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 End Sub
 Protected Sub btnsave_Click(sender As Object, e As EventArgs) Handles Button2.Click
 txt = txtChangeImg.Text
 updatephoto()
 Image1.ImageUrl = txt
 txtChangeImg.Text = ""
 End Sub
 Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles btnsave.Click
 updatedb()
 End Sub
 Protected Sub btnpersonaldata_Click(sender As Object, e As EventArgs) Handles
btnpersonaldata.Click
 populatefromdb()
 End Sub
 Protected Sub btnchangepass_Click(sender As Object, e As EventArgs) Handles
btnchangepass.Click
 Dim current, newpass, reppas, passindb As String
 Try
 current = txtcurrentpassword.Text
 newpass = txtnewpassword.Text
 reppas = txtconfirmnewpassword.Text
 con1.Open()
 sqlCommand = con1.CreateCommand
 'select student id, password
 sqlCommand.CommandText = "SELECT [ID], [StudentPassword] FROM Students"
 rs = sqlCommand.ExecuteReader
 StudentID = CInt(Session("StudentID").ToString)
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found1 = False
 ' compare the data from the table with the input data for username and
 If CInt(rs(0).ToString) = StudentID Then
 passindb = rs(1).ToString
found1 = True
 End If
 End While
 If (passindb.Length > 0) Then
 If (passindb = current) Then
 If (newpass = reppas) Then
 Dim SqlString = "UPDATE [Students] SET [StudentPassword]=? WHERE 
[ID]=?"
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con1)
 cmd1.Parameters.AddWithValue("StudentPassword", newpass)
 cmd1.Parameters.AddWithValue("ID", CInt(StudentID))
 cmd1.ExecuteNonQuery()
con1.Close()
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
 Protected Sub TextBox6_TextChanged(sender As Object, e As EventArgs) Handles
txtnewpassword.TextChanged
 End Sub
End Class
