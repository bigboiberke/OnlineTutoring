Public Class WebForm1
 Inherits System.Web.UI.Page
 Dim provider1 As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource1 As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connString As String = provider1 & dataSource1
 Dim con1 As New OleDb.OleDbConnection(connString)
 Dim email1, password1 As String
 Dim adminUser1 As String = "adminMTIS"
 Dim adminPassword1 As String = "123@MTIS"
 Dim flag1 As Boolean = False
 Dim found1 As Boolean = False
 Dim SqlString1 As String
 Dim teacher1 As Boolean = False
 Dim Val As Integer
 Public Sub SelectFromStudents()
 Dim sqlCommand As OleDb.OleDbCommand
 Dim rs As OleDb.OleDbDataReader
 Try
 con1.Open()
 sqlCommand = con1.CreateCommand
 'select student id, username and password
 sqlCommand.CommandText = "SELECT [ID], [StudentEmail], [StudentPassword] FROM 
Students"
 rs = sqlCommand.ExecuteReader
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found1 = False
 ' compare the data from the table with the input data for username and
 If rs(1).ToString = txtemail1.Text And rs(2).ToString = txtpassword1.Text 
Then
 System.Web.HttpContext.Current.Session("StudentID") = rs(0).ToString
 found1 = True
 End If
 'set found to true to exit the loop
 End While
 If found1 = True Then
 'output welcome message once the user has been logged in
 MsgBox("Welcome " + txtemail1.Text)
 Else
 MsgBox("Incorrect credentials, try again!")
 End If
 con1.Close()
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Public Sub SelectFromTeachers()
 Dim sqlCommand As OleDb.OleDbCommand
 Dim rs As OleDb.OleDbDataReader
 Try
 con1.Open()
 sqlCommand = con1.CreateCommand
 'select student id, username and password
 sqlCommand.CommandText = "SELECT [ID], [TeacherEmail], [TeacherPassword] FROM 
Teachers"
 rs = sqlCommand.ExecuteReader
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found1 = False
 ' compare the data from the table with the input data for username and
 If rs(1).ToString = txtemail1.Text And rs(2).ToString = txtpassword1.Text 
Then
 System.Web.HttpContext.Current.Session("TeacherID") = rs(0).ToString
found1 = True
 End If
 'set found to true to exit the loop
 End While
 If found1 = True Then
 'output welcome message once the user has been logged in
 MsgBox("Welcome " + txtemail1.Text)
 Else
 MsgBox("Incorrect credentials, try again!")
 End If
 con1.Close()
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub btnsignin_Click(sender As Object, e As EventArgs) Handles
btnsignin.Click
 ' store input values into variables
 emailSignIn = txtemail1.Text
 PasswordSignIn = txtpassword1.Text 'check if the admin attempts to log If 
usernameSignIn = "adminMTIS" And
 If emailSignIn = adminUser1 And PasswordSignIn = adminPassword1 Then
 MsgBox("Welcome admin")
 ' send to the admin page 
 Response.Redirect("AdminPage.aspx")
 ' check if a teacher is attempting to log in
 ElseIf rdbtnteacher1.Checked = True Then
 'call the method to check the teacher'credentials 
 SelectFromTeachers()
 Else
 ' it means a student ' call the method to 
 SelectFromStudents()
 End If
 ' check if valid credentials have been provided and if the account belongs to a 
teacher
 If found1 = True And rdbtnteacher1.Checked = True Then
 Response.Redirect("Teacher.aspx")
 ElseIf found1 = True And rdbtnteacher1.Checked = False Then
 ' valid credentials but the account belongs to a student 'redirect to the 
student's home page 
 Response.Redirect("Student.aspx")
 Else
 MsgBox("Invalid Credentials")
 End If
 End Sub
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 End Sub
End Class
