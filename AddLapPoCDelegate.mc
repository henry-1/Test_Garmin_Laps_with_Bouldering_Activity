import Toybox.Lang;
import Toybox.WatchUi;

class AddLapPoCDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new AddLapPoCMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}