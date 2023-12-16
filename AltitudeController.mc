
import Toybox.Lang;
import Toybox.Activity;

class AltitudeController {
    static function getCurrentAltitude() as Float {
        var altitude = Activity.getActivityInfo().altitude;
        return altitude == null ?  0 : altitude;
    }
}