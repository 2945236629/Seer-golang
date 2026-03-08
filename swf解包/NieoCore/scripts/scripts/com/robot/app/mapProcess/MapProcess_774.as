package com.robot.app.mapProcess
{
   import com.robot.app.control.AllManGeneralActionController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   
   public class MapProcess_774 extends BaseMapProcess
   {
      
      public function MapProcess_774()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86061813);
         AllManGeneralActionController.closeScene();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

