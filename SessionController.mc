import Toybox.System;
import Toybox.ActivityRecording;
import Toybox.FitContributor;
import Toybox.Activity;
import Toybox.Lang;
import Toybox.Math;
import Toybox.WatchUi;

class SessionController {

    hidden var _Session;

    hidden var _fitFieldBoulder;             // chart of the boulder hight
    hidden var _fitFieldBoulderHight;        // highest boulder in a lap
    hidden var _fitFieldBoulderCount;

    hidden var _LapTimer;
    hidden var _LapTimerIndex = 0;
    hidden var _LapCounter = 0;

    hidden var _RandMaxHight = 0;
    hidden var _LapMaxHight = 0;

    function start() as Void {
        System.println("Session start");
        _Session.start();

        _LapTimer.start(method(:lapPoC), 2000, true);
    }

    function lapPoC () as Void {

        _RandMaxHight = Math.rand() % 900 + 100;
        System.println("RandMaxHight: " + _RandMaxHight.toString());

        if(_RandMaxHight > _LapMaxHight) {
            _LapMaxHight = _RandMaxHight;
        }

        _LapTimerIndex++;
        if(_LapTimerIndex > 20)
        {
            addLap();
            _LapTimerIndex = 0;
            _LapMaxHight = 0;
        }

        var altitude = AltitudeController.getCurrentAltitude();
        _fitFieldBoulder.setData(_RandMaxHight);
    }

    function addLap() as Void {
        System.println("Session addLap");
        System.println("Setting _fitFieldBoulderHight for Lap to: " + _LapMaxHight.toString());
        _fitFieldBoulderHight.setData(_LapMaxHight);
        var result = _Session.addLap();
        System.println("Added lap to session: " + result.toString());
        _LapCounter++;
    }

    function stop() as Void {
        System.println("Session stop");
        _Session.stop();
        //_fitFieldBoulder.setData(_RandMaxHight);
    	_fitFieldBoulderCount.setData(_LapCounter);
        System.println("Session save");
        _Session.save();
    }

    function initialize() {
        if(_Session == null) {

            _Session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Bouldering",                              // set session name
                        :sport=>Activity.SPORT_GENERIC,                // set sport type
                        :subSport=>Activity.SUB_SPORT_GENERIC          // set sub sport type
            });

/*
            _Session = ActivityRecording.createSession({
                :sport=>Activity.SPORT_ROCK_CLIMBING,
                :subSport=>Activity.SUB_SPORT_BOULDERING,
                :name=>"BoulderSession"
            });

*/
            _fitFieldBoulder = _Session.createField(
                WatchUi.loadResource(Rez.Strings.hight_label),   // field name
                0,                                               // filed ID
                FitContributor.DATA_TYPE_FLOAT,                  // type
                {
                    :mesgType=>FitContributor.MESG_TYPE_RECORD,
                    :units=>WatchUi.loadResource(Rez.Strings.hight_units)
                }
            );

            _fitFieldBoulderHight = _Session.createField(
                WatchUi.loadResource(Rez.Strings.hight_label),   // field name
                1,                                               // filed ID
                FitContributor.DATA_TYPE_FLOAT,                  // type
                {
                    :mesgType=>FitContributor.MESG_TYPE_LAP,
                    :units=>WatchUi.loadResource(Rez.Strings.hight_units)
                }
            );

            _fitFieldBoulderCount = _Session.createField(
                WatchUi.loadResource(Rez.Strings.counter_label), // field name
                2,                                               // filed ID
                FitContributor.DATA_TYPE_FLOAT,                  // type
                {
                    :mesgType=>FitContributor.MESG_TYPE_SESSION,
                    :units=>WatchUi.loadResource(Rez.Strings.counter_units)
                }
            );

            _LapTimer = new Timer.Timer();
        }
    }
}