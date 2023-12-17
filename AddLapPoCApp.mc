import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;


class AddLapPoCApp extends Application.AppBase {



    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        //_SessionController.start();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
       //_SessionController.stop();
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new AddLapPoCView(), new AddLapPoCDelegate() ] as Array<Views or InputDelegates>;
    }
}

function getApp() as AddLapPoCApp {
    return Application.getApp() as AddLapPoCApp;
}