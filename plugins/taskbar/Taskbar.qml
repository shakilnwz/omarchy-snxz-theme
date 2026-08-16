import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "snxz.taskbar"
  
  implicitHeight: barSize
  implicitWidth: layout.implicitWidth
  visible: !vertical
  
  Row {
    id: layout
    anchors.verticalCenter: parent.verticalCenter
    spacing: Style.space(4)

    Repeater {
      model: ToplevelManager.toplevels.values
      
      delegate: Item {
        id: delegateRoot
        width: Style.space(32)
        height: root.barSize
        
        readonly property var toplevel: modelData
        readonly property bool isActive: toplevel === ToplevelManager.activeToplevel
        
        Rectangle {
          anchors.centerIn: parent
          width: parent.width - Style.space(4)
          height: width
          radius: Style.radius.medium
          color: isActive ? (root.bar ? root.bar.accentColor : Style.color.accent) : "transparent"
          opacity: isActive ? 0.2 : 0
        }

        Image {
          anchors.centerIn: parent
          width: Style.space(20)
          height: Style.space(20)
          source: toplevel.appId ? "image://icon/" + toplevel.appId : "image://icon/application-x-executable"
          fillMode: Image.PreserveAspectFit
          sourceSize.width: width * Screen.devicePixelRatio
          sourceSize.height: height * Screen.devicePixelRatio
        }
        
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
          cursorShape: Qt.PointingHandCursor
          
          onClicked: function(mouse) {
            if (mouse.button === Qt.RightButton || mouse.button === Qt.MiddleButton) {
              toplevel.close()
            } else {
              toplevel.activate()
            }
          }
          onEntered: if (root.bar) root.bar.showTooltip(delegateRoot, toplevel.title || toplevel.appId || "Window")
          onExited: if (root.bar) root.bar.hideTooltip(delegateRoot)
        }
      }
    }
  }
}
