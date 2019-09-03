using Toybox.WatchUi;

class bikesimulatorDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new bikesimulatorMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}