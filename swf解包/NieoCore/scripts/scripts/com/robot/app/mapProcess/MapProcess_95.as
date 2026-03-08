package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   
   public class MapProcess_95 extends BaseMapProcess
   {
      
      public function MapProcess_95()
      {
         super();
      }
      
      override protected function init() : void
      {
         MapListenerManager.add(this.depthLevel["goMapBtn"],function():void
         {
            MapManager.changeMap(932);
         },"元素之灵");
         SocketConnection.send(1022,86060179);
         Task5519.initForTaskMap95(this);
      }
      
      override public function destroy() : void
      {
         Task5519.destroy();
      }
   }
}

