package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task1360;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_722 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_722()
      {
         super();
      }
      
      override protected function init() : void
      {
         Task1360.initForMap722(this);
         SocketConnection.send(1022,86062065);
         this.setStatus();
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.DevilSoulContainerWaterController") as Class;
         this.cls.initForMap722(this);
      }
      
      private function setStatus() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
      }
      
      override public function destroy() : void
      {
         Task1360.destroy();
         if(this.cls)
         {
            this.cls.destroy();
            this.cls = null;
         }
         super.destroy();
      }
   }
}

