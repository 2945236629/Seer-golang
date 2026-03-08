package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_694 extends BaseMapProcess
   {
      
      public function MapProcess_694()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["bloodMC"].visible = false;
         conLevel["guideMC"].visible = false;
         Task821.initForMap694(this);
      }
      
      override public function destroy() : void
      {
         Task821.destroy();
         super.destroy();
      }
   }
}

