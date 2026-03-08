package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_936 extends BaseMapProcess
   {
      
      public function MapProcess_936()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         SocketConnection.send(1022,86063360);
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_kenlai").initForMap(this);
      }
      
      override public function setup() : void
      {
         super.setup();
      }
      
      override public function destroy() : void
      {
         getDefinitionByName("com.robot.app2.mapProcess.control.WeeklyVSController_kenlai").destroy();
         super.destroy();
      }
   }
}

