package com.robot.app.mapProcess
{
   import com.robot.app.task.taskscollection.Task947;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_712 extends BaseMapProcess
   {
      
      public function MapProcess_712()
      {
         super();
      }
      
      override protected function init() : void
      {
         topLevel.mouseChildren = false;
         topLevel.mouseEnabled = false;
         Task947.initForMap712(this);
      }
      
      override public function destroy() : void
      {
         Task947.destroy();
         super.destroy();
      }
   }
}

