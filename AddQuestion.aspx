Public Class AddQuestion
 Inherits System.Web.UI.Page
 Dim provider2 As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource2 As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connString1 As String = provider2 & dataSource2
 Dim con2 As New OleDb.OleDbConnection(connString1)
 Dim found2 As Boolean = False
 Dim StudentID As Integer
 Dim SqlString1 As String
 Dim sqlCommand As OleDb.OleDbCommand
 Dim rs As OleDb.OleDbDataReader
 Dim timestamp As Date
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 End Sub
 Protected Sub btnaddquestion_Click(sender As Object, e As EventArgs) Handles
btnaddquestion.Click
 Try
 Dim title, subject, description, link As String
 Dim taken As Boolean = False
 Dim deadline As Date
 StudentID = Session("StudentID").ToString
 ''will take data from another page to corrolate the question with the ID of 
the student
 title = txttitle.Text
 subject = txtsubject.Text
 description = Request.Form("txtdescription").ToString
 link = txtimglink.Text
 deadline = Today
 deadline = DateAdd(DateInterval.Day, 2, deadline)
 ''all the data for the question table has been taken
 con2.Open()
 SqlString1 = "INSERT INTO Questions ([StudentID], [QuestionTitle], 
[QuestionSubject], [QuestionDescription], [QuestionLink], [QuestionTaken], 
[QuestionDeadline], [TeacherID]) VALUES (?,?,?,?,?,?,?,?)"
 Dim cmd As New OleDb.OleDbCommand(SqlString1, con2)
 cmd.Parameters.AddWithValue("StudentID", CInt(StudentID))
 cmd.Parameters.AddWithValue("QuestionTitle", title)
 cmd.Parameters.AddWithValue("QuestionSubject", subject)
 cmd.Parameters.AddWithValue("QuestionDescription", description)
 cmd.Parameters.AddWithValue("QuestionLink", link)
 cmd.Parameters.AddWithValue("QuestionTaken", taken)
 cmd.Parameters.AddWithValue("QuestionDeadline", deadline)
 cmd.Parameters.AddWithValue("TeacherID", 0)
 cmd.ExecuteNonQuery()
 con2.Close()
 ''once the button is clicked, all the data will be inserted into the database
 MsgBox("You've successfully submitted a question!")
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
End Class
