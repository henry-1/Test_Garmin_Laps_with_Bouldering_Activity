import Toybox.Lang;
import Toybox.WatchUi;

class AddLapPoCDelegate extends WatchUi.BehaviorDelegate {

    hidden var _Start_Stop_Key = 4;
    hidden var _Back_Lap_Key = 5;
    hidden var _Menu_Up_Key = 13;
    hidden var _Menu_Up_Key_Long = 7;
    hidden var _Down_Key = 8;
    hidden var _Down_Key_Long = 22;

    hidden var _App;
    hidden var _Session as SessionController;

    function initialize() {
        BehaviorDelegate.initialize();
        _App = Application.getApp();
    }

    function onKey(keyEvent) {
        switch (keyEvent.getKey()) {
            case _Start_Stop_Key:
                if ((Toybox has :ActivityRecording && (_Session == null) || (_Session.isRecording() == false))){
                        _Session = new $.SessionController();
                        _Session.start();

                } else if ((Toybox has :ActivityRecording) && (_Session != null) && (_Session.isRecording() == true)) {
                        _Session.stop();
                }break;
            case _Back_Lap_Key:
                if ((_Session == null) || (_Session.isRecording() == false)) {
                        System.exit();
                }
                else{
                    return true;
                }break;
            default:
                return true;
        }
    }

    function Menu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new AddLapPoCMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}