package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.active.HallowmasSaveEdison;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_792 extends BaseMapProcess
   {
      
      public function MapProcess_792()
      {
         super();
      }
      
      override protected function init() : void
      {
         HallowmasSaveEdison.init(this);
      }
      
      override public function destroy() : void
      {
         HallowmasSaveEdison.destroy();
         super.destroy();
      }
   }
}

