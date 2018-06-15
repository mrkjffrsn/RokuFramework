
' Utility for Creating UI Buttons

' A dictionary contain image links to button names
function buttonConfig()

  return {

    "dislike" : {
      focused: "pkg:/images/fhd/Player_btns/dislike-focus-nopress.png",
      unfocused: "pkg:/images/fhd/Player_btns/dislike-nofocus.png",
      pressed_focused: "pkg:/images/fhd/Player_btns/dislike-focus-pressed.png",
      pressed_unfocused: "pkg:/images/fhd/Player_btns/dislike-nofocus-press.png",
      disabled: "pkg:/images/fhd/Player_btns/dislike-nofocus-inactive.png"
    },
    "next" : {
      focused : "pkg:/images/fhd/Player_btns/next-focus.png",
      unfocused : "pkg:/images/fhd/Player_btns/next-nofocus.png",
      pressed_unfocused : "pkg:/images/fhd/Player_btns/next-nofocus.png",
      pressed_focused : "pkg:/images/fhd/Player_btns/next-focus.png"
    },
    "playstop" : {
      focused : "pkg:/images/fhd/Player_btns/play-focus.png",
      unfocused : "pkg:/images/fhd/Player_btns/play-nofocus.png",
      pressed_focused : "pkg:/images/fhd/Player_btns/stop-focus.png",
      pressed_unfocused : "pkg:/images/fhd/Player_btns/stop-nofocus.png"
    },
    "playpause" : {
      focused : "pkg:/images/fhd/Player_btns/play-focus.png",
      unfocused : "pkg:/images/fhd/Player_btns/play-nofocus.png",
      pressed_focused : "pkg:/images/fhd/Player_btns/pause-focus.png",
      pressed_unfocused : "pkg:/images/fhd/Player_btns/pause-nofocus.png"
    },
    "like" : {
      unfocused : "pkg:/images/fhd/Player_btns/like-nofocus.png",
      focused : "pkg:/images/fhd/Player_btns/like-focus-nopress.png",
      pressed_focused : "pkg:/images/fhd/Player_btns/like-focus-pressed.png",
      pressed_unfocused : "pkg:/images/fhd/Player_btns/like-nofocus-press.png",
      disabled : "pkg:/images/fhd/Player_btns/like-nofocus-inactive.png"
    },
    "prev" : {
      focused : "pkg:/images/fhd/Player_btns/prev-focus.png",
      unfocused : "pkg:/images/fhd/Player_btns/prev-nofocus.png",
      pressed_unfocused : "pkg:/images/fhd/Player_btns/prev-nofocus.png",
      pressed_focused : "pkg:/images/fhd/Player_btns/prev-focus.png",
      disabled : "pkg:/images/fhd/Player_btns/prev-nofocus-inactive.png"
    },
    "minus15" : {
      focused: "pkg:/images/fhd/Player_btns/minus15s-focus.png",
      unfocused: "pkg:/images/fhd/Player_btns/minus15s-nofocus.png",
      pressed_focused: "pkg:/images/fhd/Player_btns/minus15s-focus.png",
      pressed_unfocused: "pkg:/images/fhd/Player_btns/minus15s-nofocus.png",
      disabled: "pkg:/images/fhd/Player_btns/minus15s-nofocus-inactive.png"
    },
    "plus15" :  {
      focused: "pkg:/images/fhd/Player_btns/plus15s-focus.png",
      unfocused: "pkg:/images/fhd/Player_btns/plus15s-nofocus.png",
      pressed_focused: "pkg:/images/fhd/Player_btns/plus15s-focus.png",
      pressed_unfocused: "pkg:/images/fhd/Player_btns/plus15s-nofocus.png",
      disabled: "pkg:/images/fhd/Player_btns/plus15s-nofocus-inactive.png"
    }
  }

end function

'Creates a UIButton
'@param String name
'@param Object vector2d [ width, height ]
'@return component or invalid UIButton
function UIButtonFactory( name as String, size as Object ) as Dynamic

  stateImages = buttonConfig()[name]
  button = invalid

  if ( isValid(stateImages) )
    button = CreateObject("roSGNode", "UIButton")
    button.id = name
    button.stateImages = stateImages
    button.size = size
  end if

  return button
end function
