Public Class DisplayQuestions
 Inherits System.Web.UI.Page
 Dim provider4 As String = "Provider=Microsoft.ACE.OLEDB.12.0;"
 Dim dataSource4 As String = "Data 
Source=C:\Users\Berke\source\repos\WebApplication1\WebApplication1\Support.accdb"
 Dim connString4 As String = provider4 & dataSource4
 Dim con4 As New OleDb.OleDbConnection(connString4)
 Dim TeacherID As String
 Dim StID, StQtId As String
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 End Sub
 Public Sub updatequestionsdb()
 Dim taken As Boolean = True
 Try
 TeacherID = Session("TeacherID").ToString
 con4.Open()
 Dim SqlString = "UPDATE [Questions] SET [QuestionTaken]=?, [TeacherID]=? 
WHERE [ID]=?"
 Dim cmd1 As New OleDb.OleDbCommand(SqlString, con4)
 cmd1.Parameters.AddWithValue("QuestionTaken", taken)
 cmd1.Parameters.AddWithValue("TeacherID", CInt(TeacherID))
 cmd1.Parameters.AddWithValue("QuestionID", StQtId)
 cmd1.ExecuteNonQuery()
 con4.Close()
 MsgBox("Success")
 Catch ex As Exception
 MsgBox(ex.ToString)
 End Try
 End Sub
 Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) 
Handles GridView1.SelectedIndexChanged
 StQtId = GridView1.SelectedDataKey.Item(0)
 StID = GridView1.SelectedRow.Cells(1).Text
 updatequestionsdb()
 GridView1.SelectedRow.Cells(7).Enabled = False
 System.Web.HttpContext.Current.Session("QuestionID") = StQtId.ToString
 System.Web.HttpContext.Current.Session("QuestionStudentID") = StID.ToString
 End Sub
End Class
