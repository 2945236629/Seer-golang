package com.robot.app.mapProcess
{
   import com.robot.app.control.MiningcrystalController;
   import com.robot.core.manager.map.config.BaseMapProcess;
   
   public class MapProcess_1174 extends BaseMapProcess
   {
      
      public function MapProcess_1174()
      {
         super();
      }
      
      override protected function init() : void
      {
         MiningcrystalController.init(this,1);
      }
      
      override public function destroy() : void
      {
         MiningcrystalController.destroy(this);
         super.destroy();
      }
   }
}

