Public Class TeacherQuestions
 Inherits System.Web.UI.Page
 Dim StID, StQtId As String
 Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles
Me.Load
 End Sub
 Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As EventArgs) 
Handles GridView1.SelectedIndexChanged
 StQtId = GridView1.SelectedRow.Cells(0).Text
 StID = GridView1.SelectedRow.Cells(1).Text
 System.Web.HttpContext.Current.Session("AnswerQuestionID") = StQtId.ToString
 System.Web.HttpContext.Current.Session("AnswerQuestionStudentID") = StID.ToString
 
 Response.Redirect("AnswerQuestion.aspx")
 End Sub
End Class
