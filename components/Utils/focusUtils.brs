'---------------------------------------------'
' FOCUS UTILS '
'---------------------------------------------'

'Sets focus on '
function applyFocus(obj as Object, focusState = true as Boolean, log = "" as String )

  if (isValid(obj))

    obj.setFocus(focusState)
    print " Setting Focus on component ID " + obj.id + " Log : " + log
  end if
end function
