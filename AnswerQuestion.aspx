Imports System.Net.Mail
Public Class AnswerQuestion
 Inherits System.Web.UI.Page
 Dim provider5 As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource5 As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connString5 As String = provider5 & dataSource5
 Dim con5 As New OleDb.OleDbConnection(connString5)
 Dim TeacherID As String
 Dim StID, StQtId As String
 Dim sqlCommand As OleDb.OleDbCommand
 Dim rs As OleDb.OleDbDataReader
 Dim found5 As Boolean = False
 Sub retrievequestion()
 Try
 con5.Open()
 sqlCommand = con5.CreateCommand
 'select questions
 sqlCommand.CommandText = "SELECT * FROM Questions"
 rs = sqlCommand.ExecuteReader
 StID = CInt(Session("AnswerQuestionStudentID").ToString)
 StQtId = CInt(Session("AnswerQuestionID").ToString)
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read Or found5 = False
 ' compare the data from the table with the input data for username and
 If CInt(rs(0).ToString) = StQtId Then
 LblTitle.Text = rs(2).ToString
LblSubject.Text = rs(3).ToString
LblDesc.Text = rs(4).ToString
LblDeadline.Text = rs(7).ToString
 Image1.ImageUrl = rs(5).ToString
 found5 = True
 End If
 End While
 con5.Close()
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub btnanswer_Click(sender As Object, e As EventArgs) Handles
btnanswer.Click
 Try
 ' compose the message text
 Dim messageContent As String = ""
 ' vbCrLf - sends the text to the next line
 messageContent = messageContent & "Dear Student," & vbCrLf & vbCrLf
 ' concatenation has been used - joining different text values together
 Dim Text As String
 Text = Request.Form("txtdescription1").ToString
 StID = CInt(Session("AnswerQuestionStudentID").ToString)
 con5.Open()
 sqlCommand = con5.CreateCommand
 'select questions
 sqlCommand.CommandText = "SELECT * FROM Students"
 rs = sqlCommand.ExecuteReader
 Dim foundstudent As Boolean = False
 Dim emailstudent As String = ""
 'repeat as long as there is still a record in the table and the user was not
 While rs.Read And foundstudent = False
 emailstudent = rs(3).ToString
 foundstudent = True
 End While
 messageContent = messageContent & "Please see below the answer to the 
question:" & LblTitle.Text & vbCrLf & "Teacher ID: " & Session("TeacherID") & vbCrLf & 
"Response: " & Text & vbCrLf & vbCrLf & vbCrLf & "Thank you," & vbCrLf & "Online Tutoring 
Team"
 Dim smtp As New SmtpClient
 smtp.Port = 587
 smtp.EnableSsl = True
 smtp.Host = "smtp.gmail.com"
 Dim emailmessage As New MailMessage()
 ' provide sender and receiver details
 emailmessage.From = New MailAddress("onlinetutoringteam@gmail.com")
 Dim emaildestination As String
 emaildestination = emailstudent
 emailmessage.To.Add(emaildestination)
 emailmessage.Subject = "Answer to your online question!"
 emailmessage.Body = messageContent
 ' allow for authentication
 'access to the app needed to be provided from Gmail account, as it was 
blocked for security reasons by Google
 smtp.Credentials = New
System.Net.NetworkCredential("onlinetutoringteam@gmail.com", "berke2002")
 smtp.Send(emailmessage)
 Dim SqlDelete As String
 sqlCommand = con5.CreateCommand
 StQtId = CInt(Session("AnswerQuestionID").ToString)
 SqlDelete = "DELETE FROM Questions WHERE ID=?"
 Dim cmd As New OleDb.OleDbCommand(SqlDelete, con5)
 cmd.Parameters.AddWithValue("ID", StQtId)
 cmd.ExecuteNonQuery()
 Response.Redirect("DisplayQuestions.aspx")
 MsgBox("Email Sent")
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 retrievequestion()
 End Sub
End Clas
