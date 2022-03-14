Public Class WebForm1
 Inherits System.Web.UI.Page
 Dim provider As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connectionString As String = provider & dataSource
 Dim con As New OleDb.OleDbConnection(connectionString)
 Dim firstname, lastname, email, password0, password2 As String
 Dim emailSignIn, PasswordSignIn As String
 Dim adminUser As String = "adminMTIS"
 Dim adminPassword As String = "123@MTIS"
 Dim flag As Boolean = False
 Dim found As Boolean = False
 Dim SqlString As String
 Dim teacher As Boolean = False
 Dim code As String = "teacheraccess1234"
 Dim defaultphoto As String = 
"https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg
"
 Public Sub validateData()
 ' use try catch block to avoid crashing the program
 Try
 ' save data given by the user
 firstname = txtfirstname.Text
 lastname = txtlastname.Text
 password1 = txtpassword.Text
 password2 = txtconfirmpassword.Text
 Dim enteredcode As String = txtcode.Text
 email = txtemail.Text
 ' store the number of characters the email has
 Dim emailLength As Integer = email.Length
 ' check the password
 If (password1 <> password2) Then
 MsgBox("Passwords don't match!")
 ' check if e-mail contains @ symbol
 ElseIf email.Contains("@") = False Then
 MsgBox("Invalid e-mail address")
 ' check if full name is given
 ElseIf firstname.Length < 1 Then
 MsgBox("First name needs to be entered")
 ElseIf lastname.Length < 1 Then
 MsgBox("Last name needs to be entered")
 ElseIf password1.Length < 1 Then
 MsgBox("Password needs to be entered")
 ElseIf ((rdbtnteacher.Checked = True) And (code = enteredcode)) Then
 SqlString = "INSERT INTO Teachers ([TeacherFirstName], [TeacherLastName], 
[TeacherEmail], [TeacherPassword]) VALUES (?,?,?,?)"
 Dim cmd As New OleDb.OleDbCommand(SqlString, con)
 cmd.Parameters.AddWithValue("TeacherFirstName", firstname)
 cmd.Parameters.AddWithValue("TeacherLastName", lastname)
 cmd.Parameters.AddWithValue("TeacherEmail", email)
 cmd.Parameters.AddWithValue("TeacherPassword", password1)
 cmd.ExecuteNonQuery()
 teacher = True
 MsgBox("You've successfully signed up!")
 flag = True
 ElseIf (rdbtnteacher.Checked = False) Then
 SqlString = "INSERT INTO Students ([StudentFirstName], [StudentLastName], 
[StudentEmail], [StudentPassword], [PhotoLink]) VALUES (?,?,?,?,?)"
 Dim cmd As New OleDb.OleDbCommand(SqlString, con)
 cmd.Parameters.AddWithValue("StudentFirstName", firstname)
 cmd.Parameters.AddWithValue("StudentLastName", lastname)
 cmd.Parameters.AddWithValue("StudentEmail", email)
 cmd.Parameters.AddWithValue("StudentPassword", password1)
 cmd.Parameters.AddWithValue("PhotoLink", defaultphoto)
 cmd.ExecuteNonQuery()
 MsgBox("You've successfully signed up!")
 flag = True
 Else
 MsgBox("Try Again")
 End If
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub btnsignup_Click(sender As Object, e As EventArgs) Handles
btnsignup.Click
 con.Open()
 validateData()
 If flag = True And teacher = True Then
 Response.Redirect("Teacher.aspx")
 ElseIf flag = True And teacher = False Then
 Response.Redirect("Student.aspx")
 Else
 MsgBox("Use the new credentials to sign in if you have signed up")
 End If
 End Sub
End Class
