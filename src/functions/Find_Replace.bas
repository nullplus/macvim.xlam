Attribute VB_Name = "F_Find_Replace"
Option Explicit
Option Private Module

Function showFindFollowLang()
    UF_FindForm.Show
End Function

Function showFindNotFollowLang()
    gLangJa = Not gLangJa
    UF_FindForm.Show
    gLangJa = Not gLangJa
End Function

Function nextFoundCell()
    On Error GoTo Catch

    Dim t As Range
    Dim i As Integer

    If gCount > 1 Then
        Application.ScreenUpdating = False
    End If

    Call recordToJumpList

    For i = gCount To 1 Step -1
        If gCount = 1 Then
            Application.ScreenUpdating = True
        End If

        Set t = Cells.FindNext(After:=ActiveCell)
        If Not t Is Nothing Then
            t.Activate
        Else
            Application.ScreenUpdating = True
            Exit Function
        End If

    Next i
    Exit Function

Catch:
    If Err.Number <> 0 Then
        Call errorHandler("nextFoundCell")
    End If
End Function

Function previousFoundCell()
    On Error GoTo Catch

    Dim t As Range
    Dim i As Integer

    If gCount > 1 Then
        Application.ScreenUpdating = False
    End If

    Call recordToJumpList

    For i = gCount To 1 Step -1
        If i = 1 Then
            Application.ScreenUpdating = True
        End If

        Set t = Cells.FindPrevious(After:=ActiveCell)
        If Not t Is Nothing Then
            t.Activate
        Else
            Application.ScreenUpdating = True
            Exit Function
        End If

    Next i
    Exit Function

Catch:
    If Err.Number <> 0 Then
        Call errorHandler("previousFoundCell")
    End If
End Function

Function showReplaceWindow()
    Call keystroke(True, Alt_ + E_, E_)
End Function

Function findActiveValueNext()
    On Error GoTo Catch

    Dim t As Range
    Dim findText As String

    If ActiveCell Is Nothing Then
        Exit Function
    End If

    findText = ActiveCell.Value

    If findText = "" Then
        Exit Function
    End If

    Set t = ActiveSheet.Cells.Find(What:=findText, _
                                   After:=ActiveCell, _
                                   LookIn:=xlValues, _
                                   LookAt:=xlPart, _
                                   SearchOrder:=xlByColumns, _
                                   MatchByte:=False)

    If Not t Is Nothing Then
        Call recordToJumpList

        ActiveWorkbook.ActiveSheet.Activate
        t.Activate
    End If

    Call setStatusBarTemporarily("/" & findText, 2, disablePrefix:=True)
    Exit Function

Catch:
    If Err.Number <> 0 Then
        Call errorHandler("findActiveValueNext")
    End If
End Function

Function findActiveValuePrev()
    On Error GoTo Catch

    Dim t As Range
    Dim findText As String

    If ActiveCell Is Nothing Then
        Exit Function
    End If

    findText = ActiveCell.Value

    If findText = "" Then
        Exit Function
    End If

    Set t = ActiveSheet.Cells.Find(What:=findText, _
                                   After:=ActiveCell, _
                                   LookIn:=xlValues, _
                                   LookAt:=xlPart, _
                                   SearchOrder:=xlByColumns, _
                                   MatchByte:=False)

    If Not t Is Nothing Then
        Call recordToJumpList

        ActiveWorkbook.ActiveSheet.Activate
        Set t = Cells.FindPrevious(After:=ActiveCell)
        t.Activate
    End If

    Call setStatusBarTemporarily("?" & findText, 2, disablePrefix:=True)
    Exit Function

Catch:
    If Err.Number <> 0 Then
        Call errorHandler("findActiveValuePrev")
    End If
End Function
