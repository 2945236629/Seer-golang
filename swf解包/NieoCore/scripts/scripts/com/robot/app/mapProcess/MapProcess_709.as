package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task925;
   import com.robot.core.manager.MapListenerManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.SocketConnection;
   import flash.utils.getDefinitionByName;
   
   public class MapProcess_709 extends BaseMapProcess
   {
      
      private var cls:*;
      
      public function MapProcess_709()
      {
         super();
      }
      
      override protected function init() : void
      {
         SocketConnection.send(1022,86060000);
         topLevel.mouseEnabled = false;
         topLevel.mouseChildren = false;
         this.cls = getDefinitionByName("com.robot.app2.mapProcess.control.activityControl.DevilSoulContainerController") as Class;
         this.cls.initForMap709(this);
         MapListenerManager.add(conLevel["xuanwo"],function():void
         {
            MapManager.changeMap(45);
         },"前往流火之地");
         Task925.initForMap709(this);
      }
      
      override public function destroy() : void
      {
         if(this.cls)
         {
            this.cls.destroy();
            this.cls = null;
         }
         Task925.destroy();
      }
   }
}

