package com.robot.app.mapProcess
{
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_454 extends BaseMapProcess
   {
      
      public function MapProcess_454()
      {
         super();
      }
      
      override protected function init() : void
      {
         this.conLevel["pointMC"].visible = false;
      }
      
      override public function destroy() : void
      {
      }
   }
}

